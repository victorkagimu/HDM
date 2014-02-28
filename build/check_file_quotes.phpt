#!/usr/bin/php5
<?php

if (sizeOf($argv)==1) {
	echo 'This script must be called with a file name as its argument'."\n";
	exit;
}
$filename=$argv['1'];

$fp=fopen($filename , 'r');
while (!feof($fp)) {
	$line=fgets($fp);
	if (strpos($line,'<form')) {
		$letter_array = count_chars($line, 1);
		if ($letter_array[34] % 2 !=0) {
			echo $letter_array[34]."\n";
			exit(1);
		}
	}
}


?>