<?php


$PageSecurity = 8;
include ('includes/session.inc');
$title = _('Cash Flow Report');
include('includes/header.inc');

if (isset($_POST['Show'])) {
	if (is_date($_POST['from']) and is_date($_POST['to'])) {
		$sql='select typeno, 
			chequeno, 
			trandate, 
			narrative, 
			amount 
			from gltrans where 
			trandate between "'.FormatDateForSQL($_POST['from']).'" and "'.FormatDateForSQL($_POST['to']) .
			'" and account='.$_POST['bank'];
		$result=DB_query($sql, $db);
		echo '<center><table>';
		echo '<tr><th>'. _('Transaction').'</th><th>'._('Cheque No').'</th><th>'.
	 		_('Date') .'</th><th>'. _('Narrative'). '</th><th>'. _('Amount').'</th></tr>';
		while ($myrow=DB_fetch_array($result)) {
			echo '<tr><td>'.$myrow[0].'</td><td>'.
			$myrow[1].'</td><td>'.$myrow[2].'</td><td>'.
			$myrow[3].'</td><td style="text-align:right">'.number_format($myrow[4],2).'</td></tr>';
		}
		echo '</table></center>';
	} else {
		prnMsg(_('The dates entered are not valid, please re-enter'), 'error');
		unset($_POST['Show']);
	}
}
if (!isset($_POST['Show'])) {

	$sql='select accountcode, bankaccountname from bankaccounts';
	$result=DB_query($sql, $db);

	echo '<center><FORM METHOD="POST" ACTION=' . $_SERVER['PHP_SELF'] . '?' . SID . '><table>';

	echo '<tr><td>Select Bank Account</td><td><select name=bank>';

	while ($myrow=DB_fetch_array($result)) {
		echo '<option value="'.$myrow[0].'">'.$myrow[1];
	}
	echo '</select></td></tr>';
	echo '<tr><td>'._('Transactions from').'</td><td><input type="text" name="from"></td></tr>';
	echo '<tr><td>'._('Transactions to').'</td><td><input type="text" name="to"></td></tr>';
	echo '</table>';
	echo '<INPUT TYPE=SUBMIT NAME="Show" VALUE="'._('Show Account Transactions').'"></CENTER></FORM>';
	echo '</form></center>';
}
include('includes/footer.inc');

?>