<?php

/* $Id$*/

include('includes/session.inc');

$title = _('Access Permission Maintenance');
include('includes/header.inc');

echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/group_add.png" title="' . _('Search') . '" alt="" />' . ' ' . $title.'</p>';

if (isset($_GET['SelectedRole'])){
	$SelectedRole = $_GET['SelectedRole'];
} elseif (isset($_POST['SelectedRole'])){
	$SelectedRole = $_POST['SelectedRole'];
}

if (!isset($_POST['CanViewPrices'])) {
	$_POST['CanViewPrices']=0;
}

if (isset($_POST['submit']) or isset($_GET['remove']) or isset($_GET['add']) ) {

	//initialise no input errors assumed initially before we test
	$InputError = 0;

	/* actions to take once the user has clicked the submit button
	ie the page has called itself with some user input */
	//first off validate inputs sensible
	if (isset($_POST['SecRoleName']) and mb_strlen($_POST['SecRoleName'])<4){
		$InputError = 1;
		prnMsg(_('The role description entered must be at least 4 characters long'),'error');
	}

	// if $_POST['SecRoleName'] then it is a modifications on a SecRole
	// else it is either an add or remove of a page token
	unset($sql);
	if (isset($_POST['SecRoleName']) ){ // Update or Add Security Headings
		if(isset($SelectedRole)) { // Update Security Heading
			$sql = "UPDATE securityroles
					SET secrolename = '".$_POST['SecRoleName']."',
						canviewprices='".$_POST['CanViewPrices']."'
					WHERE secroleid = '".$SelectedRole . "'";
			$ErrMsg = _('The update of the security role description failed because');
			$ResMsg = _('The Security role description was updated.');
		} else { // Add Security Heading
			$sql = "INSERT INTO securityroles (secrolename, canviewprices) VALUES ('".$_POST['SecRoleName']."', '".$_POST['CanViewPrices']."')";
			$ErrMsg = _('The update of the security role failed because');
			$ResMsg = _('The Security role was created.');
		}
		unset($_POST['SecRoleName']);
		unset($SelectedRole);
	} elseif (isset($SelectedRole) ) {
		$PageTokenId = $_GET['PageToken'];
		if( isset($_GET['add']) ) { // updating Security Groups add a page token
			$sql = "INSERT INTO securitygroups (secroleid,
												tokenid
											) VALUES (
												'".$SelectedRole."',
												'".$PageTokenId."'
											)";
			$ErrMsg = _('The addition of the page group access failed because');
			$ResMsg = _('The page group access was added.');
		} elseif ( isset($_GET['remove']) ) { // updating Security Groups remove a page token
			$sql = "DELETE FROM securitygroups
					WHERE secroleid = '".$SelectedRole."'
					AND tokenid = '".$PageTokenId . "'";
			$ErrMsg = _('The removal of this page-group access failed because');
			$ResMsg = _('This page-group access was removed.');
		}
		unset($_GET['add']);
		unset($_GET['remove']);
		unset($_GET['PageToken']);
	}
	// Need to exec the query
	if (isset($sql) and $InputError != 1 ) {
		$result = DB_query($sql,$db,$ErrMsg);
		if( $result ) {
			prnMsg( $ResMsg,'success');
		}
	}
} elseif (isset($_GET['delete'])) {
	//the Security heading wants to be deleted but some checks need to be performed fist
	// PREVENT DELETES IF DEPENDENT RECORDS IN 'www_users'
	$sql= "SELECT COUNT(*) FROM www_users WHERE fullaccess='" . $_GET['SelectedRole'] . "'";
	$result = DB_query($sql,$db);
	$myrow = DB_fetch_row($result);

	if ($myrow[0]>0) {
		prnMsg( _('Cannot delete this role because user accounts are setup using it'),'warn');
		echo '<br />' . _('There are') . ' ' . $myrow[0] . ' ' . _('user accounts that have this security role setting') . '</font>';
	} else {
		$sql="DELETE FROM securitygroups WHERE secroleid='" . $_GET['SelectedRole'] . "'";
		$result = DB_query($sql,$db);
		$sql="DELETE FROM securityroles WHERE secroleid='" . $_GET['SelectedRole'] . "'";
		$result = DB_query($sql,$db);
		prnMsg( $_GET['SecRoleName'] . ' ' . _('security role has been deleted') . '!','success');

	} //end if account group used in GL accounts
	unset($SelectedRole);
	unset($_GET['SecRoleName']);
}

