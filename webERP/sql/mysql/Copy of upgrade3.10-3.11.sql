
CREATE TABLE `mrpdemandtypes` (
  `mrpdemandtype` varchar(6) NOT NULL default '',
  `description` char(30) NOT NULL default '',
  PRIMARY KEY  (`mrpdemandtype`),
  KEY `mrpdemandtype` (`mrpdemandtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `mrpdemands` (
  `demandid` int(11) NOT NULL auto_increment,
  `stockid` varchar(20) NOT NULL default '',
  `mrpdemandtype` varchar(6) NOT NULL default '',
  `quantity` double NOT NULL default '0',
  `duedate` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`demandid`),
  KEY `StockID` (`stockid`),
  CONSTRAINT `mrpdemands_ibfk_1` FOREIGN KEY (`mrpdemandtype`) REFERENCES `mrpdemandtypes` (`mrpdemandtype`),
  CONSTRAINT `mrpdemands_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `stockmaster` ADD `pansize` double NOT NULL default '0',
  						  ADD `shrinkfactor` double NOT NULL default '0';
  
CREATE TABLE mrpcalendar (
	calendardate date NOT NULL,
	daynumber int(6) NOT NULL,
	manufacturingflag smallint(6) NOT NULL default "1",
	INDEX (daynumber),
	PRIMARY KEY (calendardate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO mrpdemandtypes (mrpdemandtype,description) VALUES ('FOR','Forecast');

ALTER TABLE `geocode_param` add PRIMARY KEY (`geocodeid`);
ALTER TABLE `geocode_param` CHANGE `geocodeid` `geocodeid` TINYINT( 4 ) NOT NULL AUTO_INCREMENT;

INSERT INTO `factorcompanies` ( `id` , `coyname` ) VALUES (null, "None");

ALTER TABLE `custcontacts` CHANGE `role` `role` VARCHAR( 40 ) NOT NULL;
ALTER TABLE `custcontacts` CHANGE `phoneno` `phoneno` VARCHAR( 20 ) NOT NULL;
ALTER TABLE `custcontacts` CHANGE `notes` `notes` VARCHAR( 255 ) NOT NULL;

ALTER TABLE `purchdata` DROP PRIMARY KEY;
ALTER TABLE `purchdata` ADD PRIMARY KEY (`supplierno`,`stockid`, `effectivefrom`); 

ALTER TABLE `salesorders` ADD `quotedate` date NOT NULL default '0000-00-00';
ALTER TABLE `salesorders` ADD `confirmeddate` date NOT NULL default '0000-00-00';

CREATE TABLE `woserialnos` (
	`wo` INT NOT NULL ,
	`stockid` VARCHAR( 20 ) NOT NULL ,
	`serialno` VARCHAR( 30 ) NOT NULL ,
	`qualitytext` TEXT NOT NULL,
	 PRIMARY KEY (`wo`,`stockid`,`serialno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO config (confname, confvalue) VALUES ('AutoCreateWOs',1);
INSERT INTO config (confname, confvalue) VALUES ('DefaultFactoryLocation','MEL');
INSERT INTO config (confname, confvalue) VALUES ('FactoryManagerEmail','manager@company.com');
INSERT INTO config (`confname`,`confvalue`) VALUES ('DefineControlledOnWOEntry', '1');

ALTER TABLE `stockmaster` ADD `nextserialno` VARCHAR( 30 ) NOT NULL DEFAULT '0';
ALTER TABLE `salesorders` CHANGE `orderno` `orderno` INT( 11 ) NOT NULL 
ALTER TABLE `stockserialitems` ADD `qualitytext` TEXT NOT NULL;

CREATE TABLE `purchorderauth` (
	`userid` varchar(20) NOT NULL DEFAULT '',
	`currabrev` char(20) NOT NULL DEFAULT '',
	`cancreate` smallint(2) NOT NULL DEFAULT 0,
	`authlevel` int(11) NOT NULL DEFAULT 0,
	PRIMARY KEY (`userid`,`currabrev`),
	KEY UserID (userid),
	KEY CurrCode (currabrev),
	CONSTRAINT `purchauth_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `www_users` (`userid`),
	CONSTRAINT `purchauth_ibfk_2` FOREIGN KEY (`currabrev`) REFERENCES `currencies` (`currabrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `purchorders` ADD `version` decimal(3,2) NOT NULL default '1.00';
ALTER TABLE `purchorders` ADD `revised` date NOT NULL default '0000-00-00';
ALTER TABLE `purchorders` ADD `realorderno` varchar(16) NOT NULL default '';
ALTER TABLE `purchorders` ADD `deliveryby` varchar(100) NOT NULL default '';
ALTER TABLE `purchorders` ADD `deliverydate` date NOT NULL default '0000-00-00';
ALTER TABLE `purchorders` ADD `status` varchar(12) NOT NULL default '';
ALTER TABLE `purchorders` ADD `stat_comment` text NOT NULL default '';

ALTER TABLE `purchorderdetails` ADD `itemno` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `uom` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `suppliers_partno` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `subtotal_amount` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `package` varchar(100) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `pcunit` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `nw` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `gw` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `cuft` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `total_quantity` varchar(50) NOT NULL default '';
ALTER TABLE `purchorderdetails` ADD `total_amount` varchar(50) NOT NULL default '';

ALTER TABLE `suppliers` ADD `phn` varchar(50) NOT NULL default '';
ALTER TABLE `suppliers` ADD `fax` varchar(50) NOT NULL default '';
ALTER TABLE `suppliers` ADD `website` varchar(50) NOT NULL default '';
ALTER TABLE `suppliers` ADD `email` varchar(50) NOT NULL default '';
ALTER TABLE `suppliers` ADD `quotation` varchar(50) NOT NULL default '';
ALTER TABLE `suppliers` ADD `vendoragreemnt` varchar(50) NOT NULL default '';
ALTER TABLE `suppliers` ADD `nda` varchar(50) NOT NULL default '';
ALTER TABLE `suppliers` ADD `notes` text NOT NULL;
ALTER TABLE `suppliers` ADD `active` varchar(4) NOT NULL default '1';
ALTER TABLE `suppliers` ADD `chinesename` varchar(200) NOT NULL default '';
ALTER TABLE `suppliers` ADD `port` varchar(200) NOT NULL default '';
ALTER TABLE `suppliers` ADD `chineseaddress` varchar(240) NOT NULL default '';
ALTER TABLE `suppliers` ADD `bankacctname` varchar(240) NOT NULL default '';
ALTER TABLE `suppliers` ADD `brname` varchar(100) NOT NULL default '';

ALTER TABLE `locations` ADD `deladd7` varchar(200) NOT NULL default '';
ALTER TABLE `locations` ADD `deladd8` varchar(50) NOT NULL default '';
ALTER TABLE `locations` ADD `active` int(11) default '0';

ALTER TABLE stockmaster ADD `length` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `width` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `height` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `fobcost` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `suppliers` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `pkg_type` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `shipping_port` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `substitute_items` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `product_url` varchar(50) NOT NULL default '';
ALTER TABLE stockmaster ADD `active` varchar(4) NOT NULL default '1';
ALTER TABLE stockmaster ADD `netweight` decimal(20,4) NOT NULL default '0.0000';
ALTER TABLE stockmaster ADD `cubicfeet` varchar(200) NOT NULL default '';
ALTER TABLE stockmaster ADD `unitscarton` varchar(200) NOT NULL default '';
ALTER TABLE stockmaster ADD `unitsfcp` varchar(100) NOT NULL default '';

ALTER TABLE purchdata ADD `suppliers_partno` varchar(50) NOT NULL default '';
