<?php

$PageSecurity = 10;
include('includes/session.inc');
$title = _('Reports by tag for a specified date range');

include('includes/header.inc');

if (isset($_POST['submit'])) {
	$sql='select type, 
			trandate, 
			account, 
			narrative, 
			amount
			FROM gltrans WHERE jobref="'.$_POST['tag'].'" AND
			periodno between '.$_POST['from'] .' and '.$_POST['to'];
			
	$result=DB_query($sql, $db);
	
	echo '<center><table><tr>';
	echo '<th>'. _('Type') .'</th>
			<th>'. _('Date') .'</th>
			<th>'. _('Account') .'</th>
			<th>'. _('Narrative') .'</th>
			<th>'. _('Amount') .'</th></tr>';
			
	while ($myrow=DB_fetch_array($result)){
		$typesql='SELECT typename from systypes where typeid='.$myrow['type'];
		$typeresult=DB_query($typesql, $db);
		$typerow=DB_fetch_array($typeresult);
		echo '<tr><td>'.$typerow['typename'].'</td>';
		echo '<td>'.$myrow['trandate'].'</td>';
		$accountsql='SELECT accountname from chartmaster where accountcode='.$myrow['account'];
		$accountresult=DB_query($accountsql, $db);
		$accountrow=DB_fetch_array($accountresult);
		echo '<td>'.$myrow['account'].' - '. $accountrow['accountname'].'</td>';
		echo '<td>'.$myrow['narrative'].'</td>';
		echo '<td style="text-align:right">'.number_format(-$myrow['amount'],2).'</td></tr>';
	}
	echo '</table>';
} else {

	echo "<center><FORM METHOD='post' action=" . $_SERVER['PHP_SELF'] . '?' . SID . '>';
	
	//Select tag
	echo '<table><tr><td>' . _('Select Tag') . ':</td>
		<td><select name="tag">';

	$SQL = 'SELECT tagref, 
					tagdescription 
			FROM tags 
			ORDER BY tagref';
			
	$result=DB_query($SQL,$db);
	if (DB_num_rows($result)==0){
	   echo '</select></td></tr>';
	   prnMsg(_('No Tags have been set up yet') . ' - ' . _('postings cannot be analysed against a tag until the ag is set up'),'error');
	} else {
		while ($myrow=DB_fetch_array($result)){
		    if ($_POST['tag']==$myrow["tagrefref"]){
			echo '<OPTION selectED value=' . $myrow['tagref'] . '>' . $myrow['tagref'] . ' - ' . $myrow['tagdescription'];
		    } else {
			echo '<OPTION value=' . $myrow['tagref'] . '>' . $myrow['tagref'] . ' - ' . $myrow['tagdescription'];
		    }
		}
		echo '</select></td></tr>';
	}
	// End select tag
	
	//select From period
	$sql = 'SELECT periodno, lastdate_in_period from periods order by periodno desc';
	$result=DB_query($sql,$db);
	
	echo '<tr><td>' . _('From Period') . ':</td><td><select name="from">';	

	while ($myrow=DB_fetch_array($result)){
	    if ($_POST['project']==$myrow["projectref"]){
			echo '<OPTION selectED value=' . $myrow['periodno'] . '>' . MonthAndYearFromSQLDate($myrow['lastdate_in_period']);
	    } else {
			echo '<OPTION value=' . $myrow['periodno'] . '>' . MonthAndYearFromSQLDate($myrow['lastdate_in_period']);
	    }
	}
	echo '</select></td></tr>';
	
	$sql = 'SELECT periodno, lastdate_in_period from periods';
	$result=DB_query($sql,$db);
	echo '<tr><td>' . _('To Period') . ':</td><td><select name="to">';	

	while ($myrow=DB_fetch_array($result)){
	    if ($_POST['project']==$myrow["projectref"]){
			echo '<OPTION selectED value=' . $myrow['periodno'] . '>' . MonthAndYearFromSQLDate($myrow['lastdate_in_period']);
	    } else {
			echo '<OPTION value=' . $myrow['periodno'] . '>' . MonthAndYearFromSQLDate($myrow['lastdate_in_period']);
	    }
	}
	echo '</select></td></tr></table>';

	echo '<input type=Submit name=submit value=' . _('Enter') . '>';

	echo '</form></center>';
}

include('includes/footer.inc');

?>