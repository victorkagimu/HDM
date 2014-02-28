<?php

$PageSecurity=15;
include ("includes/session.inc");

$title = _('UTILITY PAGE That sets up the drug type for use in Care2x');

$Care2xDatabase=$_POST['Care2xDatabase'];

include("includes/header.inc");

echo '<form method="post" action=' . $_SERVER['PHP_SELF'] . '?' . SID . '>';
echo '<table><tr><td>'. _('Care2x Database name').'</td><td><select name="Care2xDatabase">';
$sql='SHOW databases';
$result=DB_query($sql, $db);
while ($myrow=DB_fetch_array($result)) {
	echo '<option value="'.$myrow['Database'].'">'.$myrow['Database'].'</option>';
}
echo '</select>';

echo '<tr><td>'. _('Price List 1').'</td><td><select name="PriceList1">';
$sql='SELECT * FROM salestypes';
$result=DB_query($sql, $db);
while ($myrow=DB_fetch_array($result)) {
	echo '<option value="'.$myrow['typeabbrev'].'">'.$myrow['sales_type'].'</option>';
}
echo '</select>';

echo '</td></tr>';

echo '<tr><td>'. _('Price List 2').'</td><td><select name="PriceList2">';
$sql='SELECT * FROM salestypes';
$result=DB_query($sql, $db);
while ($myrow=DB_fetch_array($result)) {
	echo '<option value="'.$myrow['typeabbrev'].'">'.$myrow['sales_type'].'</option>';
}
echo '</select>';

echo '</td></tr>';

echo '<tr><td>'. _('Price List 3').'</td><td><select name="PriceList3">';
$sql='SELECT * FROM salestypes';
$result=DB_query($sql, $db);
while ($myrow=DB_fetch_array($result)) {
	echo '<option value="'.$myrow['typeabbrev'].'">'.$myrow['sales_type'].'</option>';
}
echo '</select>';

echo '</td></tr>';

echo '<tr><td>'. _('Price List 4').'</td><td><select name="PriceList4">';
$sql='SELECT * FROM salestypes';
$result=DB_query($sql, $db);
while ($myrow=DB_fetch_array($result)) {
	echo '<option value="'.$myrow['typeabbrev'].'">'.$myrow['sales_type'].'</option>';
}
echo '</select>';

echo '</td></tr>';

echo '</table><div class="centre"><input type="submit" name="submit" value="' . _('Update') . '" /></div>';
echo '</form>';

