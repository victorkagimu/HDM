<?php

/* $Id$*/
/* $Revision: 1.11 $ */

include('includes/session.inc');
include('includes/SQL_CommonFunctions.inc');

//Get Out if we have no order number to work with
If (!isset($_GET['QuotationNo']) or $_GET['QuotationNo']==""){
		$title = _('Select Quotation To Print');
		include('includes/header.inc');
		echo '<div class="centre"><br /><br /><br />';
		prnMsg( _('Select a Quotation to Print before calling this page') , 'error');
		echo '<br /><br /><br /><table class="table_index"><tr><td class="menu_group_item">
				<li><a href="'. $rootpath . '/SelectSalesOrder.php?Quotations=Quotes_Only">' . _('Quotations') . '</a></li>
				</td></tr></table></div><br /><br /><br />';
		include('includes/footer.inc');
		exit();
}

/*retrieve the order details from the database to print */
$ErrMsg = _('There was a problem retrieving the quotation header details for Order Number') . ' ' . $_GET['QuotationNo'] . ' ' . _('from the database');

$sql = "SELECT salesorders.customerref,
				salesorders.comments,
				salesorders.orddate,
				salesorders.deliverto,
				salesorders.deladd1,
				salesorders.deladd2,
				salesorders.deladd3,
				salesorders.deladd4,
				salesorders.deladd5,
				salesorders.deladd6,
				debtorsmaster.name,
				debtorsmaster.address1,
				debtorsmaster.address2,
				debtorsmaster.address3,
				debtorsmaster.address4,
				debtorsmaster.address5,
				debtorsmaster.address6,
				debtorsmaster.currcode,
				shippers.shippername,
				salesorders.printedpackingslip,
				salesorders.datepackingslipprinted,
				salesorders.branchcode,
				locations.taxprovinceid,
				locations.locationname
			FROM salesorders,
				debtorsmaster,
				shippers,
				locations
			WHERE salesorders.debtorno=debtorsmaster.debtorno
				AND salesorders.shipvia=shippers.shipper_id
				AND salesorders.fromstkloc=locations.loccode
				AND salesorders.quotation=1
				AND salesorders.orderno='" . $_GET['QuotationNo'] ."'";

$result=DB_query($sql,$db, $ErrMsg);

//If there are no rows, there's a problem.
if (DB_num_rows($result)==0){
		$title = _('Print Quotation Error');
		include('includes/header.inc');
		 echo '<div class="centre"><br /><br /><br />';
		prnMsg( _('Unable to Locate Quotation Number') . ' : ' . $_GET['QuotationNo'] . ' ', 'error');
		echo '<br /><br /><br /><table class="table_index"><tr><td class="menu_group_item">
				<li><a href="'. $rootpath . '/SelectSalesOrder.php?Quotations=Quotes_Only">' . _('Outstanding Quotations') . '</a></li>
				</td></tr></table></div><br /><br /><br />';
		include('includes/footer.inc');
		exit;
} elseif (DB_num_rows($result)==1){ /*There is only one order header returned - thats good! */

		$myrow = DB_fetch_array($result);
}

/*retrieve the order details from the database to print */

/* Then there's an order to print and its not been printed already (or its been flagged for reprinting/ge_Width=807;
)
LETS GO */
$PaperSize = 'A4_Landscape';
include('includes/PDFStarter.php');
$pdf->addInfo('Title', _('Customer Quotation') );
$pdf->addInfo('Subject', _('Quotation') . ' ' . $_GET['QuotationNo']);
$FontSize=12;
$PageNumber = 1;
$line_height=15;
// $pdf->selectFont('./fonts/Helvetica.afm');

/* Now ... Has the order got any line items still outstanding to be invoiced */

$ErrMsg = _('There was a problem retrieving the quotation line details for quotation Number') . ' ' .
	$_GET['QuotationNo'] . ' ' . _('from the database');

