<?php



if (function_exists(VerifyDebtorExists) == "") 
{
  function VerifyDebtorExists($DebtorNumber, $i, $Errors, $db) {
		$Searchsql = "SELECT count(debtorno) 
				FROM debtorsmaster
				WHERE debtorno='".$DebtorNumber."'";
		$SearchResult=DB_query($Searchsql, $db);
		$answer = DB_fetch_array($SearchResult);
		if ($answer[0]==0) {
			$Errors[$i] = DebtorDoesntExist;
		}
		return $Errors;
	}
}



/* Check that the address lines are correct length*/		

if (function_exists(VerifyDebtorExists) == "")
{
	function VerifyAddressLine($AddressLine, $length, $i, $Errors) {
		if (strlen($AddressLine)>$length) {
			$Errors[$i] = InvalidAddressLine;
		}
		return $Errors;
	}
}


	/* Check that the address lines are correct length*/		

if (function_exists(VerifyDebtorExists) == "")
{
	function VerifyEstDeliveryDays($EstDeliveryDays, $i, $Errors) {
		if (!is_numeric($EstDeliveryDays)) {
			$Errors[$i] = InvalidEstDeliveryDays;			
		}
		return $Errors;
		}
}		





?>
