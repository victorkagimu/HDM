<?php

$PageSecurity = 10;

$PathPrefix=dirname(__FILE__).'/../';
include('../includes/session.inc');
include('../includes/SQL_CommonFunctions.inc');

$rootpath = dirname($_SERVER['PHP_SELF']).'/..';

$title = _('Payment Voucher');

include('../includes/header.inc');

echo '<center><table>';

$VoucherNo=GetNextTransNo(100, $db);

echo '<tr><td>'._('Voucher Number').'</td><td align=right>'.$VoucherNo.'</td></tr>';

echo '<tr><td>'._('Date').'</td><td><input type="text" value="'.date('d/m/Y').'" size=10></td></tr>';
echo '<tr><td>'._('Description').'</td><td><textarea cols=40 rows=5></textarea></td></tr>';
echo '<tr><td>'._('Value').'</td><td><input type="text" value="" size=20></td></tr>';

echo '</table></center>';

include('../includes/footer.inc');
?>
