<?php
/* $Revision: 1.1 $ */

$PageSecurity = 2;
include('includes/session.inc');


include('includes/PDFStarter.php');

$FontSize=10;
$pdf->addinfo('Title', _('Stock Issue Form') );

$PageNumber=1;
$line_height=15;


include('includes/PDFStockIssueHeader.inc');

$FontSize =10;
/*Print out the category totals */

$sql='SELECT stockid, transno, loccode, trandate, qty, tagref, reference from stockmoves where transno='.
	$_GET['TransferNo'].' and type=14';
$result=DB_query($sql, $db);
$YPos-=10;
$myrow=DB_fetch_array($result);
do{
	$StockID=$myrow[0];
	$FromCode=$myrow[2];
	$Date=$myrow[3];
	$Quantity=$myrow[4];
	$Tag=$myrow[5];
	$Reference=$myrow[6];

	$sql='select description from stockmaster where stockid="'.$StockID.'"';

	$resultdesc=DB_query($sql, $db);
	$myrowdesc=DB_fetch_array($resultdesc);
	$Description=$myrowdesc[0];

	$sql='select locationname from locations where loccode="'.$FromCode.'"';
	$resultlocname=DB_query($sql, $db);
	$myrowlocname=DB_fetch_array($resultlocname);
	$From=$myrowlocname[0];

	//$pdf->addTextWrap($Left_Margin,$YPos,100,$FontSize,$TransferRow['stockid'], 'left');

	$LeftOvers = $pdf->addTextWrap($Left_Margin+1,$YPos,100,$FontSize, $StockID, 'left');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+75,$YPos,200,$FontSize, $Description, 'left');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+250,$YPos,60,$FontSize, $Tag, 'left');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+350,$YPos,200,$FontSize, $From, 'left');
	$LeftOvers = $pdf->addTextWrap($Left_Margin+475,$YPos,60,$FontSize, -$Quantity, 'left');
	
	$pdf->line($Left_Margin, $YPos-2,$Page_Width-$Right_Margin, $YPos-2);
	
	$YPos -= $line_height;
	

} while($myrow=DB_fetch_array($result));

$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos-70,300-$Left_Margin,$FontSize, _('Narrative: ').$Reference);
$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos-100,300-$Left_Margin,$FontSize, _('Date of Issue: ').$Date);

$LeftOvers = $pdf->addTextWrap($Left_Margin,$YPos-150,300-$Left_Margin,$FontSize, _('Signed for ').$From.'_______________________');

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
	header('Content-Disposition: inline; filename=StockIssue.pdf');
	header('Expires: 0');
	header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
	header('Pragma: public');

	$pdf->Stream();
}


 /*end of else not PrintPDF */
?>