if (isset($_POST['submit'])) {
	$sql="DELETE FROM stockitemproperties";
	$result=DB_query($sql, $db);

	$sql="SELECT stockid FROM stockmaster WHERE description LIKE '%inj%' and categoryid='A'";
	$result=DB_query($sql, $db);
	$i=0;
	while ($myrow=DB_fetch_array($result)) {
		$injections[$i]=$myrow['stockid'];
		$i++;
	}

	for ($i=0; $i<sizeOf($injections);$i++) {
		$sql="INSERT INTO stockitemproperties VALUES('".$injections[$i]."',1,'Injections')";
		$result=DB_query($sql, $db);
	}

	$sql="SELECT stockid FROM stockmaster WHERE description LIKE '%tab%' and categoryid='A'";
	$result=DB_query($sql, $db);
	$i=0;
	while ($myrow=DB_fetch_array($result)) {
		$tablets[$i]=$myrow['stockid'];
		$i++;
	}

	for ($i=0; $i<sizeOf($tablets);$i++) {
		$sql="INSERT INTO stockitemproperties VALUES('".$tablets[$i]."',1,'Tablets')";
		$result=DB_query($sql, $db);
	}

	$sql="SELECT stockid FROM stockmaster WHERE description LIKE '%caps%' and categoryid='A'";
	$result=DB_query($sql, $db);
	$i=0;
	while ($myrow=DB_fetch_array($result)) {
		$capsules[$i]=$myrow['stockid'];
		$i++;
	}

	for ($i=0; $i<sizeOf($capsules);$i++) {
		$sql="INSERT INTO stockitemproperties VALUES('".$capsules[$i]."',1,'Tablets')";
		$result=DB_query($sql, $db);
	}

	$sql="SELECT stockid FROM stockmaster WHERE description LIKE '%syr%' and categoryid='A'";
	$result=DB_query($sql, $db);
	$i=0;
	while ($myrow=DB_fetch_array($result)) {
		$syrups[$i]=$myrow['stockid'];
		$i++;
	}

	for ($i=0; $i<sizeOf($syrups);$i++) {
		$sql="INSERT INTO stockitemproperties VALUES('".$syrups[$i]."',1,'Syrups')";
		$result=DB_query($sql, $db);
	}

	$sql="SELECT stockmaster.stockid FROM stockmaster 
		LEFT JOIN stockitemproperties ON stockmaster.stockid=stockitemproperties.stockid 
		WHERE categoryid='A' AND value IS NULL;";
	$result=DB_query($sql, $db);
	$i=0;
	while ($myrow=DB_fetch_array($result)) {
		$others[$i]=$myrow['stockid'];
		$i++;
	}

	for ($i=0; $i<sizeOf($others);$i++) {
		$sql="INSERT INTO stockitemproperties VALUES('".$others[$i]."',1,'Others')";
		$result=DB_query($sql, $db);
	}

	$sql="SELECT stockid, description FROM stockmaster WHERE categoryid='AO'";
	$result=DB_query($sql, $db);
	$i=0;
	while ($myrow=DB_fetch_array($result)) {
		$bigops[$i]=$myrow['stockid'];
		$bigopsdesc[$i]=$myrow['description'];
		$i++;
	}
	
	$sql="SELECT stockid, description FROM stockmaster WHERE categoryid='A'";
	$result=DB_query($sql, $db);
	$i=0;
	while ($myrow=DB_fetch_array($result)) {
		$medicines[$i]=$myrow['stockid'];
		$meddesc[$i]=$myrow['description'];
		$pricesql='SELECT price FROM prices WHERE stockid="'.$medicines[$i].'" and typeabbrev='.$_POST['PriceList1'];
		$priceresult=DB_query($pricesql, $db);
		if (DB_num_rows($priceresult)==0) {
			$medprice1[$i]=0;
		} else {
			$pricerow=DB_fetch_array($priceresult);
			$medprice1[$i]=$pricerow['price'];
		}
		$pricesql='SELECT price FROM prices WHERE stockid="'.$medicines[$i].'" and typeabbrev='.$_POST['PriceList2'];
		$priceresult=DB_query($pricesql, $db);
		if (DB_num_rows($priceresult)==0) {
			$medprice2[$i]=0;
		} else {
			$pricerow=DB_fetch_array($priceresult);
			$medprice2[$i]=$pricerow['price'];
		}
		$pricesql='SELECT price FROM prices WHERE stockid="'.$medicines[$i].'" and typeabbrev='.$_POST['PriceList3'];
		$priceresult=DB_query($pricesql, $db);
		if (DB_num_rows($priceresult)==0) {
			$medprice3[$i]=0;
		} else {
			$pricerow=DB_fetch_array($priceresult);
			$medprice3[$i]=$pricerow['price'];
		}
		$pricesql='SELECT price FROM prices WHERE stockid="'.$medicines[$i].'" and typeabbrev='.$_POST['PriceList4'];
		$priceresult=DB_query($pricesql, $db);
		if (DB_num_rows($priceresult)==0) {
			$medprice4[$i]=0;
		} else {
			$pricerow=DB_fetch_array($priceresult);
			$medprice4[$i]=$pricerow['price'];
		}
		$i++;
	}

	if (mysqli_select_db($db,$Care2xDatabase)) {
		$sql="delete from care_tz_drugsandservices where purchasing_class='drug_list'";
		$result=DB_query($sql, $db);
		for ($i=0; $i<sizeOf($medicines);$i++) {
			$sql="INSERT into care_tz_drugsandservices 
				VALUES(null,'".$medicines[$i]."','".$medicines[$i]."',0,0,0,1,0,'".
				$meddesc[$i]."','".$meddesc[$i]."',".$medprice1[$i].",".$medprice2[$i].",".$medprice3[$i].
				",".$medprice4[$i].",'drug_list')";
			$result=DB_query($sql, $db);
		}
	} else {
		prnMsg('Cannot connect to Care2x database', 'error');
	}

	if (mysqli_select_db($db,$Care2xDatabase)) {
		$sql="delete from care_tz_drugsandservices where purchasing_class='bigops'";
		$result=DB_query($sql, $db);
		for ($i=0; $i<sizeOf($medicines);$i++) {
			$sql="INSERT into care_tz_drugsandservices 
				VALUES(null,'".$bigops[$i]."','".$bigops[$i]."',0,0,0,1,0,'".
				$bigopsdesc[$i]."','".$bigopsdesc[$i]."',".$medprice1[$i].",".$medprice2[$i].",".$medprice3[$i].
				",".$medprice4[$i].",'bigops')";
			$result=DB_query($sql, $db);
		}
	} else {
		prnMsg('Cannot connect to Care2x database', 'error');
	}
}
include("includes/footer.inc");

?>