if (!isset($SelectedRole)) {

/* If its the first time the page has been displayed with no parameters then none of the above are true and the list of Users will be displayed with links to delete or edit each. These will call the same page again and allow update/input or deletion of the records*/

	$sql = "SELECT secroleid,
					secrolename,
					canviewprices
				FROM securityroles
				ORDER BY secrolename";
	$result = DB_query($sql,$db);

	echo '<table class="selection">';
	echo '<tr>
			<th>' . _('Role') . '</th>
			<th>' . _('Can view') . '<br />' . _('prices') . '</th>
		</tr>';

	$k=0; //row colour counter

	while ($myrow = DB_fetch_array($result)) {
		if ($k==1){
			echo '<tr class="EvenTableRows">';
			$k=0;
		} else {
			echo '<tr class="OddTableRows">';
			$k=1;
		}

		if ($myrow['canviewprices']==1) {
			$CanViewPrices = _('Yes');
		} else {
			$CanViewPrices = _('No');
		}

		/*The SecurityHeadings array is defined in config.php */

		printf('<td>%s</td>
				<td>%s</td>
				<td><a href="%s?SelectedRole=%s">' . _('Edit') . '</a></td>
				<td><a href="%s?SelectedRole=%s&delete=1&SecRoleName=%s">' . _('Delete') . '</a></td>
				</tr>',
				$myrow['secrolename'],
				$CanViewPrices,
				htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') ,
				$myrow['secroleid'],
				htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') ,
				$myrow['secroleid'],
				urlencode($myrow['secrolename']));

	} //END WHILE LIST LOOP
	echo '</table>';
} //end of ifs and buts!


if (isset($SelectedRole)) {
	echo '<br /><div class="centre"><a href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') .'">' . _('Review Existing Roles') . '</a></div>';
}

if (isset($SelectedRole)) {
	//editing an existing role

	$sql = "SELECT secroleid,
			secrolename,
			canviewprices
		FROM securityroles
		WHERE secroleid='" . $SelectedRole . "'";
	$result = DB_query($sql, $db);
	if ( DB_num_rows($result) == 0 ) {
		prnMsg( _('The selected role is no longer available.'),'warn');
	} else {
		$myrow = DB_fetch_array($result);
		$_POST['SelectedRole'] = $myrow['secroleid'];
		$_POST['SecRoleName'] = $myrow['secrolename'];
		$_POST['CanViewPrices'] = $myrow['canviewprices'];
	}
}
echo '<br />';
echo '<form method="post" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
if( isset($_POST['SelectedRole'])) {
	echo '<input type="hidden" name="SelectedRole" value="' . $_POST['SelectedRole'] . '" />';
}
echo '<table class="selection">';
if (!isset($_POST['SecRoleName'])) {
	$_POST['SecRoleName']='';
}
if (!isset($_POST['CanViewPrices'])) {
	$_POST['CanViewPrices']=0;
}
echo '<tr>
		<td>' . _('Role') . ':</td>
		<td><input type="text" name="SecRoleName" size="40" maxlength="40" value="' . $_POST['SecRoleName'] . '" />
	</tr>';
if ($_POST['CanViewPrices']==1) {
	echo '<tr>
			<td>' . _('User can view prices') . ':</td>
			<td><input type="checkbox" name="CanViewPrices" checked="checked" value="1" />
		</tr>';
} else {
	echo '<tr>
			<td>' . _('User can view prices') . ':</td>
			<td><input type="checkbox" name="CanViewPrices" value="1" />
		</tr>';
}

echo '</table><br />
	<div class="centre"><button type="submit" name="submit">' . _('Enter Role') . '</button></div></form>';

if (isset($SelectedRole)) {
	$sql = "SELECT tokenid, tokenname
			FROM securitytokens";

	$sqlUsed = "SELECT tokenid FROM securitygroups WHERE secroleid='". $SelectedRole . "'";

	$Result = DB_query($sql, $db);

	/*Make an array of the used tokens */
	$UsedResult = DB_query($sqlUsed, $db);
	$TokensUsed = array();
	$i=0;
	while ($myrow=DB_fetch_array($UsedResult)){
		$TokensUsed[$i] =$myrow['tokenid'];
		$i++;
	}

	echo '<br /><table class="selection"><tr>';

	if (DB_num_rows($Result)>0 ) {
		echo '<th colspan="3"><div class="centre">'._('Assigned Security Tokens').'</div></th>';
		echo '<th colspan="3"><div class="centre">'._('Available Security Tokens').'</div></th>';
	}
	echo '</tr>';

	$k=0; //row colour counter
	while($AvailRow = DB_fetch_array($Result)) {

		if ($k==1){
			echo '<tr class="EvenTableRows">';
			$k=0;
		} else {
			echo '<tr class="OddTableRows">';
			$k=1;
		}

		if (in_array($AvailRow['tokenid'],$TokensUsed)){
			printf('<td>%s</td>
					<td>%s</td>
					<td><a href="%s?SelectedRole=%s&remove=1&PageToken=%s">' . _('Remove') . '</a></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>',
					$AvailRow['tokenid'],
					$AvailRow['tokenname'],
					htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') ,
					$SelectedRole,
					$AvailRow['tokenid']
				);
		} else {
			printf('<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>%s</td>
					<td>%s</td>
					<td><a href="%sSelectedRole=%s&add=1&PageToken=%s">' . _('Add') . '</a></td>',
					$AvailRow['tokenid'],
					$AvailRow['tokenname'],
					htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8')  . '?',
					$SelectedRole,
					$AvailRow['tokenid'] );
		}
		echo '</tr>';
	}
	echo '</table>';
}

include('includes/footer.inc');

?>