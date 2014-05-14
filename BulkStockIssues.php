<?php

include('includes/DefineStockAdjustment.php');
include('includes/DefineSerialItems.php');

$PageSecurity = 11;
include('includes/session.inc');
$title = _('Bulk Stock Issues');

include('includes/header.inc');
include('includes/SQL_CommonFunctions.inc');

//var_dump($_POST);
//var_dump($_SESSION['Adjustment']);

if (($_POST['EnterAdjustment']='Clear Fields')){
	unset($_POST['EnterMoreItems']);
	for ($i=$_POST['LinesCounter']-10;$i<$_POST['LinesCounter'];$i++){
		unset($_POST['StockID' . $i]);
		unset($_POST['StockQtty' . $i]);
		unset($_POST['ItemDescription' . $i]);
		unset($_POST['StockTag' . $i]);
	}
}

if (isset($_GET['NewAdjustment'])){
     unset($_SESSION['Adjustment']);
     $_SESSION['Adjustment'] = new StockAdjustment;
}

if (!isset($_SESSION['Adjustment'])){
     $_SESSION['Adjustment'] = new StockAdjustment;
}

//here defines code where the sytem clears and unsets all the variables in $_POST


$NewAdjustment = false;

if (isset($_GET['StockID'])){
	$NewAdjustment = true;
} elseif (isset($_POST['StockID0']) &&  $_POST['StockID0']!=''){	//there is atleast one item in the bulk transfer and it is not empty
	
	$NewAdjustment = true;
	$_SESSION['Adjustment']->Narrative = $_POST['Narrative'];
	$_SESSION['Adjustment']->StockLocation = $_POST['StockLocation'];
}



if ($NewAdjustment){ //
	$TotalItems=0;
 for($i=0; $i<$_POST['LinesCounter']; $i++)
 {
 	//TODO Check for sql injection in input
 	if ($_POST['StockID'.$i]!="")//if there is an item code for the item
 	{
 	$TotalItems++; //increment items to be saved
	$sql ="SELECT description,
				units,
				mbflag,
				materialcost+labourcost+overheadcost as standardcost,
				controlled,
				serialised,
				decimalplaces
			FROM stockmaster
			WHERE stockid='" . $_POST['StockID'.$i] . "'";
	$ErrMsg = _('Unable to load StockMaster info for part'). ':' . $_POST['StockID'.$i];
	$result = DB_query($sql, $db, $ErrMsg);
	$myrow = DB_fetch_row($result);

	if (DB_num_rows($result)==0){
		prnMsg( _('Unable to locate Stock Code').' '.$_POST['StockID'.$i], 'error' );
		unset($_SESSION['Adjustment']);
	} elseif (DB_num_rows($result)>0){

		$_POST['ItemDescription'.$i] = $myrow[0];
		$_POST['PartUnit'.$i] = $myrow[1];
		$_POST['StandardCost'.$i] = $myrow[3];
		$_POST['Controlled'.$i] = $myrow[4];
		$_POST['Serialised'.$i] = $myrow[5];
		$_POST['DecimalPlaces'.$i] = $myrow[6];
		$_POST['SerialItems'.$i] = array();

		if ($myrow[2]=='D' OR $myrow[2]=='A' OR $myrow[2]=='K'){
			prnMsg( _('The part entered is either or a dummy part or an assembly or kit-set part') . '. ' . _('These parts are not physical parts and no stock holding is maintained for them') . '. ' . _('Stock adjustments are therefore not possible'),'error');
			echo '<HR>';
			echo '<A HREF="'. $rootpath .'/StockAdjustments.php?' . SID .'">'. _('Enter another adjustment'). '</A>';
			unset ($_SESSION['Adjustment']);
			include ('includes/footer.inc');
			exit;
		}
	}
 }else {
 	//i should break out of the loop at this point, no more items to be entered
 	break; 
 }//end if item code is not empty
	
 }//end for loop
}//end if NewAdjustment

