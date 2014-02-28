<?php

/* Include the new script for printing quotations in Portrait
 */

AddColumn('chequeno', 'banktrans', 'int(11)', 'NOT NULL', '0', 'ref', $db);

UpdateDBNo(66, $db);

?>