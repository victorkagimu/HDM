<?php
$PageSecurity = 11;

include('includes/session.inc');
$title = _('Outstanding Purchase Orders');
include('includes/header.inc');

$sql='select * from purchorderdetails where quantityrecd=0 and deliverydate<now()';
$result=DB_query($sql, $db);

echo '<center><table>';
echo '<tr>';
echo '<th>'. _('Order No') . '</th>';
echo '<th>'. _('Item') . '</th>';
echo '<th>'. _('Description') . '</th>';
echo '<th>'. _('Quantity Ordered') . '</th>';
echo '<th>'. _('Quantity Received') . '</th>';
echo '<th>'. _('Due Date') . '</th></tr>';

while ($myrow=DB_fetch_array($result, $db)) {
	echo '<tr>';
	echo '<td>'.$myrow['orderno'].'</td>';
	echo '<td>'.$myrow['itemcode'].'</td>';
	echo '<td>'.$myrow['itemdescription'].'</td>';
	echo '<td align=right>'.$myrow['quantityord'].'</td>';
	echo '<td align=right>'.$myrow['quantityrecd'].'</td>';
	echo '<td>'.ConvertSQLDate($myrow['deliverydate']).'</td>';

	echo '</tr>';
}
echo '</table></center>';
include('includes/footer.inc');