if (isset($_POST['EnterAdjustment']) && $_POST['EnterAdjustment']!= 'Cancel Issue' ||  $_POST['EnterAdjustment']!=''){ //always do this except for cancel stock issues-> wasting cpu time

	$InputError = false; /*Start by hoping for the best */
	//Declare Array for holding accumulated stock issues account, to go somewhere down so that we can get freedom
	$AccStockDetails=Array("StockID"=>"","StockQtty"=>0);
	//this will hold the accumulated stockdetails
	$AccStockItems=Array();
	for ($i=0; $i<$TotalItems; $i++){
	$result = DB_query("SELECT * FROM stockmaster WHERE stockid='" . $_POST['StockID'.$i]. "'",$db);
	$myrow = DB_fetch_row($result);
	if (DB_num_rows($result)==0) {
		prnMsg( _('The entered item code does not exist'),'error');
		$InputError = true;
	} 
	if (!is_numeric($_POST['StockQtty'.$i])){
		prnMsg( _('The quantity entered must be numeric'),'error');
		$InputError = true;
	} 
	if ($_POST['StockQtty'.$i]==0){
		prnMsg( _('The quantity entered cannot be zero') . '. ' . _('There would be no adjustment to make'),'error');
		$InputError = true;
	} 
	
	if ($_POST['Controlled'.$i]==1 AND count($_POST['SerialItems'.$i])==0) {
		prnMsg( _('The item entered is a controlled item that requires the detail of the serial numbers or batch references to be adjusted to be entered'),'error');
		$InputError = true;
	} 
	
	if ($_POST['StockTag'.$i]=='') {
		prnMsg( _('You must enter a tag for this transaction'),'error');
		$InputError = true;
	}

	//TODO Testing it now
	if ($_SESSION['ProhibitNegativeStock']==1){ //prohibit negative stock is set we need to get the-- ~Stephen
		$CheckQuantity=0;
		//check first that given stockid is not already among items already tested
		if(isset($AccStockItems)) //this will always evaluate to true, the else doesnt work
		{
			$max=sizeof($AccStockItems);
			$InAccStockItemsAlready=false;
			for($m=0; $m<$max; $m++)//should use a foreach loop no internet, cant get it right, cant waste time
			{
				if($AccStockItems['Item'.$m]['StockID']==$_POST['StockID'.$i])
				{
					$InAccStockItemsAlready=True;
					$AccStockItems['Item'.$m]['StockQtty']=$AccStockItems['Item'.$m]['StockQtty']+$_POST['StockQtty'.$i];
					$CheckQuantity=$AccStockItems['Item'.$m]['StockQtty'];
					 //need to check if we need to break, exit did not work just thru us ou of page
				}
			}
			
			if(!$InAccStockItemsAlready)//that upper loop was executed but the inner if was not
			{
				$AccStockDetails['StockID']=$_POST['StockID'.$i];
				$AccStockDetails['StockQtty']=$_POST['StockQtty'.$i];
				$AccStockItems['Item'.$max]=$AccStockDetails;
				$CheckQuantity=$_POST['StockQtty'.$i];
			}
		}//end if AccStockItems is set
		/*var_dump($AccStockItems);
		echo $_SESSION['Adjustment']->StockLocation;
		echo '<br> for stock location in post'. $_POST['StockLocation'];
		echo '<br> '.$_POST['StockID'.$i];*/
		//THE $SESSION IS VERY UNSTABLE IN ONE LOOP IT HAS STOCL LOCATION IN ANOTHER IT DOESN'T SUGGESTING IT IS NOT ASSIGNED PROPERLY
		
		
		$SQL = "SELECT quantity FROM locstock
				WHERE stockid='" . $_POST['StockID'.$i] . "'
				AND loccode='" . $_POST['StockLocation']. "'";
		$CheckNegResult=DB_query($SQL,$db);
		$CheckNegRow = DB_fetch_array($CheckNegResult);
		
		
				
		if (($CheckNegRow['quantity']-$CheckQuantity) <0){
			$InputError=true;
			prnMsg(_('The system parameters are set to prohibit negative stocks. Processing this stock adjustment would result in negative stock at this location. This adjustment will not be processed.'),'error');
		}
	}
}//end for loop
}//end if new Enter adjustment is set without cancel as value or an empty string as value

/**
 * this commented code below is for a confirm dialogue 
 * to reactivate it uncomment and ser the next if block cfr line 226 and change that to $_POST['EnterAdjustment']=='Confirm Stock Issue')
 */
