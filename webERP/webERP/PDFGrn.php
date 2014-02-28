<?php
/* $Revision: 1.2 $ */

$PageSecurity = 2;
include('includes/session.inc');

$PaperSize = 'A4_Landscape';
include('includes/PDFStarter.php');

$FontSize=10;
$pdf->addinfo('Title', _('Goods Received Note') );

$PageNumber=1;
$line_height=12;


include('includes/PDFGrnHeader.inc');

$FontSize =10;
/*Print out the category totals */

$sql='SELECT grns.itemcode, grns.grnno, grns.deliverydate, grns.itemdescription, grns.qtyrecd, grns.supplierid, purchorderdetails.unitprice from grns inner join purchorderdetails on purchorderdetails.podetailitem=grns.podetailitem where grnbatch='.
	$_GET['GRNNo'];
$result=DB_query($sql, $db);
$counter=1;
while ($myrow=DB_fetch_array($result)) {
	$StockID=$myrow[0];
	$GRNNo=$myrow[1];
	$Date=$myrow[2];
	$Description=$myrow[3];
	$Quantity=$myrow[4];
	$SupplierID=$myrow[5];
	$UnitCost=$myrow[6];
	
	$sql='select suppname from suppliers where supplierid="'.$SupplierID.'"';
	$supplierresult=DB_query($sql, $db);
	$suppliermyrow=DB_fetch_array($supplierresult);
	$Supplier=$suppliermyrow[0];

	$LeftOvers = $pdf->addTextWrap($Left_Margin+1,$YPos-(10*$counter),70,$FontSize, $StockID);
	$LeftOvers = $pdf->addTextWrap($Left_Margin+75,$YPos-(10*$counter),175,$FontSize, $Description);
	$LeftOvers = $pdf->addTextWrap($Left_Margin+250,$YPos-(10*$counter),250-$Left_Margin,$FontSize, $Date);
	$LeftOvers = $pdf->addTextWrap($Left_Margin+315,$YPos-(10*$counter),150,$FontSize, $Supplier);
	$LeftOvers = $pdf->addTextWrap($Left_Margin+525,$YPos-(10*$counter),250-$Left_Margin,$FontSize, $Quantity);
	$LeftOvers = $pdf->addTextWrap($Left_Margin+575,$YPos-(10*$counter),150-$Left_Margin,$FontSize, number_format($UnitCost,2));
	$LeftOvers = $pdf->addTextWrap($Left_Margin+625,$YPos-(10*$counter),150-$Left_Margin,$FontSize, number_format($UnitCost*$Quantity,2));
	$counter = $counter + 1;
}

$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos-(10*$counter+80),300-$Left_Margin,$FontSize, _('Date of Receipt: ').$Date);

$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos-(10*$counter+130),300-$Left_Margin,$FontSize, _('Signed for ').$From.'______________________');
$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos-(10*$counter+170),300-$Left_Margin,$FontSize, _('Signed for ').$From.'______________________');
$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos-(10*$counter+210),300-$Left_Margin,$FontSize, _('Signed for ').$From.'______________________');

$pdfcode = $pdf->output();
$len = strlen($pdfcode);

if ($len<=20){
	$title = _('Print Price List Error');
	include('includes/header.inc');
	prnMsg(_('There were no stock transfer details to print'),'warn');
	echo '<BR><A HREF="'.$rootpath.'/index.php?' . SID . '">'. _('Back to the menu').'</A>';
	include('includes/footer.inc');
	exit;
} else {
	header('Content-type: application/pdf');
	header('Content-Length: ' . $len);
	header('Content-Disposition: inline; filename=GRN.pdf');
	header('Expires: 0');
	header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
	header('Pragma: public');

	$pdf->Stream();
}


 /*end of else not PrintPDF */
?>
