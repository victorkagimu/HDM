<?php
$PageSecurity=1;

include ('includes/session.inc');
$title = _('Update zero value stock issues');
include('includes/header.inc');

echo "<center><FORM METHOD='POST' ACTION=" . $_SERVER['PHP_SELF'] . '?' . SID . '>';
if (!isset($_POST['Process'])){

	echo "<INPUT TYPE=SUBMIT Name='Process' Value='" . _('Do the Transactions') . "'   onclick=\"return confirm('" . _('Are you sure?') . '\');"></FORM>';
echo '</center>';
} else {  /*OK do the updates */
	
// TYPE 14
	
	$sql='SELECT gltrans.typeno, 
			gltrans.account,
			gltrans.narrative,
			materialcost,
			(case left(account,1) when 4 then -1 when 1 then 1 when 2 then -1 end)*qty*materialcost as value 
		FROM stockmoves LEFT JOIN stockmaster 
		ON stockmoves.stockid=stockmaster.stockid 
		LEFT JOIN gltrans 
		ON stockmoves.transno=gltrans.typeno AND gltrans.type=stockmoves.type 
		WHERE price=0 AND gltrans.type=14 AND amount=0 AND materialcost>0';
	$result=DB_query($sql,$db);
	
	$counter=0;
	while ($myrow=DB_fetch_array($result)) {
		$transid[$counter]=$myrow;
		$counter++;
	}
	for ($i=0;$i<sizeOf($transid);$i++) {
		$transid[$i]['narrative']=str_replace('0.0000', $transid[$i]['materialcost'],$transid[$i]['narrative']);
		echo $transid[$i]['typeno'].' ';
		echo $transid[$i]['account'].' ';
		echo $transid[$i]['narrative'].' ';
		echo $transid[$i]['materialcost'].' ';
		echo $transid[$i]['value'].'<br>';
		$sql='UPDATE gltrans 
			SET amount='.$transid[$i]['value'].',
			narrative="'.$transid[$i]['narrative'].'"
			WHERE typeno='.$transid[$i]['typeno'].'
			AND account='.$transid[$i]['account'].'
			AND type=14';
		$result=DB_query($sql,$db);
	}

// TYPE 25
	
	$sql='SELECT gltrans.typeno, 
			gltrans.account,
			gltrans.narrative,
			materialcost,
			(case left(account,1) when 4 then -1 when 1 then 1 when 2 then -1 end)*qty*materialcost as value 
		FROM stockmoves LEFT JOIN stockmaster 
		ON stockmoves.stockid=stockmaster.stockid 
		LEFT JOIN gltrans 
		ON stockmoves.transno=gltrans.typeno AND gltrans.type=stockmoves.type 
		WHERE price=0 AND gltrans.type=25 AND amount=0 AND materialcost>0';
	$result=DB_query($sql,$db);
	
	$counter=0;
	while ($myrow=DB_fetch_array($result)) {
		$transid25[$counter]=$myrow;
		$counter++;
	}
	for ($i=0;$i<sizeOf($transid25);$i++) {
		$transid25[$i]['narrative']=str_replace('0.00', $transid25[$i]['materialcost'],$transid25[$i]['narrative']);
		echo $transid25[$i]['typeno'].' ';
		echo $transid25[$i]['account'].' ';
		echo $transid25[$i]['narrative'].' ';
		echo $transid25[$i]['materialcost'].' ';
		echo $transid25[$i]['value'].'<br>';
		$sql="UPDATE gltrans 
			SET amount=".$transid25[$i]['value'].",
			narrative='".$transid25[$i]['narrative']."'
			WHERE typeno=".$transid25[$i]['typeno'].'
			AND account='.$transid25[$i]['account'].'
			AND type=25';
		$result=DB_query($sql,$db);
	}
}
include('includes/footer.inc');
?>