/*if (!$InputError && ($_POST['EnterAdjustment']=='Enter Stock Issue') && $TotalItems>0) {//we have passed the values and the input can be repared for confirmation
	
		echo '<FORM ACTION="'. $_SERVER['PHP_SELF'] . '?' . SID . '" METHOD=POST>';
		echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
		echo '<input type="hidden" name="LinesCounter" value="'. $TotalItems .'" />';
		echo '<input type="hidden" name="StockLocation" value="'.  $_POST['StockLocation']  .'" />';
		echo '<input type="hidden" name="Narrative" value="'.  $_POST['Narrative']  .'" />';
		echo '<input type="hidden" name="issueddate" value="'.  $_POST['issueddate']  .'" />';
		//var_dump($_POST);
		echo '<center>Stock will be issued from location '. $_POST['StockLocation'] .' for '. $_POST['Narrative'].'<br><table>';
		 
		echo '<tr><th> Item Code</th><th> Description</th><th> Quantity</th><th> Issue Tag</th></tr>';
		
		
		for($i=0; $i<$TotalItems; $i++)
		{
			echo '<input type="hidden" name="SerialItems'.$i.'" value="'.  $_POST['SerialItems'.$i]  .'" />';
		echo '<tr><td><input type="text" name="StockID'.$i.'" size="21"  maxlength="20" value="' .$_POST['StockID'.$i]. '" /></td>
				<td><input type="text" name="ItemDescription'.$i .'" size="20"  maxlength="29" value="' .$_POST['ItemDescription'.$i]. '" /></td>
						<td><input type="text" name="StockQtty'.$i .'" size="20"  maxlength="29" value="' .$_POST['StockQtty'.$i]. '" /></td>
						<td><input type="text" name="StockTag'.$i .'" size="20"  maxlength="29" value="' .$_POST['StockTag'.$i].'" /></td></tr>';
		
		}
		
		
		echo '</table>';
		
		echo  '<INPUT TYPE=submit NAME="EnterAdjustment" VALUE="'. _('Confirm Issue').'"/><br><br>';
		echo  '<INPUT TYPE=submit NAME="EnterAdjustment" VALUE="'. _('Cancel Issue'). '"/></center>';
	//<INPUT TYPE=SUBMIT NAME="EnterAdjustment" VALUE="'. _('Confirm Stock Issue'). '">
		echo '</form>';
		include('includes/footer.inc');
		exit;
	
	
}*/

