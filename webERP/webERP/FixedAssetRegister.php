<?php

$PageSecurity = 11;

/* Session started in header.inc for password checking and authorisation level check */
include('includes/session.inc');

$title = _('Fixed Asset Register');
include('includes/header.inc');

if (!isset($_GET['New'])) {
	if (!isset($_POST['Update'])) {
		echo '<a href ="'.$_SERVER['PHP_SELF'].'?New=yes">Create new asset</a>';
	
		$sql='select * from fixedassets';
		$result=DB_query($sql, $db);

		echo '<center><table>';
		echo '<tr><th>Asset ID</th><th>Description</th><th>Cost</th>
			<th>Department</th>
			<th>Months left</th><th>Date Purchased</th><th>Disposed of</th></tr>';

		echo '</center></table>';
	} else {
		
	}
} else {
	echo '<FORM ACTION="' . $_SERVER['PHP_SELF'] . '?' . SID . '" METHOD=POST>';
	echo '<center><table>';
	echo '<tr><td>Description</td><td><input type=text name=description></td></tr>';
	echo '<tr><td>Cost</td><td><input type=text name=cost></td></tr>';
	echo '<tr><td>Department</td><td><input type=text name=department></td></tr>';
	echo '<tr><td>Months to depreciate</td><td><input type=text name=months></td></tr>';
	echo '<tr><td>Date Purchased</td><td><input type=text name=purchased></td></tr>';
	echo '</center></table>';
	echo '<CENTER><INPUT TYPE=SUBMIT NAME=Update Value=' . _('Update') . '></form>';
}

include('includes/footer.inc');

?>