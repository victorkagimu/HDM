<?php

$PageSecurity = 11;
include('includes/session.inc');
$title = _('Suggested Purchase orders');

include('includes/header.inc');

$sql='select locstock.loccode, locstock.stockid, stockmaster.description,
		locstock.quantity, locstock.reorderlevel from locstock left join stockmaster on
		 locstock.stockid=stockmaster.stockid where quantity<reorderlevel';
$result=DB_query($sql, $db);

echo '<center><table><tr><th>'. _('Location').
		'</th><th>'._('Stock ID').'</th><th>'._('Description').'</th><th>'.
		_('Quantity').'</th><th>'._('Reorder Level').'</th></tr>';
while ($myrow=DB_fetch_array($result)) {
	echo '<tr><td>'.$myrow[0].'</td><td>'.$myrow[1].'</td><td>'.$myrow[2].'</td><td style="text-align:right">'.
			$myrow[3].'</td><td style="text-align:right">'.$myrow[4].'</td></tr>';
}
echo '</table></center>';

include('includes/footer.inc')
?>