if(!$InputError && ($_POST['EnterAdjustment']=='Enter Stock Issue'))
{

	/*All inputs must be sensible so make the stock movement records and update the locations stocks */
	//TODO Check the importance of Adjustment No.
	//do we need to have every AdjustmentNumber be independent
	$AdjustmentNumber = GetNextTransNo(14,$db);
	$PeriodNo = GetPeriod ($_POST['issueddate'], $db);
	$tranDate=FormatDateForSQL($_POST['issueddate']);
	
	$SQL = 'BEGIN';//MOVE THIS BEGIN TO ANOTHER PLACE UP ABOVE
	$Result = DB_query($SQL,$db);
	for($i=0; $i<$TotalItems; $i++)
	{
		
		// Need to get the current location quantity will need it later for the stock movement
		$SQL="SELECT locstock.quantity
			FROM locstock
			WHERE locstock.stockid='" . $_POST['StockID'.$i]. "'
			AND loccode= '" . $_POST['StockLocation']. "'"; 
		
		$Result = DB_query($SQL, $db);
		if (DB_num_rows($Result)==1){
			$LocQtyRow = DB_fetch_row($Result);
			$QtyOnHandPrior = $LocQtyRow[0]; //this appears to get the quantity in the store
		} else {
			// There must actually be some error this should never happen
			$QtyOnHandPrior = 0;
		}

		//inserts into the stock moves table
		//remember the principle of atomicity
		//all transanctions should be run once and not insert into stock moves again and again
		
		$SQL = "INSERT INTO stockmoves (
				stockid,
				type,
				transno,
				loccode,
				trandate,
				prd,
				reference,
				qty,
				newqoh,
				tagref)
			VALUES (
				'" .  $_POST['StockID'.$i]. "',
				14,
				" . $AdjustmentNumber . ",
				'" . $_POST['StockLocation'] . "',
				'" . $tranDate . "',
				" . $PeriodNo . ",
				'" . $_POST['Narrative']."',
				" . - $_POST['StockQtty'.$i]. ",
				" . ($QtyOnHandPrior -  $_POST['StockQtty'.$i]) . ",'
				" . $_POST['StockTag'.$i]."'
			)";
		


		$ErrMsg =  _('CRITICAL ERROR') . '! ' . _('NOTE DOWN THIS ERROR AND SEEK ASSISTANCE') . ': ' . _('The stock movement record cannot be inserted because');
		$DbgMsg =  _('The following SQL to insert the stock movement record was used');
		$Result = DB_query($SQL, $db, $ErrMsg, $DbgMsg, true);


		/*Get the ID of the StockMove... */
		$StkMoveNo = DB_Last_Insert_ID($db,'stockmoves','stkmoveno'); //TODO this is done afresh for every item code. ASK Victor if this is okay

		/*Insert the StockSerialMovements and update the StockSerialItems  for controlled items*/

		if ($_POST['Controlled'.$i]==1){
			foreach($_POST['SerialItems'.$i] as $Item){
				/*We need to add or update the StockSerialItem record and
			 	The StockSerialMoves as well */

				/*First need to check if the serial items already exists or not */
				$SQL = "SELECT COUNT(*)
					FROM stockserialitems
					WHERE
					stockid='" . $_POST['StockID'.$i]. "'
					AND loccode='" .  $_POST['StockLocation'] . "'
					AND serialno='" . $Item->BundleRef . "'";
				$ErrMsg = _('Unable to determine if the serial item exists');
				$Result = DB_query($SQL,$db,$ErrMsg);
				$SerialItemExistsRow = DB_fetch_row($Result);

				if ($SerialItemExistsRow[0]==1){

					$SQL = "UPDATE stockserialitems SET
						quantity= quantity + " . $Item->BundleQty . "
						WHERE
						stockid='" . $_POST['StockID'.$i]. "'
						AND loccode='" .  $_POST['StockLocation'] . "'
						AND serialno='" . $Item->BundleRef . "'";

					$ErrMsg =  _('CRITICAL ERROR') . '! ' . _('NOTE DOWN THIS ERROR AND SEEK ASSISTANCE') . ': ' . _('The serial stock item record could not be updated because');
					$DbgMsg =  _('The following SQL to update the serial stock item record was used');
					$Result = DB_query($SQL, $db, $ErrMsg, $DbgMsg, true);
				} else {
					/*Need to insert a new serial item record */
					$SQL = "INSERT INTO stockserialitems (stockid,
									loccode,
									serialno,
									quantity)
						VALUES ('" .$_POST['StockID'.$i]. "',
						'" .  $_POST['StockLocation']. "',
						'" . $Item->BundleRef . "',
						" . $Item->BundleQty . ")";

					$ErrMsg =  _('CRITICAL ERROR') . '! ' . _('NOTE DOWN THIS ERROR AND SEEK ASSISTANCE') . ': ' . _('The serial stock item record could not be updated because');
					$DbgMsg =  _('The following SQL to update the serial stock item record was used');
					$Result = DB_query($SQL, $db, $ErrMsg, $DbgMsg, true);
				}


			/* now insert the serial stock movement */

				$SQL = "INSERT INTO stockserialmoves (stockmoveno,
									stockid,
									serialno,
									moveqty)
						VALUES (" . $StkMoveNo . ",
							'" . $_POST['StockID'.$i].  "',
							'" . $Item->BundleRef . "',
							" . $Item->BundleQty . ")";
				$ErrMsg =  _('CRITICAL ERROR') . '! ' . _('NOTE DOWN THIS ERROR AND SEEK ASSISTANCE') . ': ' . _('The serial stock movement record could not be inserted because');
				$DbgMsg =  _('The following SQL to insert the serial stock movement records was used');
				$Result = DB_query($SQL, $db, $ErrMsg, $DbgMsg, true);

			}/* foreach controlled item in the serialitems array */
		} /*end if the adjustment item is a controlled item */


		$SQL = "UPDATE locstock SET quantity = quantity - " . $_POST['StockQtty'.$i].  "
				WHERE stockid='" . $_POST['StockID'.$i].  "'
				AND loccode='" .  $_POST['StockLocation'] . "'";

		$ErrMsg = _('CRITICAL ERROR') . '! ' . _('NOTE DOWN THIS ERROR AND SEEK ASSISTANCE') . ': ' ._('The location stock record could not be updated because');
		$DbgMsg = _('The following SQL to update the stock record was used');

		$Result = DB_query($SQL, $db, $ErrMsg, $DbgMsg, true);

		if ($_SESSION['CompanyRecord']['gllink_stock']==1){

			$StockGLCodes = GetStockGLCode($_POST['StockID'.$i],$db);

			$SQL = "INSERT INTO gltrans (type,
							typeno,
							trandate,
							periodno,
							account,
							amount,
							narrative,
							tag)
					VALUES (14,
						" .$AdjustmentNumber . ",
						'" . FormatDateForSQL($_POST['issueddate']) . "',
						" . $PeriodNo . ",
						" .  $StockGLCodes['adjglact'] . ",
						" .$_POST['StandardCost'.$i] * ($_POST['StockID'.$i]) . ",	
						'" . $_POST['StockID'.$i].  " x " . $_POST['StockQtty'.$i].  " @ " . $_POST['StandardCost'.$i].  " " .  $_POST['Narrative'] . "','" .
						$_POST['StockTag'.$i].	"')";
			//TODO add a standard cost to the post attribute

			$ErrMsg = _('CRITICAL ERROR') . '! ' . _('NOTE DOWN THIS ERROR AND SEEK ASSISTANCE') . ': ' . _('The general ledger transaction entries could not be added because');
			$DbgMsg = _('The following SQL to insert the GL entries was used');
			$Result = DB_query($SQL,$db, $ErrMsg, $DbgMsg, true);

			$SQL = "INSERT INTO gltrans (type,
							typeno,
							trandate,
							periodno,
							account,
							amount,
							narrative)
					VALUES (14,
						" .$AdjustmentNumber . ",
						'" . FormatDateForSQL($_POST['issueddate']) . "',
						" . $PeriodNo . ",
						" .  $StockGLCodes['stockact'] . ",
						" . $_POST['StandardCost'.$i] * -$_POST['StockQtty'.$i].  ",
						'" . $_POST['StockID'.$i].  " x " . $_POST['StockQtty'.$i].  " @ " . $_POST['StandardCost'.$i].  " " .  $_POST['Narrative'] . "')";

			$Errmsg = _('CRITICAL ERROR') . '! ' . _('NOTE DOWN THIS ERROR AND SEEK ASSISTANCE') . ': ' . _('The general ledger transaction entries could not be added because');
			$DbgMsg = _('The following SQL to insert the GL entries was used');
			$Result = DB_query($SQL,$db, $ErrMsg, $DbgMsg,true);
		}
	}//end for each item in the list being issued out

	$Result = DB_query('COMMIT',$db);
	//TODO MAKE THIS IN AN ITERATIVE MANNER FOR EACH OF THESE
	prnMsg( _('A stock issue for'). ' ' .  $_POST['Narrative']. _('has been created from location').' ' .  $_POST['StockLocation'] .' success');
	echo '</br><a href="PDFBulkStockIssues.php?TransferNo='.$AdjustmentNumber.'">Print Stock Issue Note</a>';
	unset ($_SESSION['Adjustment']);
	//TODO  also unset _POST
}//end if input is error free

		
echo '<FORM ACTION="'. $_SERVER['PHP_SELF'] . '?' . SID . '" METHOD=POST>';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';