$sql = "SELECT salesorderdetails.stkcode,
				stockmaster.description,
				salesorderdetails.quantity,
				salesorderdetails.qtyinvoiced,
				salesorderdetails.unitprice,
				salesorderdetails.discountpercent,
				stockmaster.taxcatid,
				stockmaster.decimalplaces,
				salesorderdetails.narrative
			FROM salesorderdetails
			INNER JOIN stockmaster
			ON salesorderdetails.stkcode=stockmaster.stockid
			WHERE salesorderdetails.orderno='" . $_GET['QuotationNo'] . "'";

$result=DB_query($sql,$db, $ErrMsg);

$ListCount = 0; // UldisN

if (DB_num_rows($result)>0){
	/*Yes there are line items to start the ball rolling with a page header */
	include('includes/PDFQuotationPageHeader.inc');

	$QuotationTotal =0;
	$QuotationTotalEx=0;
	$TaxTotal=0;

	while ($myrow2=DB_fetch_array($result)){

		$ListCount ++;

		if ((mb_strlen($myrow2['narrative']) >200 AND $YPos-$line_height <= 75)
			OR (mb_strlen($myrow2['narrative']) >1 AND $YPos-$line_height <= 62)
			OR $YPos-$line_height <= 50){
		/* We reached the end of the page so finsih off the page and start a newy */
			$PageNumber++;
			include ('includes/PDFQuotationPageHeader.inc');

		} //end if need a new page headed up

		$DisplayQty = locale_number_format($myrow2['quantity'],$myrow2['decimalplaces']);
		$DisplayPrevDel = locale_number_format($myrow2['qtyinvoiced'],$myrow2['decimalplaces']);
		$DisplayPrice = locale_money_format($myrow2['unitprice'],$myrow['currcode']);
		$DisplayDiscount = locale_number_format($myrow2['discountpercent']*100,2) . '%';
		$SubTot =  $myrow2['unitprice']*$myrow2['quantity']*(1-$myrow2['discountpercent']);
		$TaxProv = $myrow['taxprovinceid'];
		$TaxCat = $myrow2['taxcatid'];
		$Branch = $myrow['branchcode'];
		$sql3 = "SELECT taxgrouptaxes.
						taxauthid
					FROM taxgrouptaxes
					INNER JOIN custbranch
					ON taxgrouptaxes.taxgroupid=custbranch.taxgroupid
					WHERE custbranch.branchcode='" .$Branch ."'";
		$result3=DB_query($sql3,$db, $ErrMsg);
		while ($myrow3=DB_fetch_array($result3)){
			$TaxAuth = $myrow3['taxauthid'];
		}

		$sql4 = "SELECT taxrate
					FROM taxauthrates
					WHERE dispatchtaxprovince='" .$TaxProv ."'
						AND taxcatid='" .$TaxCat ."'
						AND taxauthority='" .$TaxAuth ."'";
		$result4=DB_query($sql4,$db, $ErrMsg);
		while ($myrow4=DB_fetch_array($result4)){
			$TaxClass = 100 * $myrow4['taxrate'];
		}

		$DisplayTaxClass = $TaxClass . "%";
		$TaxAmount =  (($SubTot/100)*(100+$TaxClass))-$SubTot;
		$DisplayTaxAmount = locale_money_format($TaxAmount,$myrow['currcode']);

		$LineTotal = $SubTot + $TaxAmount;
		$DisplayTotal = locale_money_format($LineTotal,$myrow['currcode']);

		$FontSize=10;

		$LeftOvers = $pdf->addTextWrap($XPos+1,$YPos,100,$FontSize,$myrow2['stkcode']);
		$LeftOvers = $pdf->addTextWrap(145,$YPos,295,$FontSize,$myrow2['description']);
		$LeftOvers = $pdf->addTextWrap(420,$YPos,85,$FontSize,$DisplayQty,'right');
		$LeftOvers = $pdf->addTextWrap(485,$YPos,85,$FontSize,$DisplayPrice,'right');
		if ($DisplayDiscount > 0){
		$LeftOvers = $pdf->addTextWrap(535,$YPos,85,$FontSize,$DisplayDiscount,'right');
		}
		$LeftOvers = $pdf->addTextWrap(585,$YPos,85,$FontSize,$DisplayTaxClass,'right');
		$LeftOvers = $pdf->addTextWrap(650,$YPos,85,$FontSize,$DisplayTaxAmount,'right');
		$LeftOvers = $pdf->addTextWrap(700,$YPos,90,$FontSize,$DisplayTotal,'right');
		if (mb_strlen($myrow2['narrative'])>1){
			$YPos -= ($line_height);
			$LeftOvers = $pdf->addTextWrap($XPos+1,$YPos,870,$FontSize,$myrow2['narrative']);
			if (mb_strlen($LeftOvers) >1){
				$YPos -= 11;
				$LeftOvers = $pdf->addTextWrap($XPos+1,$YPos,870,$FontSize,$LeftOvers);
			}
		}
		$QuotationTotal +=$LineTotal;
		$QuotationTotalEx +=$SubTot;
		$TaxTotal +=$TaxAmount;

		/*increment a line down for the next line item */
		$YPos -= ($line_height);

	} //end while there are line items to print out

	if ((mb_strlen($myrow['comments']) >200 AND $YPos-$line_height <= 75)
			OR (mb_strlen($myrow['comments']) >1 AND $YPos-$line_height <= 62)
			OR $YPos-$line_height <= 50){
		/* We reached the end of the page so finish off the page and start a newy */
			$PageNumber++;
			include ('includes/PDFQuotationPageHeader.inc');
	} //end if need a new page headed up

	$YPos -= ($line_height);
	$LeftOvers = $pdf->addTextWrap(40,$YPos,655,$FontSize,_('Total Tax'),'right');
	$LeftOvers = $pdf->addTextWrap(700,$YPos,90,$FontSize, locale_money_format($TaxTotal,$myrow['currcode']),'right');
	$YPos -= 12;
	$LeftOvers = $pdf->addTextWrap(40,$YPos,655,$FontSize,_('Quotation Excluding Tax'),'right');
	$LeftOvers = $pdf->addTextWrap(700,$YPos,90,$FontSize, locale_money_format($QuotationTotalEx,$myrow['currcode']),'right');
	$YPos -= 12;
	$LeftOvers = $pdf->addTextWrap(40,$YPos,655,$FontSize,_('Quotation Including Tax'),'right');
	$LeftOvers = $pdf->addTextWrap(700,$YPos,90,$FontSize, locale_money_format($QuotationTotal,$myrow['currcode']),'right');

	$YPos -= ($line_height);
	$LeftOvers = $pdf->addTextWrap($XPos,$YPos,20,10,_('Notes:'));
	$LeftOvers = $pdf->addTextWrap($XPos+28,$YPos,800,10,$myrow['comments']);

	if (mb_strlen($LeftOvers)>1){
		$YPos -= 10;
		$LeftOvers = $pdf->addTextWrap($XPos,$YPos,850,10,$LeftOvers);
		if (mb_strlen($LeftOvers)>1){
			$YPos -= 10;
			$LeftOvers = $pdf->addTextWrap($XPos,$YPos,850,10,$LeftOvers);
			if (mb_strlen($LeftOvers)>1){
				$YPos -= 10;
				$LeftOvers = $pdf->addTextWrap($XPos,$YPos,850,10,$LeftOvers);
				if (mb_strlen($LeftOvers)>1){
					$YPos -= 10;
					$LeftOvers = $pdf->addTextWrap($XPos,$YPos,850,10,$FontSize,$LeftOvers);
				}
			}
		}
	}
} /*end if there are line details to show on the quotation*/

if ($ListCount == 0){
		$title = _('Print Quotation Error');
		include('includes/header.inc');
		echo '<br />'. _('There were no items on the quotation') . '. ' . _('The quotation cannot be printed').
				'<br /><a href="' . $rootpath . '/SelectSalesOrder.php?Quotation=Quotes_only">'. _('Print Another Quotation').
				'</a>' . '<br />'. '<a href="' . $rootpath . '/index.php">' . _('Back to the menu') . '</a>';
		include('includes/footer.inc');
	exit;
} else {
	$pdf->OutputI($_SESSION['DatabaseName'] . '_Quotation_' . date('Y-m-d') . '.pdf');//UldisN
	$pdf->__destruct(); //UldisN
}
?>