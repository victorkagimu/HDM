INSERT INTO `config` (`confname`, `confvalue`) VALUES ('DBUpdateNumber', '0');
DROP TABLE IF EXISTS `assetmanager`;
CREATE TABLE `assetmanager` (
  `id` int(11) NOT NULL auto_increment,
  `stockid` varchar(20) NOT NULL default '',
  `serialno` varchar(30) NOT NULL default '',
  `location` varchar(15) NOT NULL default '',
  `cost` double NOT NULL default '0',
  `depn` double NOT NULL default '0',
  `datepurchased` date NOT NULL default '0000-00-00',
  `disposalvalue` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `fixedassetlocations` (
		`locationid` char(6) NOT NULL default '',
		`locationdescription` char(20) NOT NULL default '',
		`parentlocationid` char(6) DEFAULT '',
		PRIMARY KEY  (`locationid`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE www_users CHANGE COLUMN modulesallowed modulesallowed varchar(40) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,';
ALTER TABLE www_users CHANGE COLUMN language language varchar(10) NOT NULL DEFAULT 'en_GB.utf8';
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('LogPath', '');
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('LogSeverity', '0');
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('FrequentlyOrderedItems', '0');
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('NumberOfMonthMustBeShown', '6');
ALTER TABLE `currencies` ADD COLUMN `decimalplaces` tinyint(3) NOT NULL DEFAULT '2' AFTER `hundredsname`;
ALTER TABLE `purchorders` ADD COLUMN `suppdeladdress1` varchar(40) NOT NULL DEFAULT '' AFTER `deladd6`;
ALTER TABLE `purchorders` ADD COLUMN `suppdeladdress2` varchar(40) NOT NULL DEFAULT '' AFTER `suppdeladdress1`;
ALTER TABLE `purchorders` ADD COLUMN `suppdeladdress3` varchar(40) NOT NULL DEFAULT '' AFTER `suppdeladdress2`;
ALTER TABLE `purchorders` ADD COLUMN `suppdeladdress4` varchar(20) NOT NULL DEFAULT '' AFTER `suppdeladdress3`;
ALTER TABLE `purchorders` ADD COLUMN `suppdeladdress5` varchar(15) NOT NULL DEFAULT '' AFTER `suppdeladdress4`;
ALTER TABLE `purchorders` ADD COLUMN `suppdeladdress6` varchar(30) NOT NULL DEFAULT '' AFTER `suppdeladdress5`;
ALTER TABLE `purchorders` ADD COLUMN `supptel` varchar(30) NOT NULL DEFAULT '""' AFTER `suppdeladdress6`;
ALTER TABLE `purchorders` ADD COLUMN `tel` varchar(15) NOT NULL DEFAULT '""' AFTER `deladd6`;
ALTER TABLE `purchorders` ADD COLUMN `paymentterms` char(2) NOT NULL DEFAULT '""' AFTER `stat_comment`;
ALTER TABLE `purchorders` ADD COLUMN `port` varchar(40) NOT NULL DEFAULT '""' AFTER `paymentterms`;
ALTER TABLE `www_users` ADD COLUMN `pdflanguage` tinyint(1) NOT NULL DEFAULT '0' AFTER `language`;
ALTER TABLE `purchorderauth` ADD COLUMN `offhold` tinyint(1) NOT NULL DEFAULT '0' AFTER `authlevel`;
CREATE TABLE `pcashdetails` (
  `counterindex` int(20) NOT NULL AUTO_INCREMENT,
  `tabcode` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `codeexpense` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `authorized` date NOT NULL COMMENT 'date cash assigment was revised and authorized by authorizer from tabs table',
  `posted` tinyint(4) NOT NULL COMMENT 'has (or has not) been posted into gltrans',
  `notes` text NOT NULL,
  `receipt` text COMMENT 'filename or path to scanned receipt or code of receipt to find physical receipt if tax guys or auditors show up',
  PRIMARY KEY (`counterindex`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
CREATE TABLE `pcexpenses` (
  `codeexpense` varchar(20) NOT NULL COMMENT 'code for the group',
  `description` varchar(50) NOT NULL COMMENT 'text description, e.g. meals, train tickets, fuel, etc',
  `glaccount` int(11) NOT NULL COMMENT 'GL related account',
  PRIMARY KEY (`codeexpense`),
  KEY (`glaccount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `pctabexpenses` (
  `typetabcode` varchar(20) NOT NULL,
  `codeexpense` varchar(20) NOT NULL,
  KEY (`typetabcode`),
  KEY (`codeexpense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `pctabs` (
  `tabcode` varchar(20) NOT NULL,
  `usercode` varchar(20) NOT NULL COMMENT 'code of user employee from www_users',
  `typetabcode` varchar(20) NOT NULL,
  `currency` char(3) NOT NULL,
  `tablimit` double NOT NULL,
  `authorizer` varchar(20) NOT NULL COMMENT 'code of user from www_users',
  `glaccountassignment` int(11) NOT NULL COMMENT 'gl account where the money comes from',
  `glaccountpcash` int(11) NOT NULL,
  PRIMARY KEY (`tabcode`),
  KEY (`usercode`),
  KEY (`typetabcode`),
  KEY (`currency`),
  KEY (`authorizer`),
  KEY (`glaccountassignment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `pctypetabs` (
  `typetabcode` varchar(20) NOT NULL COMMENT 'code for the type of petty cash tab',
  `typetabdescription` varchar(50) NOT NULL COMMENT 'text description, e.g. tab for CEO',
  PRIMARY KEY (`typetabcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE pcexpenses ADD CONSTRAINT pcexpenses_ibfk_1 FOREIGN KEY (glaccount) REFERENCES chartmaster (accountcode);
ALTER TABLE pctabexpenses ADD CONSTRAINT pctabexpenses_ibfk_1 FOREIGN KEY (typetabcode) REFERENCES pctypetabs (typetabcode);
ALTER TABLE pctabexpenses ADD CONSTRAINT pctabexpenses_ibfk_2 FOREIGN KEY (codeexpense) REFERENCES pcexpenses (codeexpense);
ALTER TABLE pctabs ADD CONSTRAINT pctabs_ibfk_1 FOREIGN KEY (usercode) REFERENCES www_users (userid);
ALTER TABLE pctabs ADD CONSTRAINT pctabs_ibfk_2 FOREIGN KEY (typetabcode) REFERENCES pctypetabs (typetabcode);
ALTER TABLE pctabs ADD CONSTRAINT pctabs_ibfk_3 FOREIGN KEY (currency) REFERENCES currencies (currabrev);
ALTER TABLE pctabs ADD CONSTRAINT pctabs_ibfk_4 FOREIGN KEY (authorizer) REFERENCES www_users (userid);
ALTER TABLE pctabs ADD CONSTRAINT pctabs_ibfk_5 FOREIGN KEY (glaccountassignment) REFERENCES chartmaster (accountcode);
UPDATE suppliers SET factorcompanyid='0' WHERE `factorcompanyid`=1;
DELETE FROM factorcompanies WHERE coyname='None';
UPDATE securitytokens SET tokenname='Petty Cash' WHERE tokenid=6;
ALTER TABLE `supptrans` ADD COLUMN `inputdate` datetime NOT NULL DEFAULT '0000-00-00' AFTER `duedate`;
ALTER TABLE `debtortrans` ADD COLUMN `inputdate` datetime NOT NULL DEFAULT '0000-00-00' AFTER `trandate`;
ALTER TABLE reportfields CHANGE COLUMN fieldname fieldname varchar(60) NOT NULL DEFAULT '''';
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('RequirePickingNote', '0');
CREATE TABLE `pickinglists` (
  `pickinglistno` int(11) NOT NULL DEFAULT 0,
  `orderno` int(11) NOT NULL DEFAULT 0,
  `pickinglistdate` date NOT NULL default '0000-00-00',
  `dateprinted` date NOT NULL default '0000-00-00',
  `deliverynotedate` date NOT NULL default '0000-00-00',
  CONSTRAINT `pickinglists_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`),
  PRIMARY KEY (`pickinglistno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `pickinglistdetails` (
  `pickinglistno` int(11) NOT NULL DEFAULT 0,
  `pickinglistlineno` int(11) NOT NULL DEFAULT 0,
  `orderlineno` int(11) NOT NULL DEFAULT 0,
  `qtyexpected` double NOT NULL default 0.00,
  `qtypicked` double NOT NULL default 0.00,
  CONSTRAINT `pickinglistdetails_ibfk_1` FOREIGN KEY (`pickinglistno`) REFERENCES `pickinglists` (`pickinglistno`),
  PRIMARY KEY (`pickinglistno`, `pickinglistlineno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO systypes (typeid,typename) VALUES ('19','Picking List');
ALTER TABLE `prices` ADD COLUMN `startdate` Date NOT NULL DEFAULT '0000-00-00' AFTER `branchcode`;
ALTER TABLE `prices` ADD COLUMN `enddate` Date NOT NULL DEFAULT '9999-12-31' AFTER `startdate`;
ALTER TABLE prices DROP PRIMARY KEY;
ALTER TABLE prices ADD PRIMARY KEY ( stockid,typeabbrev,currabrev,debtorno,branchcode,startdate,enddate );
UPDATE prices SET startdate='1999-01-01' WHERE stockid='%';
UPDATE prices SET enddate='' WHERE stockid='%';
ALTER TABLE `purchdata` ADD COLUMN `minorderqty` int(11) NOT NULL DEFAULT '1' AFTER `suppliers_partno`;
ALTER TABLE `stockcheckfreeze` ADD COLUMN `stockcheckdate` date NOT NULL DEFAULT '0000-00-00' AFTER `qoh`;
ALTER TABLE `suppliers` ADD COLUMN `email` varchar(55) NOT NULL DEFAULT '' AFTER `port`;
ALTER TABLE `suppliers` ADD COLUMN `fax` varchar(25) NOT NULL DEFAULT '' AFTER `email`;
ALTER TABLE `suppliers` ADD COLUMN `telephone` varchar(25) NOT NULL DEFAULT '' AFTER `fax`;
ALTER TABLE `www_users` ADD COLUMN `supplierid` varchar(10) NOT NULL DEFAULT '' AFTER `customerid`;
INSERT INTO securityroles (secroleid,secrolename) VALUES ('9','Supplier Log On Only');
UPDATE securitytokens SET tokenname='Supplier centre - Supplier access only' WHERE tokenid=9;
INSERT INTO securitygroups (secroleid,tokenid) VALUES ('9','9');
ALTER TABLE `locations` ADD COLUMN `cashsalecustomer` varchar(21) NOT NULL DEFAULT '' AFTER `taxprovinceid`;
DROP TABLE IF EXISTS `contracts`;
DROP TABLE IF EXISTS `contractreqts`;
DROP TABLE IF EXISTS `contractbom`;
CREATE TABLE IF NOT EXISTS `contractcharges` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `contractref` varchar(20) NOT NULL,
  `transtype` SMALLINT NOT NULL DEFAULT 20,
  `transno` INT NOT NULL DEFAULT 0,
  `amount` double NOT NULL DEFAULT 0,
  `narrative` TEXT NOT NULL DEFAULT '',
  `anticipated` TINYINT NOT NULL DEFAULT 0,
  INDEX ( `contractref` , `transtype` , `transno` ),
  CONSTRAINT `contractcharges_ibfk_1` FOREIGN KEY (`contractref`) REFERENCES `contracts` (`contractref`),
  CONSTRAINT `contractcharges_ibfk_2` FOREIGN KEY (`transtype`) REFERENCES `systypes` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE salestypes CHANGE COLUMN sales_type sales_type varchar(40) NOT NULL DEFAULT '';
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('ShowValueOnGRN', '1');
CREATE TABLE IF NOT EXISTS `offers` (
  offerid int(11) NOT NULL AUTO_INCREMENT,
  tenderid int(11) NOT NULL DEFAULT 0,
  supplierid varchar(10) NOT NULL DEFAULT '',
  stockid varchar(20) NOT NULL DEFAULT '',
  quantity double NOT NULL DEFAULT 0.0,
  uom varchar(15) NOT NULL DEFAULT '',
  price double NOT NULL DEFAULT 0.0,
  expirydate date NOT NULL DEFAULT '0000-00-00',
  currcode char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`offerid`),
  CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `offers_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('PurchasingManagerEmail', '');
CREATE TABLE `emailsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(30) NOT NULL,
  `port` char(5) NOT NULL,
  `heloaddress` varchar(20) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `timeout` int(11) DEFAULT '5',
  `companyname` varchar(50) DEFAULT NULL,
  `auth` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO emailsettings (id,host,port,heloaddress,username,password,timeout,companyname,auth) VALUES ('','localhost','25','helo','','','5','','0');
ALTER TABLE `salesorderdetails` ADD COLUMN `commissionrate` double NOT NULL DEFAULT '0' AFTER `poline`;
ALTER TABLE `salesorderdetails` ADD COLUMN `commissionearned` double NOT NULL DEFAULT '0' AFTER `commissionrate`;
CREATE TABLE `suppliertype` (
  `typeid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('DefaultSupplierType', '1');
INSERT INTO suppliertype (typeid,typename) VALUES ('1','Default');
ALTER TABLE `suppliers` ADD COLUMN `supptype` tinyint(4) NOT NULL DEFAULT '1' AFTER `address6`;
ALTER TABLE loctransfers CHANGE COLUMN shipqty shipqty double NOT NULL DEFAULT '0';
INSERT INTO `config` (`confname`, `confvalue`) VALUES ('VersionNumber', '4.00-RC1');
UPDATE securitytokens SET tokenname='Prices Security' WHERE tokenid=12;
ALTER TABLE orderdeliverydifferenceslog DROP PRIMARY KEY;
ALTER TABLE loctransfers CHANGE COLUMN recqty recqty double NOT NULL DEFAULT '0';
INSERT INTO systypes (typeid,typename,typeno) VALUES ('32','Contract Close','1');
ALTER TABLE `reports` ADD COLUMN `col9width` int(3) NOT NULL DEFAULT '25' AFTER `col8width`;
ALTER TABLE `reports` ADD COLUMN `col10width` int(3) NOT NULL DEFAULT '25' AFTER `col9width`;
ALTER TABLE `reports` ADD COLUMN `col11width` int(3) NOT NULL DEFAULT '25' AFTER `col10width`;
ALTER TABLE `reports` ADD COLUMN `col12width` int(3) NOT NULL DEFAULT '25' AFTER `col11width`;
ALTER TABLE `reports` ADD COLUMN `col13width` int(3) NOT NULL DEFAULT '25' AFTER `col12width`;
ALTER TABLE `reports` ADD COLUMN `col14width` int(3) NOT NULL DEFAULT '25' AFTER `col13width`;
ALTER TABLE `reports` ADD COLUMN `col15width` int(3) NOT NULL DEFAULT '25' AFTER `col14width`;
ALTER TABLE `reports` ADD COLUMN `col16width` int(3) NOT NULL DEFAULT '25' AFTER `col15width`;
ALTER TABLE `reports` ADD COLUMN `col17width` int(3) NOT NULL DEFAULT '25' AFTER `col16width`;
ALTER TABLE `reports` ADD COLUMN `col18width` int(3) NOT NULL DEFAULT '25' AFTER `col17width`;
ALTER TABLE `reports` ADD COLUMN `col19width` int(3) NOT NULL DEFAULT '25' AFTER `col18width`;
ALTER TABLE `reports` ADD COLUMN `col20width` int(3) NOT NULL DEFAULT '25' AFTER `col19width`;
ALTER TABLE reportfields CHANGE COLUMN fieldname fieldname varchar(80) NOT NULL DEFAULT '''';
ALTER TABLE `stockcatproperties` ADD COLUMN `maximumvalue` Double NOT NULL DEFAULT '999999999' AFTER `defaultvalue`;
ALTER TABLE `stockcatproperties` ADD COLUMN `minimumvalue` Double NOT NULL DEFAULT '-999999999' AFTER `maximumvalue`;
ALTER TABLE `stockcatproperties` ADD COLUMN `numericvalue` tinyint NOT NULL DEFAULT '0' AFTER `minimumvalue`;
DROP TABLE IF EXISTS `fixedassets`;
ALTER TABLE `fixedassets` ADD COLUMN `assetcategoryid` varchar(6) NOT NULL DEFAULT '' AFTER `disposalvalue`;
ALTER TABLE `fixedassets` ADD COLUMN `description` varchar(50) NOT NULL DEFAULT '' AFTER `assetcategoryid`;
ALTER TABLE `fixedassets` ADD COLUMN `longdescription` text NOT NULL AFTER `description`;
ALTER TABLE `fixedassets` ADD COLUMN `depntype` int(11) NOT NULL DEFAULT '1' AFTER `longdescription`;
ALTER TABLE `fixedassets` ADD COLUMN `depnrate` double NOT NULL DEFAULT '0' AFTER `depntype`;
ALTER TABLE `fixedassets` ADD COLUMN `barcode` varchar(30) NOT NULL DEFAULT '' AFTER `depnrate`;
CREATE TABLE IF NOT EXISTS `fixedassetcategories` (
  `categoryid` char(6) NOT NULL DEFAULT '',
  `categorydescription` char(20) NOT NULL DEFAULT '',
  `costact` int(11) NOT NULL DEFAULT '0',
  `depnact` int(11) NOT NULL DEFAULT '0',
  `disposalact` int(11) NOT NULL DEFAULT '80000',
  `accumdepnact` int(11) NOT NULL DEFAULT '0',
  defaultdepnrate double NOT NULL DEFAULT '.2',
  defaultdepntype int NOT NULL DEFAULT '1',
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