echo 
'<CENTER>
 <TABLE>
	<TR>
	<tr>
			
	<th>'. _('Issued From Stock At Location').':</th>
	<th>
		 <SELECT name="StockLocation"> ';
			$sql = 'SELECT loccode, locationname FROM locations';
			$resultStkLocs = DB_query($sql,$db);					
			while ($myrow=DB_fetch_array($resultStkLocs)){	
				if (isset($_SESSION['Adjustment']->StockLocation)){
					if ($myrow['loccode'] == $_SESSION['Adjustment']->StockLocation){
	   					echo '<OPTION SELECTED Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
					} else {
	   					echo '<OPTION Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
					}
				} elseif ($myrow['loccode']==$_SESSION['UserStockLocation']){
					echo '<OPTION SELECTED Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
					$_POST['StockLocation']=$myrow['loccode'];
	 						//ASSIGNS THE VALUE OF POST TO THE LOCATION
				} else {
 					echo '<OPTION Value="' . $myrow['loccode'] . '">' . $myrow['locationname'];
		 						//echo "ROW 2";
			   }
		    }//end while
						
					echo '</SELECT>
				</th>	
				<th>'._('Issued Date').'</th>
				<th><input type=text name=issueddate size=10 value="'.Date($_SESSION['DefaultDateFormat']).'"></th>
				</tr>';
				
				/*WHAT IS THIS DOING HERE*/
				if (!isset($_SESSION['Adjustment']->Narrative)) {
					$_SESSION['Adjustment']->Narrative = '';
				}
						
				echo '<TR>
					<th>'. _('Comments On Why').':</th>
					<th><input type=text name="Narrative" size=32 maxlength=30 value="' . $_SESSION['Adjustment']->Narrative . '"></th>
	 			</TR>';
				echo '</TABLE>';
	
		
		//THIS IS WHERE THE DATA PARSING BEGINS
		//WHEN IS THE NEW ADJUSTMENT SET IN THIS PIECE OF CODE, It is set when the submit button is called
		
		if (isset($_GET['NewAdjustment'])){// this get attribute
			unset($_SESSION['Adjustment']);
			$_SESSION['Adjustment'] = new StockAdjustment;
		}
		
		if (!isset($_SESSION['Adjustment'])){
			$_SESSION['Adjustment'] = new StockAdjustment;
		}
	
		
		
		//ascribe the global variables	
		$_SESSION['Adjustment']->Narrative = $_POST['Narrative'];
		$_SESSION['Adjustment']->StockLocation = $_POST['StockLocation'];
			
		echo '<TABLE>'; //the lower table
		$TableHeader = '<tr>
						<th >'. _('Item Code'). '</th>
						<th>'._('Description'). '</th>
						<th>'. _('Quantity'). '</th>
						<th>'._('Issue Tag'). '</th>
					</tr>';
		echo $TableHeader;
		
		//START THE NEW SYSTEM HERE IN
		
		$k=0; /* page heading row counter */
		$j=0; /* row counter for reindexing */
				
		
		$z=($j + 9); 
		//this is where the ystem is actually set in the programm at this point we know that the variables are not set
		if($_POST['EnterAdjustment']='Confirm Issue'){
			$_POST['Narrative']="";
		}
		while($j < $z) {
			if (!isset($_POST['StockID' . $j])) {
				$_POST['StockID' . $j]='';
				$_POST['StockQttY' . $j]=0;
				
				$DecimalPlaces=0;
			} else {
				$DecimalsSql = "SELECT decimalplaces
							FROM stockmaster
							WHERE stockid='" . $_POST['StockID' . $j] . "'";
				$DecimalResult = DB_Query($DecimalsSql, $db);
				$DecimalRow = DB_fetch_array($DecimalResult);
				$DecimalPlaces = $DecimalRow['decimalplaces'];
			}
			
			if($_POST['EnterAdjustment']='Confirm Issue')
			{
				if($_POST['StockID'.$j]!="")
				{
					$_POST['StockID'.$j]="";
					$_POST['ItemDescription'.$j]="";
					$_POST['StockQtty'.$j]="";
					$_POST['StockTag'.$j]="";
				}
			}
			
			echo '<tr>
			<td><input type="text" name="StockID' . $j .'" size="21"  maxlength="20" value="' . $_POST['StockID' . $j] . '" /></td>
				<td><input type="text" name="ItemDescription' . $j .'" size="20"  maxlength="29" value="' . $_POST['ItemDescription' . $j] . '" /></td>';
				//<td><input type="text" name="StockQTY' . $j .'" size="10" maxlength="10" class="number" value="' . locale_number_format($_POST['StockQTY' . $i],$DecimalPlaces) . '" /></td>';
				PostQttycheckControlled($j);
				SelectTag($j);
		echo '</tr>';
			$j++;
		}
		
	/*/confirm dialogue in php
	
/*	
for($j=0; $j<$_POST['LinesCounter']; $j++)
{
	if (isset($_SESSION['Adjustment']) and strlen($_POST['ItemDescription'])>1){
		echo '<TR><TD COLSPAN=3><FONT COLOR=BLUE SIZE=3>' . $_POST['ItemDescription'.$j] . ' ('._('In Units of').' ' . $_POST['PartUnit'.$j] . ' ) - ' . _('Unit Cost').' = ' . $_POST['StandardCost'.$i] . '</FONT></TD></TR>';
	}
}*/



