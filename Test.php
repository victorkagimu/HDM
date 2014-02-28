<?php


include('includes/PDFStarter.php');
$pdf->addinfo('Title', _('Price Listing Report') );
$pdf->addinfo('Subject', _('Price List') );
include('includes/PDFPriceListPageHeader.inc');

?>