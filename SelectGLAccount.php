<?php
/* $Id$*/

include('includes/session.inc');

$title = _('Search GL Accounts');

include('includes/header.inc');

$msg='';
unset($result);

if (isset($_POST['Select'])) {

	$result = DB_query("SELECT accountname FROM chartmaster WHERE accountcode=" . $_POST['Select'],$db);
	$myrow = DB_fetch_array($result);
	echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/magnifier.png" title="' . _('Search') . '" alt="" />' . ' ' . _('Search for General Ledger Accounts') . '</p>';

	echo '<div class="page_help_text">' . _('Account Code') . ' <b>' . $_POST['Select'] . ' - ' . $myrow['accountname']  . ' </b>' . _('has been selected') . '. <br />' . _('Select one of the links below to operate using this Account') . '.</div>';
	$AccountID = $_POST['Select'];
	$_POST['Select'] = NULL;

	echo '<br /><div class="centre"><a href="' . $rootpath . '/GLAccounts.php?SelectedAccount=' . $AccountID . '">' . _('Edit Account') . '</a>';
	echo '<br /><a href="' . $rootpath . '/GLAccountInquiry.php?Account=' . $AccountID . '">' . _('Account Inquiry') . '</a>';
	echo '<br /><a href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '">' . _('New Search') . '</a></div>';

} elseif (isset($_POST['Search'])){

	if (mb_strlen($_POST['Keywords']>0) and mb_strlen($_POST['GLCode'])>0) {
		$msg=_('Account name keywords have been used in preference to the account code extract entered');
	}
	if ($_POST['Keywords']=='' and $_POST['GLCode']=='') {
		$msg=_('At least one Account Name keyword OR an extract of an Account Code must be entered for the search');
	} else {
		If (mb_strlen($_POST['Keywords'])>0) {
			//insert wildcard characters in spaces
			$SearchString = '%' . str_replace(' ', '%', $_POST['Keywords']) . '%';

			$SQL = "SELECT chartmaster.accountcode,
					chartmaster.accountname,
					chartmaster.group_,
					CASE WHEN accountgroups.pandl!=0
						THEN '" . _('Profit and Loss') . "'
						ELSE '" . _('Balance Sheet') . "' END AS pl
				FROM chartmaster,
					accountgroups
				WHERE chartmaster.group_ = accountgroups.groupname
				AND accountname " . LIKE  . " '$SearchString'
				ORDER BY accountgroups.sequenceintb,
					chartmaster.accountcode";

		} elseif (mb_strlen($_POST['GLCode'])>0 AND is_numeric($_POST['GLCode'])){

			$SQL = "SELECT chartmaster.accountcode,
					chartmaster.accountname,
					chartmaster.group_,
					CASE WHEN accountgroups.pandl!=0 THEN '" . _('Profit and Loss') . "' ELSE '" . _('Balance Sheet') ."' END AS pl
					FROM chartmaster,
						accountgroups
					WHERE chartmaster.group_=accountgroups.groupname
					AND chartmaster.accountcode >= '" . $_POST['GLCode'] . "'
					ORDER BY chartmaster.accountcode";
		} elseif(!is_numeric($_POST['GLCode'])){
			prnMsg(_('The general ledger code specified must be numeric - all account numbers must be numeric'),'warn');
			unset($SQL);
		}

		if (isset($SQL) and $SQL!=''){
			$result = DB_query($SQL, $db);
		}
	} //one of keywords or GLCode was more than a zero length string
} //end of if search

if (!isset($AccountID)) {


	echo '<p class="page_title_text"><img src="'.$rootpath.'/css/'.$theme.'/images/magnifier.png" title="' . _('Search') . '" alt="" />' .
		' ' . _('Search for General Ledger Accounts') . '</p>';
	echo '<br /><form action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" method="post">';
	echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';

	if(mb_strlen($msg)>1){
		prnMsg($msg,'info');
	}

	echo '<table cellpadding="3" class="selection">
		<tr>
		<td><font size="1">' . _('Enter extract of text in the Account name') .':</font></td>
		<td><input type="text" name="Keywords" size="20" maxlength="25" /></td>
		<td><font size="3"><b>' .  _('OR') . '</b></font></td>
		<td><font size="1">' . _('Enter Account No. to search from') . ':</font></td>
		<td><input type="text" name="GLCode" size="15" maxlength="18" class="number" /></td>
		</tr>
		</table><br />';

	echo '<div class="centre"><button type="submit" name="Search">' . _('Search Now') . '</button>
		<button type="submit">' . _('Reset') .'</button></div>';

	if (isset($result) and DB_num_rows($result)>0) {

		echo '<br /><table cellpadding="2" class="selection">';

		echo '<tr>
				<th>' . _('Code') . '</th>
				<th>' . _('Account Name') . '</th>
				<th>' . _('Group') . '</th>
				<th>' . _('Account Type') . '</th>
			</tr>';

		while ($myrow=DB_fetch_array($result)) {

			printf('<tr><td><font size="1"><button type="submit" name="Select" value="%s" />%s</button></font></td>
				<td><font size="1">%s</font></td>
				<td><font size="1">%s</font></td>
				<td><font size="1">%s</font></td>
				</tr>',
				$myrow['accountcode'],
				$myrow['accountcode'],
				$myrow['accountname'],
				$myrow['group_'],
				$myrow['pl']);

		}
//end of while loop

		echo '</table>';

	}
//end if results to show

	echo '</form>';

} //end AccountID already selected

include('includes/footer.inc');
?>