echo '</TABLE>
			<BR>
				<input type="hidden" name="LinesCounter" value="'. $j .'" />
				<INPUT TYPE=SUBMIT NAME="EnterAdjustment" VALUE="'. _('Enter Stock Issue'). '">';
		echo '  ';
						echo '<INPUT TYPE=SUBMIT NAME="EnterAdjustment" VALUE="'. _('Clear Fields'). '">';;
		//<th>' . _('Clear All') . ':<input type="checkbox" name="ClearAll" /></th>
						
echo '<HR>';

if (!isset($_POST['StockLocation'])) {
	$_POST['StockLocation']='';
}


echo '<A HREF="'. $rootpath. '/StockStatus.php?' . SID . '&StockID='. $StockID . '">'._('Show Stock Status').'</A>';
echo '<BR><A HREF="'.$rootpath.'/StockMovements.php?' . SID . '&StockID=' . $StockID . '">'._('Show Movements').'</A>';
echo '<BR><A HREF="'.$rootpath.'/StockUsage.php?' . SID . '&StockID=' . $StockID . '&StockLocation=' . $_POST['StockLocation'] . '">'._('Show Stock Usage').'</A>';
echo '<BR><A HREF="'.$rootpath.'/SelectSalesOrder.php?' . SID . '&SelectedStockItem='. $StockID .'&StockLocation=' . $_POST['StockLocation'] . '">'. _('Search Outstanding Sales Orders').'</A>';
echo '<BR><A HREF="'.$rootpath.'/SelectCompletedOrder.php?' . SID . '&SelectedStockItem=' . $StockID .'">'._('Search Completed Sales Orders').'</A>';

echo '</FORM>';
include('includes/footer.inc');


function SelectTag(&$j)
{
	echo '
	<td><select name="StockTag'.$j.'">';
	GLOBAL $db;
	$SQL = 'SELECT tagref,
				tagdescription
		FROM tags
		ORDER BY tagref';

	$result=DB_query($SQL,$db);
	if (DB_num_rows($result)==0){
		echo '</select></td></tr>';
		prnMsg(_('No Tags have been set up yet') . ' - ' . _('payments cannot be analysed against a tag until the tag is set up'),'error');
	} else {
		echo '<option selected value=></option>';
		while ($myrow=DB_fetch_array($result)){
			if ($_POST['StockTag'.$j]==$myrow["tagref"]){
				echo '<OPTION selected value=' . $myrow['tagref'] . '>' .$myrow['tagdescription'];
			} else {
				echo '<OPTION value=' . $myrow['tagref'] . '>' .$myrow['tagdescription'];
			}
		}
		echo '</select></td>';
	}
}
// End select tag

Function PostQttycheckControlled($i)
{
	echo '<TD>';
	if ($Controlled==1){
		if ($_SESSION['Adjustment']->StockLocation != ''){
			echo '<INPUT TYPE="HIDDEN" NAME="StockQtty'.$i.'" Value="' . $_POST['StockQtty'.$i]. '">
				'.$_SESSION['Adjustment']->StockQtty.$i.' &nbsp; &nbsp; &nbsp; &nbsp;
				[<A HREF="'.$rootpath.'/StockAdjustmentsControlled.php?AdjType=REMOVE&' . SID . '">'._('Remove').'</A>]
				[<A HREF="'.$rootpath.'/StockAdjustmentsControlled.php?AdjType=ADD&' . SID . '">'._('Add').'</A>]';
		} else {
			prnMsg( _('Please select a location and press') . ' "' . _('Enter Stock Issue') . '" ' . _('below to enter Controlled Items'), 'info');
		}
	} else {
		echo '<INPUT TYPE=TEXT NAME="StockQtty'.$i.'" SIZE=12 MAXLENGTH=12 Value="' . $_POST['StockQtty'.$i] . '">';
	}
	echo '</TD>';
}//end the function
/*
*/