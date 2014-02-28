SET FOREIGN_KEY_CHECKS = 0;
-- MySQL dump 10.11
--
-- Host: localhost    Database: weberp
-- ------------------------------------------------------
-- Server version	5.0.51a
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accountgroups`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `accountgroups` (
  `groupname` char(30) NOT NULL default '',
  `sectioninaccounts` int(11) NOT NULL default '0',
  `pandl` tinyint(4) NOT NULL default '1',
  `sequenceintb` smallint(6) NOT NULL default '0',
  `parentgroupname` varchar(30) NOT NULL,
  PRIMARY KEY  (`groupname`),
  KEY `SequenceInTB` (`sequenceintb`),
  KEY `sectioninaccounts` (`sectioninaccounts`),
  KEY `parentgroupname` (`parentgroupname`),
  CONSTRAINT `accountgroups_ibfk_1` FOREIGN KEY (`sectioninaccounts`) REFERENCES `accountsection` (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `accountsection`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `accountsection` (
  `sectionid` int(11) NOT NULL default '0',
  `sectionname` text NOT NULL,
  PRIMARY KEY  (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `areas`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `areas` (
  `areacode` char(3) NOT NULL,
  `areadescription` varchar(25) NOT NULL default '',
  PRIMARY KEY  (`areacode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `assetmanager`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `assetmanager` (
  `id` int(11) NOT NULL auto_increment,
  `serialno` varchar(30) NOT NULL default '',
  `assetglcode` int(11) NOT NULL default '0',
  `depnglcode` int(11) NOT NULL default '0',
  `description` varchar(30) NOT NULL default '',
  `lifetime` int(11) NOT NULL default '0',
  `location` varchar(15) NOT NULL default '',
  `cost` double NOT NULL default '0',
  `depn` double NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `audittrail`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `audittrail` (
  `transactiondate` datetime NOT NULL default '0000-00-00 00:00:00',
  `userid` varchar(20) NOT NULL default '',
  `querystring` text,
  KEY `UserID` (`userid`),
  CONSTRAINT `audittrail_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `www_users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bankaccounts`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `bankaccounts` (
  `accountcode` int(11) NOT NULL default '0',
  `currcode` char(3) NOT NULL,
  `bankaccountname` char(50) NOT NULL default '',
  `bankaccountnumber` char(50) NOT NULL default '',
  `bankaddress` char(50) default NULL,
  PRIMARY KEY  (`accountcode`),
  KEY `currcode` (`currcode`),
  KEY `BankAccountName` (`bankaccountname`),
  KEY `BankAccountNumber` (`bankaccountnumber`),
  CONSTRAINT `bankaccounts_ibfk_1` FOREIGN KEY (`accountcode`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `banktrans`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `banktrans` (
  `banktransid` bigint(20) NOT NULL auto_increment,
  `type` smallint(6) NOT NULL default '0',
  `transno` bigint(20) NOT NULL default '0',
  `bankact` int(11) NOT NULL default '0',
  `ref` varchar(50) NOT NULL default '',
  `amountcleared` double NOT NULL default '0',
  `exrate` double NOT NULL default '1' COMMENT 'From bank account currency to payment currency',
  `functionalexrate` double NOT NULL default '1' COMMENT 'Account currency to functional currency',
  `transdate` date NOT NULL default '0000-00-00',
  `banktranstype` varchar(30) NOT NULL default '',
  `amount` double NOT NULL default '0',
  `currcode` char(3) NOT NULL default '',
  PRIMARY KEY  (`banktransid`),
  KEY `BankAct` (`bankact`,`ref`),
  KEY `TransDate` (`transdate`),
  KEY `TransType` (`banktranstype`),
  KEY `Type` (`type`,`transno`),
  KEY `CurrCode` (`currcode`),
  CONSTRAINT `banktrans_ibfk_1` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `banktrans_ibfk_2` FOREIGN KEY (`bankact`) REFERENCES `bankaccounts` (`accountcode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bom`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `bom` (
  `parent` char(20) NOT NULL default '',
  `component` char(20) NOT NULL default '',
  `workcentreadded` char(5) NOT NULL default '',
  `loccode` char(5) NOT NULL default '',
  `effectiveafter` date NOT NULL default '0000-00-00',
  `effectiveto` date NOT NULL default '9999-12-31',
  `quantity` double NOT NULL default '1',
  `autoissue` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`parent`,`component`,`workcentreadded`,`loccode`),
  KEY `Component` (`component`),
  KEY `EffectiveAfter` (`effectiveafter`),
  KEY `EffectiveTo` (`effectiveto`),
  KEY `LocCode` (`loccode`),
  KEY `Parent` (`parent`,`effectiveafter`,`effectiveto`,`loccode`),
  KEY `Parent_2` (`parent`),
  KEY `WorkCentreAdded` (`workcentreadded`),
  CONSTRAINT `bom_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `bom_ibfk_2` FOREIGN KEY (`component`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `bom_ibfk_3` FOREIGN KEY (`workcentreadded`) REFERENCES `workcentres` (`code`),
  CONSTRAINT `bom_ibfk_4` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `buckets`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `buckets` (
  `workcentre` char(5) NOT NULL default '',
  `availdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `capacity` double NOT NULL default '0',
  PRIMARY KEY  (`workcentre`,`availdate`),
  KEY `WorkCentre` (`workcentre`),
  KEY `AvailDate` (`availdate`),
  CONSTRAINT `buckets_ibfk_1` FOREIGN KEY (`workcentre`) REFERENCES `workcentres` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `chartdetails`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `chartdetails` (
  `accountcode` int(11) NOT NULL default '0',
  `period` smallint(6) NOT NULL default '0',
  `budget` double NOT NULL default '0',
  `actual` double NOT NULL default '0',
  `bfwd` double NOT NULL default '0',
  `bfwdbudget` double NOT NULL default '0',
  PRIMARY KEY  (`accountcode`,`period`),
  KEY `Period` (`period`),
  CONSTRAINT `chartdetails_ibfk_1` FOREIGN KEY (`accountcode`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `chartdetails_ibfk_2` FOREIGN KEY (`period`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `chartmaster`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `chartmaster` (
  `accountcode` int(11) NOT NULL default '0',
  `accountname` char(50) NOT NULL default '',
  `group_` char(30) NOT NULL default '',
  PRIMARY KEY  (`accountcode`),
  KEY `AccountCode` (`accountcode`),
  KEY `AccountName` (`accountname`),
  KEY `Group_` (`group_`),
  CONSTRAINT `chartmaster_ibfk_1` FOREIGN KEY (`group_`) REFERENCES `accountgroups` (`groupname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cogsglpostings`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cogsglpostings` (
  `id` int(11) NOT NULL auto_increment,
  `area` char(2) NOT NULL default '',
  `stkcat` varchar(6) NOT NULL default '',
  `glcode` int(11) NOT NULL default '0',
  `salestype` char(2) NOT NULL default 'AN',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `Area_StkCat` (`area`,`stkcat`,`salestype`),
  KEY `Area` (`area`),
  KEY `StkCat` (`stkcat`),
  KEY `GLCode` (`glcode`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `companies`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `companies` (
  `coycode` int(11) NOT NULL default '1',
  `coyname` varchar(50) NOT NULL default '',
  `gstno` varchar(20) NOT NULL default '',
  `companynumber` varchar(20) NOT NULL default '0',
  `regoffice1` varchar(40) NOT NULL default '',
  `regoffice2` varchar(40) NOT NULL default '',
  `regoffice3` varchar(40) NOT NULL default '',
  `regoffice4` varchar(40) NOT NULL default '',
  `regoffice5` varchar(20) NOT NULL default '',
  `regoffice6` varchar(15) NOT NULL default '',
  `telephone` varchar(25) NOT NULL default '',
  `fax` varchar(25) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  `currencydefault` varchar(4) NOT NULL default '',
  `debtorsact` int(11) NOT NULL default '70000',
  `pytdiscountact` int(11) NOT NULL default '55000',
  `creditorsact` int(11) NOT NULL default '80000',
  `payrollact` int(11) NOT NULL default '84000',
  `grnact` int(11) NOT NULL default '72000',
  `exchangediffact` int(11) NOT NULL default '65000',
  `purchasesexchangediffact` int(11) NOT NULL default '0',
  `retainedearnings` int(11) NOT NULL default '90000',
  `gllink_debtors` tinyint(1) default '1',
  `gllink_creditors` tinyint(1) default '1',
  `gllink_stock` tinyint(1) default '1',
  `freightact` int(11) NOT NULL default '0',
  PRIMARY KEY  (`coycode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `config`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `config` (
  `confname` varchar(35) NOT NULL default '',
  `confvalue` text NOT NULL,
  PRIMARY KEY  (`confname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `contractbom`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `contractbom` (
  `contractref` char(20) NOT NULL default '',
  `component` char(20) NOT NULL default '',
  `workcentreadded` char(5) NOT NULL default '',
  `loccode` char(5) NOT NULL default '',
  `quantity` double NOT NULL default '1',
  PRIMARY KEY  (`contractref`,`component`,`workcentreadded`,`loccode`),
  KEY `Component` (`component`),
  KEY `LocCode` (`loccode`),
  KEY `ContractRef` (`contractref`),
  KEY `WorkCentreAdded` (`workcentreadded`),
  KEY `WorkCentreAdded_2` (`workcentreadded`),
  CONSTRAINT `contractbom_ibfk_1` FOREIGN KEY (`workcentreadded`) REFERENCES `workcentres` (`code`),
  CONSTRAINT `contractbom_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `contractbom_ibfk_3` FOREIGN KEY (`component`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `contractreqts`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `contractreqts` (
  `contractreqid` int(11) NOT NULL auto_increment,
  `contract` char(20) NOT NULL default '',
  `component` char(40) NOT NULL default '',
  `quantity` double NOT NULL default '1',
  `priceperunit` decimal(20,4) NOT NULL default '0.0000',
  PRIMARY KEY  (`contractreqid`),
  KEY `Contract` (`contract`),
  CONSTRAINT `contractreqts_ibfk_1` FOREIGN KEY (`contract`) REFERENCES `contracts` (`contractref`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `contracts`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `contracts` (
  `contractref` varchar(20) NOT NULL default '',
  `contractdescription` varchar(50) NOT NULL default '',
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `status` varchar(10) NOT NULL default 'Quotation',
  `categoryid` varchar(6) NOT NULL default '',
  `typeabbrev` char(2) NOT NULL default '',
  `orderno` int(11) NOT NULL default '0',
  `quotedpricefx` decimal(20,4) NOT NULL default '0.0000',
  `margin` double NOT NULL default '1',
  `woref` varchar(20) NOT NULL default '',
  `requireddate` datetime NOT NULL default '0000-00-00 00:00:00',
  `canceldate` datetime NOT NULL default '0000-00-00 00:00:00',
  `quantityreqd` double NOT NULL default '1',
  `specifications` longblob NOT NULL,
  `datequoted` datetime NOT NULL default '0000-00-00 00:00:00',
  `units` varchar(15) NOT NULL default 'Each',
  `drawing` longblob NOT NULL,
  `rate` double NOT NULL default '1',
  PRIMARY KEY  (`contractref`),
  KEY `OrderNo` (`orderno`),
  KEY `CategoryID` (`categoryid`),
  KEY `Status` (`status`),
  KEY `TypeAbbrev` (`typeabbrev`),
  KEY `WORef` (`woref`),
  KEY `DebtorNo` (`debtorno`,`branchcode`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`debtorno`, `branchcode`) REFERENCES `custbranch` (`debtorno`, `branchcode`),
  CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `contracts_ibfk_3` FOREIGN KEY (`typeabbrev`) REFERENCES `salestypes` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `currencies`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `currencies` (
  `currency` char(20) NOT NULL default '',
  `currabrev` char(3) NOT NULL default '',
  `country` char(50) NOT NULL default '',
  `hundredsname` char(15) NOT NULL default 'Cents',
  `rate` double NOT NULL default '1',
  PRIMARY KEY  (`currabrev`),
  KEY `Country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `custallocns`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `custallocns` (
  `id` int(11) NOT NULL auto_increment,
  `amt` decimal(20,4) NOT NULL default '0.0000',
  `datealloc` date NOT NULL default '0000-00-00',
  `transid_allocfrom` int(11) NOT NULL default '0',
  `transid_allocto` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `DateAlloc` (`datealloc`),
  KEY `TransID_AllocFrom` (`transid_allocfrom`),
  KEY `TransID_AllocTo` (`transid_allocto`),
  CONSTRAINT `custallocns_ibfk_1` FOREIGN KEY (`transid_allocfrom`) REFERENCES `debtortrans` (`id`),
  CONSTRAINT `custallocns_ibfk_2` FOREIGN KEY (`transid_allocto`) REFERENCES `debtortrans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `custbranch`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `custbranch` (
  `branchcode` varchar(10) NOT NULL default '',
  `debtorno` varchar(10) NOT NULL default '',
  `brname` varchar(40) NOT NULL default '',
  `braddress1` varchar(40) NOT NULL default '',
  `braddress2` varchar(40) NOT NULL default '',
  `braddress3` varchar(40) NOT NULL default '',
  `braddress4` varchar(50) NOT NULL default '',
  `braddress5` varchar(20) NOT NULL default '',
  `braddress6` varchar(15) NOT NULL default '',
  `lat` FLOAT( 10, 6 ) NOT NULL default 0.0,
  `lng` FLOAT( 10, 6 ) NOT NULL default 0.0,
  `estdeliverydays` smallint(6) NOT NULL default '1',
  `area` char(3) NOT NULL,
  `salesman` varchar(4) NOT NULL default '',
  `fwddate` smallint(6) NOT NULL default '0',
  `phoneno` varchar(20) NOT NULL default '',
  `faxno` varchar(20) NOT NULL default '',
  `contactname` varchar(30) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  `defaultlocation` varchar(5) NOT NULL default '',
  `taxgroupid` tinyint(4) NOT NULL default '1',
  `defaultshipvia` int(11) NOT NULL default '1',
  `deliverblind` tinyint(1) default '1',
  `disabletrans` tinyint(4) NOT NULL default '0',
  `brpostaddr1` varchar(40) NOT NULL default '',
  `brpostaddr2` varchar(40) NOT NULL default '',
  `brpostaddr3` varchar(30) NOT NULL default '',
  `brpostaddr4` varchar(20) NOT NULL default '',
  `brpostaddr5` varchar(20) NOT NULL default '',
  `brpostaddr6` varchar(15) NOT NULL default '',
  `specialinstructions` text NOT NULL,
  `custbranchcode` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`branchcode`,`debtorno`),
  KEY `BrName` (`brname`),
  KEY `DebtorNo` (`debtorno`),
  KEY `Salesman` (`salesman`),
  KEY `Area` (`area`),
  KEY `DefaultLocation` (`defaultlocation`),
  KEY `DefaultShipVia` (`defaultshipvia`),
  KEY `taxgroupid` (`taxgroupid`),
  CONSTRAINT `custbranch_ibfk_1` FOREIGN KEY (`debtorno`) REFERENCES `debtorsmaster` (`debtorno`),
  CONSTRAINT `custbranch_ibfk_2` FOREIGN KEY (`area`) REFERENCES `areas` (`areacode`),
  CONSTRAINT `custbranch_ibfk_3` FOREIGN KEY (`salesman`) REFERENCES `salesman` (`salesmancode`),
  CONSTRAINT `custbranch_ibfk_4` FOREIGN KEY (`defaultlocation`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `custbranch_ibfk_6` FOREIGN KEY (`defaultshipvia`) REFERENCES `shippers` (`shipper_id`),
  CONSTRAINT `custbranch_ibfk_7` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `custcontacts`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `custcontacts` (
  `contid` int(11) NOT NULL auto_increment,
  `debtorno` varchar(10) NOT NULL,
  `contactname` varchar(40) NOT NULL,
  `role` varchar(10) NOT NULL,
  `phoneno` int(10) NOT NULL,
  `notes` varchar(40) NOT NULL,
  PRIMARY KEY  (`contid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `debtorsmaster`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `debtorsmaster` (
  `debtorno` varchar(10) NOT NULL default '',
  `name` varchar(40) NOT NULL default '',
  `address1` varchar(40) NOT NULL default '',
  `address2` varchar(40) NOT NULL default '',
  `address3` varchar(40) NOT NULL default '',
  `address4` varchar(50) NOT NULL default '',
  `address5` varchar(20) NOT NULL default '',
  `address6` varchar(15) NOT NULL default '',
  `currcode` char(3) NOT NULL default '',
  `salestype` char(2) NOT NULL default '',
  `clientsince` datetime NOT NULL default '0000-00-00 00:00:00',
  `holdreason` smallint(6) NOT NULL default '0',
  `paymentterms` char(2) NOT NULL default 'f',
  `discount` double NOT NULL default '0',
  `pymtdiscount` double NOT NULL default '0',
  `lastpaid` double NOT NULL default '0',
  `lastpaiddate` datetime default NULL,
  `creditlimit` double NOT NULL default '1000',
  `invaddrbranch` tinyint(4) NOT NULL default '0',
  `discountcode` char(2) NOT NULL default '',
  `ediinvoices` tinyint(4) NOT NULL default '0',
  `ediorders` tinyint(4) NOT NULL default '0',
  `edireference` varchar(20) NOT NULL default '',
  `editransport` varchar(5) NOT NULL default 'email',
  `ediaddress` varchar(50) NOT NULL default '',
  `ediserveruser` varchar(20) NOT NULL default '',
  `ediserverpwd` varchar(20) NOT NULL default '',
  `taxref` varchar(20) NOT NULL default '',
  `customerpoline` tinyint(1) NOT NULL default '0',
  `typeid` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`debtorno`),
  KEY `Currency` (`currcode`),
  KEY `HoldReason` (`holdreason`),
  KEY `Name` (`name`),
  KEY `PaymentTerms` (`paymentterms`),
  KEY `SalesType` (`salestype`),
  KEY `EDIInvoices` (`ediinvoices`),
  KEY `EDIOrders` (`ediorders`),
  CONSTRAINT `debtorsmaster_ibfk_1` FOREIGN KEY (`holdreason`) REFERENCES `holdreasons` (`reasoncode`),
  CONSTRAINT `debtorsmaster_ibfk_2` FOREIGN KEY (`currcode`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `debtorsmaster_ibfk_3` FOREIGN KEY (`paymentterms`) REFERENCES `paymentterms` (`termsindicator`),
  CONSTRAINT `debtorsmaster_ibfk_4` FOREIGN KEY (`salestype`) REFERENCES `salestypes` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `debtortrans`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `debtortrans` (
  `id` int(11) NOT NULL auto_increment,
  `transno` int(11) NOT NULL default '0',
  `type` smallint(6) NOT NULL default '0',
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `trandate` datetime NOT NULL default '0000-00-00 00:00:00',
  `prd` smallint(6) NOT NULL default '0',
  `settled` tinyint(4) NOT NULL default '0',
  `reference` varchar(20) NOT NULL default '',
  `tpe` char(2) NOT NULL default '',
  `order_` int(11) NOT NULL default '0',
  `rate` double NOT NULL default '0',
  `ovamount` double NOT NULL default '0',
  `ovgst` double NOT NULL default '0',
  `ovfreight` double NOT NULL default '0',
  `ovdiscount` double NOT NULL default '0',
  `diffonexch` double NOT NULL default '0',
  `alloc` double NOT NULL default '0',
  `invtext` text,
  `shipvia` varchar(10) NOT NULL default '',
  `edisent` tinyint(4) NOT NULL default '0',
  `consignment` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `DebtorNo` (`debtorno`,`branchcode`),
  KEY `Order_` (`order_`),
  KEY `Prd` (`prd`),
  KEY `Tpe` (`tpe`),
  KEY `Type` (`type`),
  KEY `Settled` (`settled`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type_2` (`type`,`transno`),
  KEY `EDISent` (`edisent`),
  CONSTRAINT `debtortrans_ibfk_1` FOREIGN KEY (`debtorno`) REFERENCES `custbranch` (`debtorno`),
  CONSTRAINT `debtortrans_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `debtortrans_ibfk_3` FOREIGN KEY (`prd`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `debtortranstaxes`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `debtortranstaxes` (
  `debtortransid` int(11) NOT NULL default '0',
  `taxauthid` tinyint(4) NOT NULL default '0',
  `taxamount` double NOT NULL default '0',
  PRIMARY KEY  (`debtortransid`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `debtortranstaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `debtortranstaxes_ibfk_2` FOREIGN KEY (`debtortransid`) REFERENCES `debtortrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `debtortype`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `debtortype` (
`typeid` tinyint(4) NOT NULL auto_increment,
`typename` varchar(100) NOT NULL,
PRIMARY KEY (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `discountmatrix`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `discountmatrix` (
  `salestype` char(2) NOT NULL default '',
  `discountcategory` char(2) NOT NULL default '',
  `quantitybreak` int(11) NOT NULL default '1',
  `discountrate` double NOT NULL default '0',
  PRIMARY KEY  (`salestype`,`discountcategory`,`quantitybreak`),
  KEY `QuantityBreak` (`quantitybreak`),
  KEY `DiscountCategory` (`discountcategory`),
  KEY `SalesType` (`salestype`),
  CONSTRAINT `discountmatrix_ibfk_1` FOREIGN KEY (`salestype`) REFERENCES `salestypes` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `edi_orders_seg_groups`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `edi_orders_seg_groups` (
  `seggroupno` tinyint(4) NOT NULL default '0',
  `maxoccur` int(4) NOT NULL default '0',
  `parentseggroup` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`seggroupno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `edi_orders_segs`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `edi_orders_segs` (
  `id` int(11) NOT NULL auto_increment,
  `segtag` char(3) NOT NULL default '',
  `seggroup` tinyint(4) NOT NULL default '0',
  `maxoccur` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `SegTag` (`segtag`),
  KEY `SegNo` (`seggroup`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ediitemmapping`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ediitemmapping` (
  `supporcust` varchar(4) NOT NULL default '',
  `partnercode` varchar(10) NOT NULL default '',
  `stockid` varchar(20) NOT NULL default '',
  `partnerstockid` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`supporcust`,`partnercode`,`stockid`),
  KEY `PartnerCode` (`partnercode`),
  KEY `StockID` (`stockid`),
  KEY `PartnerStockID` (`partnerstockid`),
  KEY `SuppOrCust` (`supporcust`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `edimessageformat`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `edimessageformat` (
  `id` int(11) NOT NULL auto_increment,
  `partnercode` varchar(10) NOT NULL default '',
  `messagetype` varchar(6) NOT NULL default '',
  `section` varchar(7) NOT NULL default '',
  `sequenceno` int(11) NOT NULL default '0',
  `linetext` varchar(70) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `PartnerCode` (`partnercode`,`messagetype`,`sequenceno`),
  KEY `Section` (`section`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `factorcompanies`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `factorcompanies` (
  `id` int(11) NOT NULL auto_increment,
  `coyname` varchar(50) NOT NULL default '',
  `address1` varchar(40) NOT NULL default '',
  `address2` varchar(40) NOT NULL default '',
  `address3` varchar(40) NOT NULL default '',
  `address4` varchar(40) NOT NULL default '',
  `address5` varchar(20) NOT NULL default '',
  `address6` varchar(15) NOT NULL default '',
  `contact` varchar(25) NOT NULL default '',
  `telephone` varchar(25) NOT NULL default '',
  `fax` varchar(25) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `geocode_param`
--

CREATE TABLE `geocode_param` (
 `geocodeid` varchar(4) NOT NULL default '',
 `geocode_key` varchar(200) NOT NULL default '',
 `center_long` varchar(20) NOT NULL default '',
 `center_lat` varchar(20) NOT NULL default '',
 `map_height` varchar(10) NOT NULL default '',
 `map_width` varchar(10) NOT NULL default '',
 `map_host` varchar(50) NOT NULL default ''
) ENGINE=InnoDB;

--
-- Table structure for table `freightcosts`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `freightcosts` (
  `shipcostfromid` int(11) NOT NULL auto_increment,
  `locationfrom` varchar(5) NOT NULL default '',
  `destination` varchar(40) NOT NULL default '',
  `shipperid` int(11) NOT NULL default '0',
  `cubrate` double NOT NULL default '0',
  `kgrate` double NOT NULL default '0',
  `maxkgs` double NOT NULL default '999999',
  `maxcub` double NOT NULL default '999999',
  `fixedprice` double NOT NULL default '0',
  `minimumchg` double NOT NULL default '0',
  PRIMARY KEY  (`shipcostfromid`),
  KEY `Destination` (`destination`),
  KEY `LocationFrom` (`locationfrom`),
  KEY `ShipperID` (`shipperid`),
  KEY `Destination_2` (`destination`,`locationfrom`,`shipperid`),
  CONSTRAINT `freightcosts_ibfk_1` FOREIGN KEY (`locationfrom`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `freightcosts_ibfk_2` FOREIGN KEY (`shipperid`) REFERENCES `shippers` (`shipper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `gltrans`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `gltrans` (
  `counterindex` int(11) NOT NULL auto_increment,
  `type` smallint(6) NOT NULL default '0',
  `typeno` bigint(16) NOT NULL default '1',
  `chequeno` int(11) NOT NULL default '0',
  `trandate` date NOT NULL default '0000-00-00',
  `periodno` smallint(6) NOT NULL default '0',
  `account` int(11) NOT NULL default '0',
  `narrative` varchar(200) NOT NULL default '',
  `amount` double NOT NULL default '0',
  `posted` tinyint(4) NOT NULL default '0',
  `jobref` varchar(20) NOT NULL default '',
  `tag` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`counterindex`),
  KEY `Account` (`account`),
  KEY `ChequeNo` (`chequeno`),
  KEY `PeriodNo` (`periodno`),
  KEY `Posted` (`posted`),
  KEY `TranDate` (`trandate`),
  KEY `TypeNo` (`typeno`),
  KEY `Type_and_Number` (`type`,`typeno`),
  KEY `JobRef` (`jobref`),
  CONSTRAINT `gltrans_ibfk_1` FOREIGN KEY (`account`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `gltrans_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `gltrans_ibfk_3` FOREIGN KEY (`periodno`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `grns`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `grns` (
  `grnbatch` smallint(6) NOT NULL default '0',
  `grnno` int(11) NOT NULL auto_increment,
  `podetailitem` int(11) NOT NULL default '0',
  `itemcode` varchar(20) NOT NULL default '',
  `deliverydate` date NOT NULL default '0000-00-00',
  `itemdescription` varchar(100) NOT NULL default '',
  `qtyrecd` double NOT NULL default '0',
  `quantityinv` double NOT NULL default '0',
  `supplierid` varchar(10) NOT NULL default '',
  `stdcostunit` double NOT NULL default '0',
  PRIMARY KEY  (`grnno`),
  KEY `DeliveryDate` (`deliverydate`),
  KEY `ItemCode` (`itemcode`),
  KEY `PODetailItem` (`podetailitem`),
  KEY `SupplierID` (`supplierid`),
  CONSTRAINT `grns_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `grns_ibfk_2` FOREIGN KEY (`podetailitem`) REFERENCES `purchorderdetails` (`podetailitem`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `holdreasons`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `holdreasons` (
  `reasoncode` smallint(6) NOT NULL default '1',
  `reasondescription` char(30) NOT NULL default '',
  `dissallowinvoices` tinyint(4) NOT NULL default '-1',
  PRIMARY KEY  (`reasoncode`),
  KEY `ReasonCode` (`reasoncode`),
  KEY `ReasonDescription` (`reasondescription`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `lastcostrollup`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `lastcostrollup` (
  `stockid` char(20) NOT NULL default '',
  `totalonhand` double NOT NULL default '0',
  `matcost` decimal(20,4) NOT NULL default '0.0000',
  `labcost` decimal(20,4) NOT NULL default '0.0000',
  `oheadcost` decimal(20,4) NOT NULL default '0.0000',
  `categoryid` char(6) NOT NULL default '',
  `stockact` int(11) NOT NULL default '0',
  `adjglact` int(11) NOT NULL default '0',
  `newmatcost` decimal(20,4) NOT NULL default '0.0000',
  `newlabcost` decimal(20,4) NOT NULL default '0.0000',
  `newoheadcost` decimal(20,4) NOT NULL default '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `locations`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `locations` (
  `loccode` varchar(5) NOT NULL default '',
  `locationname` varchar(50) NOT NULL default '',
  `deladd1` varchar(40) NOT NULL default '',
  `deladd2` varchar(40) NOT NULL default '',
  `deladd3` varchar(40) NOT NULL default '',
  `deladd4` varchar(40) NOT NULL default '',
  `deladd5` varchar(20) NOT NULL default '',
  `deladd6` varchar(15) NOT NULL default '',
  `tel` varchar(30) NOT NULL default '',
  `fax` varchar(30) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  `contact` varchar(30) NOT NULL default '',
  `taxprovinceid` tinyint(4) NOT NULL default '1',
  `managed` int(11) default '0',
  PRIMARY KEY  (`loccode`),
  KEY `taxprovinceid` (`taxprovinceid`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`taxprovinceid`) REFERENCES `taxprovinces` (`taxprovinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `locstock`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `locstock` (
  `loccode` varchar(5) NOT NULL default '',
  `stockid` varchar(20) NOT NULL default '',
  `quantity` double NOT NULL default '0',
  `reorderlevel` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`loccode`,`stockid`),
  KEY `StockID` (`stockid`),
  CONSTRAINT `locstock_ibfk_1` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `locstock_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `loctransfers`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `loctransfers` (
  `reference` int(11) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `shipqty` int(11) NOT NULL default '0',
  `recqty` int(11) NOT NULL default '0',
  `shipdate` date NOT NULL default '0000-00-00',
  `recdate` date NOT NULL default '0000-00-00',
  `shiploc` varchar(7) NOT NULL default '',
  `recloc` varchar(7) NOT NULL default '',
  KEY `Reference` (`reference`,`stockid`),
  KEY `ShipLoc` (`shiploc`),
  KEY `RecLoc` (`recloc`),
  KEY `StockID` (`stockid`),
  CONSTRAINT `loctransfers_ibfk_1` FOREIGN KEY (`shiploc`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `loctransfers_ibfk_2` FOREIGN KEY (`recloc`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `loctransfers_ibfk_3` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores Shipments To And From Locations';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orderdeliverydifferenceslog`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `orderdeliverydifferenceslog` (
  `orderno` int(11) NOT NULL default '0',
  `invoiceno` int(11) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `quantitydiff` double NOT NULL default '0',
  `debtorno` varchar(10) NOT NULL default '',
  `branch` varchar(10) NOT NULL default '',
  `can_or_bo` char(3) NOT NULL default 'CAN',
  PRIMARY KEY  (`orderno`,`invoiceno`,`stockid`),
  KEY `StockID` (`stockid`),
  KEY `DebtorNo` (`debtorno`,`branch`),
  KEY `Can_or_BO` (`can_or_bo`),
  KEY `OrderNo` (`orderno`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_2` FOREIGN KEY (`debtorno`, `branch`) REFERENCES `custbranch` (`debtorno`, `branchcode`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_3` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `paymentmethods`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `paymentmethods` (
  `paymentid` tinyint(4) NOT NULL auto_increment,
  `paymentname` varchar(15) NOT NULL default '',
  `paymenttype` int(11) NOT NULL default '1',
  `receipttype` int(11) NOT NULL default '1',
  PRIMARY KEY  (`paymentid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `paymentterms`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `paymentterms` (
  `termsindicator` char(2) NOT NULL default '',
  `terms` char(40) NOT NULL default '',
  `daysbeforedue` smallint(6) NOT NULL default '0',
  `dayinfollowingmonth` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`termsindicator`),
  KEY `DaysBeforeDue` (`daysbeforedue`),
  KEY `DayInFollowingMonth` (`dayinfollowingmonth`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `periods`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `periods` (
  `periodno` smallint(6) NOT NULL default '0',
  `lastdate_in_period` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`periodno`),
  KEY `LastDate_in_Period` (`lastdate_in_period`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `prices`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prices` (
  `stockid` varchar(20) NOT NULL default '',
  `typeabbrev` char(2) NOT NULL default '',
  `currabrev` char(3) NOT NULL default '',
  `debtorno` varchar(10) NOT NULL default '',
  `price` decimal(20,4) NOT NULL default '0.0000',
  `branchcode` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`stockid`,`typeabbrev`,`currabrev`,`debtorno`),
  KEY `CurrAbrev` (`currabrev`),
  KEY `DebtorNo` (`debtorno`),
  KEY `StockID` (`stockid`),
  KEY `TypeAbbrev` (`typeabbrev`),
  CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `prices_ibfk_2` FOREIGN KEY (`currabrev`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `prices_ibfk_3` FOREIGN KEY (`typeabbrev`) REFERENCES `salestypes` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `purchdata`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `purchdata` (
  `supplierno` char(10) NOT NULL default '',
  `stockid` char(20) NOT NULL default '',
  `price` decimal(20,4) NOT NULL default '0.0000',
  `suppliersuom` char(50) NOT NULL default '',
  `conversionfactor` double NOT NULL default '1',
  `supplierdescription` char(50) NOT NULL default '',
  `leadtime` smallint(6) NOT NULL default '1',
  `preferred` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`supplierno`,`stockid`),
  KEY `StockID` (`stockid`),
  KEY `SupplierNo` (`supplierno`),
  KEY `Preferred` (`preferred`),
  CONSTRAINT `purchdata_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `purchdata_ibfk_2` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `purchorderdetails`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `purchorderdetails` (
  `podetailitem` int(11) NOT NULL auto_increment,
  `orderno` int(11) NOT NULL default '0',
  `itemcode` varchar(20) NOT NULL default '',
  `deliverydate` date NOT NULL default '0000-00-00',
  `itemdescription` varchar(100) NOT NULL default '',
  `glcode` int(11) NOT NULL default '0',
  `qtyinvoiced` double NOT NULL default '0',
  `unitprice` double NOT NULL default '0',
  `actprice` double NOT NULL default '0',
  `stdcostunit` double NOT NULL default '0',
  `quantityord` double NOT NULL default '0',
  `quantityrecd` double NOT NULL default '0',
  `shiptref` int(11) NOT NULL default '0',
  `jobref` varchar(20) NOT NULL default '',
  `completed` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`podetailitem`),
  KEY `DeliveryDate` (`deliverydate`),
  KEY `GLCode` (`glcode`),
  KEY `ItemCode` (`itemcode`),
  KEY `JobRef` (`jobref`),
  KEY `OrderNo` (`orderno`),
  KEY `ShiptRef` (`shiptref`),
  KEY `Completed` (`completed`),
  CONSTRAINT `purchorderdetails_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `purchorders` (`orderno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `purchorders`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `purchorders` (
  `orderno` int(11) NOT NULL auto_increment,
  `supplierno` varchar(10) NOT NULL default '',
  `comments` longblob,
  `orddate` datetime NOT NULL default '0000-00-00 00:00:00',
  `rate` double NOT NULL default '1',
  `dateprinted` datetime default NULL,
  `allowprint` tinyint(4) NOT NULL default '1',
  `initiator` varchar(10) default NULL,
  `requisitionno` varchar(15) default NULL,
  `intostocklocation` varchar(5) NOT NULL default '',
  `deladd1` varchar(40) NOT NULL default '',
  `deladd2` varchar(40) NOT NULL default '',
  `deladd3` varchar(40) NOT NULL default '',
  `deladd4` varchar(40) NOT NULL default '',
  `deladd5` varchar(20) NOT NULL default '',
  `deladd6` varchar(15) NOT NULL default '',
  `contact` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`orderno`),
  KEY `OrdDate` (`orddate`),
  KEY `SupplierNo` (`supplierno`),
  KEY `IntoStockLocation` (`intostocklocation`),
  KEY `AllowPrintPO` (`allowprint`),
  CONSTRAINT `purchorders_ibfk_1` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `purchorders_ibfk_2` FOREIGN KEY (`intostocklocation`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `recurringsalesorders`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `recurringsalesorders` (
  `recurrorderno` int(11) NOT NULL auto_increment,
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `customerref` varchar(50) NOT NULL default '',
  `buyername` varchar(50) default NULL,
  `comments` longblob,
  `orddate` date NOT NULL default '0000-00-00',
  `ordertype` char(2) NOT NULL default '',
  `shipvia` int(11) NOT NULL default '0',
  `deladd1` varchar(40) NOT NULL default '',
  `deladd2` varchar(40) NOT NULL default '',
  `deladd3` varchar(40) NOT NULL default '',
  `deladd4` varchar(40) default NULL,
  `deladd5` varchar(20) NOT NULL default '',
  `deladd6` varchar(15) NOT NULL default '',
  `contactphone` varchar(25) default NULL,
  `contactemail` varchar(25) default NULL,
  `deliverto` varchar(40) NOT NULL default '',
  `freightcost` double NOT NULL default '0',
  `fromstkloc` varchar(5) NOT NULL default '',
  `lastrecurrence` date NOT NULL default '0000-00-00',
  `stopdate` date NOT NULL default '0000-00-00',
  `frequency` tinyint(4) NOT NULL default '1',
  `autoinvoice` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`recurrorderno`),
  KEY `debtorno` (`debtorno`),
  KEY `orddate` (`orddate`),
  KEY `ordertype` (`ordertype`),
  KEY `locationindex` (`fromstkloc`),
  KEY `branchcode` (`branchcode`,`debtorno`),
  CONSTRAINT `recurringsalesorders_ibfk_1` FOREIGN KEY (`branchcode`, `debtorno`) REFERENCES `custbranch` (`branchcode`, `debtorno`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `recurrsalesorderdetails`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `recurrsalesorderdetails` (
  `recurrorderno` int(11) NOT NULL default '0',
  `stkcode` varchar(20) NOT NULL default '',
  `unitprice` double NOT NULL default '0',
  `quantity` double NOT NULL default '0',
  `discountpercent` double NOT NULL default '0',
  `narrative` text NOT NULL,
  KEY `orderno` (`recurrorderno`),
  KEY `stkcode` (`stkcode`),
  CONSTRAINT `recurrsalesorderdetails_ibfk_1` FOREIGN KEY (`recurrorderno`) REFERENCES `recurringsalesorders` (`recurrorderno`),
  CONSTRAINT `recurrsalesorderdetails_ibfk_2` FOREIGN KEY (`stkcode`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reportcolumns`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reportcolumns` (
  `reportid` smallint(6) NOT NULL default '0',
  `colno` smallint(6) NOT NULL default '0',
  `heading1` varchar(15) NOT NULL default '',
  `heading2` varchar(15) default NULL,
  `calculation` tinyint(1) NOT NULL default '0',
  `periodfrom` smallint(6) default NULL,
  `periodto` smallint(6) default NULL,
  `datatype` varchar(15) default NULL,
  `colnumerator` tinyint(4) default NULL,
  `coldenominator` tinyint(4) default NULL,
  `calcoperator` char(1) default NULL,
  `budgetoractual` tinyint(1) NOT NULL default '0',
  `valformat` char(1) NOT NULL default 'N',
  `constant` double NOT NULL default '0',
  PRIMARY KEY  (`reportid`,`colno`),
  CONSTRAINT `reportcolumns_ibfk_1` FOREIGN KEY (`reportid`) REFERENCES `reportheaders` (`reportid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reportfields`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reportfields` (
  `id` int(8) NOT NULL auto_increment,
  `reportid` int(5) NOT NULL default '0',
  `entrytype` varchar(15) NOT NULL default '',
  `seqnum` int(3) NOT NULL default '0',
  `fieldname` varchar(35) NOT NULL default '',
  `displaydesc` varchar(25) NOT NULL default '',
  `visible` enum('1','0') NOT NULL default '1',
  `columnbreak` enum('1','0') NOT NULL default '1',
  `params` text,
  PRIMARY KEY  (`id`),
  KEY `reportid` (`reportid`)
) ENGINE=MyISAM AUTO_INCREMENT=1805 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reportheaders`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reportheaders` (
  `reportid` smallint(6) NOT NULL auto_increment,
  `reportheading` varchar(80) NOT NULL default '',
  `groupbydata1` varchar(15) NOT NULL default '',
  `newpageafter1` tinyint(1) NOT NULL default '0',
  `lower1` varchar(10) NOT NULL default '',
  `upper1` varchar(10) NOT NULL default '',
  `groupbydata2` varchar(15) default NULL,
  `newpageafter2` tinyint(1) NOT NULL default '0',
  `lower2` varchar(10) default NULL,
  `upper2` varchar(10) default NULL,
  `groupbydata3` varchar(15) default NULL,
  `newpageafter3` tinyint(1) NOT NULL default '0',
  `lower3` varchar(10) default NULL,
  `upper3` varchar(10) default NULL,
  `groupbydata4` varchar(15) NOT NULL default '',
  `newpageafter4` tinyint(1) NOT NULL default '0',
  `upper4` varchar(10) NOT NULL default '',
  `lower4` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`reportid`),
  KEY `ReportHeading` (`reportheading`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reportlinks`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reportlinks` (
  `table1` varchar(25) NOT NULL default '',
  `table2` varchar(25) NOT NULL default '',
  `equation` varchar(75) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reports`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reports` (
  `id` int(5) NOT NULL auto_increment,
  `reportname` varchar(30) NOT NULL default '',
  `reporttype` char(3) NOT NULL default 'rpt',
  `groupname` varchar(9) NOT NULL default 'misc',
  `defaultreport` enum('1','0') NOT NULL default '0',
  `papersize` varchar(15) NOT NULL default 'A4,210,297',
  `paperorientation` enum('P','L') NOT NULL default 'P',
  `margintop` int(3) NOT NULL default '10',
  `marginbottom` int(3) NOT NULL default '10',
  `marginleft` int(3) NOT NULL default '10',
  `marginright` int(3) NOT NULL default '10',
  `coynamefont` varchar(20) NOT NULL default 'Helvetica',
  `coynamefontsize` int(3) NOT NULL default '12',
  `coynamefontcolor` varchar(11) NOT NULL default '0,0,0',
  `coynamealign` enum('L','C','R') NOT NULL default 'C',
  `coynameshow` enum('1','0') NOT NULL default '1',
  `title1desc` varchar(50) NOT NULL default '%reportname%',
  `title1font` varchar(20) NOT NULL default 'Helvetica',
  `title1fontsize` int(3) NOT NULL default '10',
  `title1fontcolor` varchar(11) NOT NULL default '0,0,0',
  `title1fontalign` enum('L','C','R') NOT NULL default 'C',
  `title1show` enum('1','0') NOT NULL default '1',
  `title2desc` varchar(50) NOT NULL default 'Report Generated %date%',
  `title2font` varchar(20) NOT NULL default 'Helvetica',
  `title2fontsize` int(3) NOT NULL default '10',
  `title2fontcolor` varchar(11) NOT NULL default '0,0,0',
  `title2fontalign` enum('L','C','R') NOT NULL default 'C',
  `title2show` enum('1','0') NOT NULL default '1',
  `filterfont` varchar(10) NOT NULL default 'Helvetica',
  `filterfontsize` int(3) NOT NULL default '8',
  `filterfontcolor` varchar(11) NOT NULL default '0,0,0',
  `filterfontalign` enum('L','C','R') NOT NULL default 'L',
  `datafont` varchar(10) NOT NULL default 'Helvetica',
  `datafontsize` int(3) NOT NULL default '10',
  `datafontcolor` varchar(10) NOT NULL default 'black',
  `datafontalign` enum('L','C','R') NOT NULL default 'L',
  `totalsfont` varchar(10) NOT NULL default 'Helvetica',
  `totalsfontsize` int(3) NOT NULL default '10',
  `totalsfontcolor` varchar(11) NOT NULL default '0,0,0',
  `totalsfontalign` enum('L','C','R') NOT NULL default 'L',
  `col1width` int(3) NOT NULL default '25',
  `col2width` int(3) NOT NULL default '25',
  `col3width` int(3) NOT NULL default '25',
  `col4width` int(3) NOT NULL default '25',
  `col5width` int(3) NOT NULL default '25',
  `col6width` int(3) NOT NULL default '25',
  `col7width` int(3) NOT NULL default '25',
  `col8width` int(3) NOT NULL default '25',
  `table1` varchar(25) NOT NULL default '',
  `table2` varchar(25) default NULL,
  `table2criteria` varchar(75) default NULL,
  `table3` varchar(25) default NULL,
  `table3criteria` varchar(75) default NULL,
  `table4` varchar(25) default NULL,
  `table4criteria` varchar(75) default NULL,
  `table5` varchar(25) default NULL,
  `table5criteria` varchar(75) default NULL,
  `table6` varchar(25) default NULL,
  `table6criteria` varchar(75) default NULL,
  PRIMARY KEY  (`id`),
  KEY `name` (`reportname`,`groupname`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `salesanalysis`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `salesanalysis` (
  `typeabbrev` char(2) NOT NULL default '',
  `periodno` smallint(6) NOT NULL default '0',
  `amt` double NOT NULL default '0',
  `cost` double NOT NULL default '0',
  `cust` varchar(10) NOT NULL default '',
  `custbranch` varchar(10) NOT NULL default '',
  `qty` double NOT NULL default '0',
  `disc` double NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `area` char(2) NOT NULL default '',
  `budgetoractual` tinyint(1) NOT NULL default '0',
  `salesperson` char(3) NOT NULL default '',
  `stkcategory` varchar(6) NOT NULL default '',
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `CustBranch` (`custbranch`),
  KEY `Cust` (`cust`),
  KEY `PeriodNo` (`periodno`),
  KEY `StkCategory` (`stkcategory`),
  KEY `StockID` (`stockid`),
  KEY `TypeAbbrev` (`typeabbrev`),
  KEY `Area` (`area`),
  KEY `BudgetOrActual` (`budgetoractual`),
  KEY `Salesperson` (`salesperson`),
  CONSTRAINT `salesanalysis_ibfk_1` FOREIGN KEY (`periodno`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `salescat`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `salescat` (
  `salescatid` tinyint(4) NOT NULL auto_increment,
  `parentcatid` tinyint(4) default NULL,
  `salescatname` varchar(30) default NULL,
  PRIMARY KEY  (`salescatid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `salescatprod`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `salescatprod` (
  `salescatid` tinyint(4) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`salescatid`,`stockid`),
  KEY `salescatid` (`salescatid`),
  KEY `stockid` (`stockid`),
  CONSTRAINT `salescatprod_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `salescatprod_ibfk_2` FOREIGN KEY (`salescatid`) REFERENCES `salescat` (`salescatid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `salesglpostings`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `salesglpostings` (
  `id` int(11) NOT NULL auto_increment,
  `area` char(2) NOT NULL default '',
  `stkcat` varchar(6) NOT NULL default '',
  `discountglcode` int(11) NOT NULL default '0',
  `salesglcode` int(11) NOT NULL default '0',
  `salestype` char(2) NOT NULL default 'AN',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `Area_StkCat` (`area`,`stkcat`,`salestype`),
  KEY `Area` (`area`),
  KEY `StkCat` (`stkcat`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `salesman`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `salesman` (
  `salesmancode` char(3) NOT NULL default '',
  `salesmanname` char(30) NOT NULL default '',
  `smantel` char(20) NOT NULL default '',
  `smanfax` char(20) NOT NULL default '',
  `commissionrate1` double NOT NULL default '0',
  `breakpoint` decimal(10,0) NOT NULL default '0',
  `commissionrate2` double NOT NULL default '0',
  PRIMARY KEY  (`salesmancode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `salesorderdetails`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `salesorderdetails` (
  `orderlineno` int(11) NOT NULL default '0',
  `orderno` int(11) NOT NULL default '0',
  `stkcode` varchar(20) NOT NULL default '',
  `qtyinvoiced` double NOT NULL default '0',
  `unitprice` double NOT NULL default '0',
  `quantity` double NOT NULL default '0',
  `estimate` tinyint(4) NOT NULL default '0',
  `discountpercent` double NOT NULL default '0',
  `actualdispatchdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `completed` tinyint(1) NOT NULL default '0',
  `narrative` text,
  `itemdue` date default NULL COMMENT 'Due date for line item.  Some customers require \r\nacknowledgements with due dates by line item',
  `poline` varchar(10) default NULL COMMENT 'Some Customers require acknowledgements with a PO line number for each sales line',
  PRIMARY KEY  (`orderlineno`,`orderno`),
  KEY `OrderNo` (`orderno`),
  KEY `StkCode` (`stkcode`),
  KEY `Completed` (`completed`),
  CONSTRAINT `salesorderdetails_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`),
  CONSTRAINT `salesorderdetails_ibfk_2` FOREIGN KEY (`stkcode`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `salesorders`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `salesorders` (
  `orderno` int(11) NOT NULL auto_increment,
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `customerref` varchar(50) NOT NULL default '',
  `buyername` varchar(50) default NULL,
  `comments` longblob,
  `orddate` date NOT NULL default '0000-00-00',
  `ordertype` char(2) NOT NULL default '',
  `shipvia` int(11) NOT NULL default '0',
  `deladd1` varchar(40) NOT NULL default '',
  `deladd2` varchar(40) NOT NULL default '',
  `deladd3` varchar(40) NOT NULL default '',
  `deladd4` varchar(40) default NULL,
  `deladd5` varchar(20) NOT NULL default '',
  `deladd6` varchar(15) NOT NULL default '',
  `contactphone` varchar(25) default NULL,
  `contactemail` varchar(40) default NULL,
  `deliverto` varchar(40) NOT NULL default '',
  `deliverblind` tinyint(1) default '1',
  `freightcost` double NOT NULL default '0',
  `fromstkloc` varchar(5) NOT NULL default '',
  `deliverydate` date NOT NULL default '0000-00-00',
  `printedpackingslip` tinyint(4) NOT NULL default '0',
  `datepackingslipprinted` date NOT NULL default '0000-00-00',
  `quotation` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`orderno`),
  KEY `DebtorNo` (`debtorno`),
  KEY `OrdDate` (`orddate`),
  KEY `OrderType` (`ordertype`),
  KEY `LocationIndex` (`fromstkloc`),
  KEY `BranchCode` (`branchcode`,`debtorno`),
  KEY `ShipVia` (`shipvia`),
  KEY `quotation` (`quotation`),
  CONSTRAINT `salesorders_ibfk_1` FOREIGN KEY (`branchcode`, `debtorno`) REFERENCES `custbranch` (`branchcode`, `debtorno`),
  CONSTRAINT `salesorders_ibfk_2` FOREIGN KEY (`shipvia`) REFERENCES `shippers` (`shipper_id`),
  CONSTRAINT `salesorders_ibfk_3` FOREIGN KEY (`fromstkloc`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `salestypes`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `salestypes` (
  `typeabbrev` char(2) NOT NULL default '',
  `sales_type` char(20) NOT NULL default '',
  PRIMARY KEY  (`typeabbrev`),
  KEY `Sales_Type` (`sales_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `scripts`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `scripts` (
  `pageid` smallint(4) NOT NULL auto_increment,
  `filename` varchar(50) NOT NULL default '',
  `pagedescription` text NOT NULL,
  PRIMARY KEY  (`pageid`),
  KEY `FileName` (`filename`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=latin1 COMMENT='Index of all scripts';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `securitygroups`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `securitygroups` (
  `secroleid` int(11) NOT NULL default '0',
  `tokenid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`secroleid`,`tokenid`),
  KEY `secroleid` (`secroleid`),
  KEY `tokenid` (`tokenid`),
  CONSTRAINT `securitygroups_secroleid_fk` FOREIGN KEY (`secroleid`) REFERENCES `securityroles` (`secroleid`),
  CONSTRAINT `securitygroups_tokenid_fk` FOREIGN KEY (`tokenid`) REFERENCES `securitytokens` (`tokenid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `securityroles`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `securityroles` (
  `secroleid` int(11) NOT NULL auto_increment,
  `secrolename` text NOT NULL,
  PRIMARY KEY  (`secroleid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `securitytokens`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `securitytokens` (
  `tokenid` int(11) NOT NULL default '0',
  `tokenname` text NOT NULL,
  PRIMARY KEY  (`tokenid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `shipmentcharges`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shipmentcharges` (
  `shiptchgid` int(11) NOT NULL auto_increment,
  `shiptref` int(11) NOT NULL default '0',
  `transtype` smallint(6) NOT NULL default '0',
  `transno` int(11) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `value` double NOT NULL default '0',
  PRIMARY KEY  (`shiptchgid`),
  KEY `TransType` (`transtype`,`transno`),
  KEY `ShiptRef` (`shiptref`),
  KEY `StockID` (`stockid`),
  KEY `TransType_2` (`transtype`),
  CONSTRAINT `shipmentcharges_ibfk_1` FOREIGN KEY (`shiptref`) REFERENCES `shipments` (`shiptref`),
  CONSTRAINT `shipmentcharges_ibfk_2` FOREIGN KEY (`transtype`) REFERENCES `systypes` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `shipments`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shipments` (
  `shiptref` int(11) NOT NULL default '0',
  `voyageref` varchar(20) NOT NULL default '0',
  `vessel` varchar(50) NOT NULL default '',
  `eta` datetime NOT NULL default '0000-00-00 00:00:00',
  `accumvalue` double NOT NULL default '0',
  `supplierid` varchar(10) NOT NULL default '',
  `closed` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`shiptref`),
  KEY `ETA` (`eta`),
  KEY `SupplierID` (`supplierid`),
  KEY `ShipperRef` (`voyageref`),
  KEY `Vessel` (`vessel`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `shippers`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shippers` (
  `shipper_id` int(11) NOT NULL auto_increment,
  `shippername` char(40) NOT NULL default '',
  `mincharge` double NOT NULL default '0',
  PRIMARY KEY  (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockcategory`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockcategory` (
  `categoryid` char(6) NOT NULL default '',
  `categorydescription` char(20) NOT NULL default '',
  `stocktype` char(1) NOT NULL default 'F',
  `stockact` int(11) NOT NULL default '0',
  `adjglact` int(11) NOT NULL default '0',
  `purchpricevaract` int(11) NOT NULL default '80000',
  `materialuseagevarac` int(11) NOT NULL default '80000',
  `wipact` int(11) NOT NULL default '0',
  PRIMARY KEY  (`categoryid`),
  KEY `CategoryDescription` (`categorydescription`),
  KEY `StockType` (`stocktype`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockcatproperties`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockcatproperties` (
  `stkcatpropid` int(11) NOT NULL auto_increment,
  `categoryid` char(6) NOT NULL,
  `label` text NOT NULL,
  `controltype` tinyint(4) NOT NULL default '0',
  `defaultvalue` varchar(100) NOT NULL default '''''',
  `reqatsalesorder` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`stkcatpropid`),
  KEY `categoryid` (`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockcheckfreeze`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockcheckfreeze` (
  `stockid` varchar(20) NOT NULL default '',
  `loccode` varchar(5) NOT NULL default '',
  `qoh` double NOT NULL default '0',
  PRIMARY KEY  (`stockid`,`loccode`),
  KEY `LocCode` (`loccode`),
  CONSTRAINT `stockcheckfreeze_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockcheckfreeze_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockcounts`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockcounts` (
  `id` int(11) NOT NULL auto_increment,
  `stockid` varchar(20) NOT NULL default '',
  `loccode` varchar(5) NOT NULL default '',
  `qtycounted` double NOT NULL default '0',
  `reference` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `StockID` (`stockid`),
  KEY `LocCode` (`loccode`),
  CONSTRAINT `stockcounts_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockcounts_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockitemproperties`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockitemproperties` (
  `stockid` varchar(20) NOT NULL,
  `stkcatpropid` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY  (`stockid`,`stkcatpropid`),
  KEY `stockid` (`stockid`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockmaster`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockmaster` (
  `stockid` varchar(20) NOT NULL default '',
  `categoryid` varchar(6) NOT NULL default '',
  `description` varchar(50) NOT NULL default '',
  `longdescription` text NOT NULL,
  `units` varchar(20) NOT NULL default 'each',
  `mbflag` char(1) NOT NULL default 'B',
  `lastcurcostdate` date NOT NULL default '1800-01-01',
  `actualcost` decimal(20,4) NOT NULL default '0.0000',
  `lastcost` decimal(20,4) NOT NULL default '0.0000',
  `materialcost` decimal(20,4) NOT NULL default '0.0000',
  `labourcost` decimal(20,4) NOT NULL default '0.0000',
  `overheadcost` decimal(20,4) NOT NULL default '0.0000',
  `lowestlevel` smallint(6) NOT NULL default '0',
  `discontinued` tinyint(4) NOT NULL default '0',
  `controlled` tinyint(4) NOT NULL default '0',
  `eoq` double NOT NULL default '0',
  `volume` decimal(20,4) NOT NULL default '0.0000',
  `kgs` decimal(20,4) NOT NULL default '0.0000',
  `barcode` varchar(50) NOT NULL default '',
  `discountcategory` char(2) NOT NULL default '',
  `taxcatid` tinyint(4) NOT NULL default '1',
  `serialised` tinyint(4) NOT NULL default '0',
  `appendfile` varchar(40) NOT NULL default 'none',
  `perishable` tinyint(1) NOT NULL default '0',
  `decimalplaces` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`stockid`),
  KEY `CategoryID` (`categoryid`),
  KEY `Description` (`description`),
  KEY `LastCurCostDate` (`lastcurcostdate`),
  KEY `MBflag` (`mbflag`),
  KEY `StockID` (`stockid`,`categoryid`),
  KEY `Controlled` (`controlled`),
  KEY `DiscountCategory` (`discountcategory`),
  KEY `taxcatid` (`taxcatid`),
  CONSTRAINT `stockmaster_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `stockmaster_ibfk_2` FOREIGN KEY (`taxcatid`) REFERENCES `taxcategories` (`taxcatid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockmoves`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockmoves` (
  `stkmoveno` int(11) NOT NULL auto_increment,
  `stockid` varchar(20) NOT NULL default '',
  `type` smallint(6) NOT NULL default '0',
  `transno` int(11) NOT NULL default '0',
  `loccode` varchar(5) NOT NULL default '',
  `trandate` date NOT NULL default '0000-00-00',
  `debtorno` varchar(10) NOT NULL default '',
  `branchcode` varchar(10) NOT NULL default '',
  `price` decimal(20,4) NOT NULL default '0.0000',
  `prd` smallint(6) NOT NULL default '0',
  `reference` varchar(40) NOT NULL default '',
  `qty` double NOT NULL default '1',
  `discountpercent` double NOT NULL default '0',
  `standardcost` double NOT NULL default '0',
  `show_on_inv_crds` tinyint(4) NOT NULL default '1',
  `newqoh` double NOT NULL default '0',
  `hidemovt` tinyint(4) NOT NULL default '0',
  `narrative` text,
  PRIMARY KEY  (`stkmoveno`),
  KEY `DebtorNo` (`debtorno`),
  KEY `LocCode` (`loccode`),
  KEY `Prd` (`prd`),
  KEY `StockID_2` (`stockid`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type` (`type`),
  KEY `Show_On_Inv_Crds` (`show_on_inv_crds`),
  KEY `Hide` (`hidemovt`),
  KEY `reference` (`reference`),
  CONSTRAINT `stockmoves_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockmoves_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `stockmoves_ibfk_3` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `stockmoves_ibfk_4` FOREIGN KEY (`prd`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockmovestaxes`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockmovestaxes` (
  `stkmoveno` int(11) NOT NULL default '0',
  `taxauthid` tinyint(4) NOT NULL default '0',
  `taxrate` double NOT NULL default '0',
  `taxontax` tinyint(4) NOT NULL default '0',
  `taxcalculationorder` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`stkmoveno`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  KEY `calculationorder` (`taxcalculationorder`),
  CONSTRAINT `stockmovestaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockserialitems`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockserialitems` (
  `stockid` varchar(20) NOT NULL default '',
  `loccode` varchar(5) NOT NULL default '',
  `serialno` varchar(30) NOT NULL default '',
  `expirationdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `quantity` double NOT NULL default '0',
  PRIMARY KEY  (`stockid`,`serialno`,`loccode`),
  KEY `StockID` (`stockid`),
  KEY `LocCode` (`loccode`),
  KEY `serialno` (`serialno`),
  CONSTRAINT `stockserialitems_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockserialitems_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stockserialmoves`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stockserialmoves` (
  `stkitmmoveno` int(11) NOT NULL auto_increment,
  `stockmoveno` int(11) NOT NULL default '0',
  `stockid` varchar(20) NOT NULL default '',
  `serialno` varchar(30) NOT NULL default '',
  `moveqty` double NOT NULL default '0',
  PRIMARY KEY  (`stkitmmoveno`),
  KEY `StockMoveNo` (`stockmoveno`),
  KEY `StockID_SN` (`stockid`,`serialno`),
  KEY `serialno` (`serialno`),
  CONSTRAINT `stockserialmoves_ibfk_1` FOREIGN KEY (`stockmoveno`) REFERENCES `stockmoves` (`stkmoveno`),
  CONSTRAINT `stockserialmoves_ibfk_2` FOREIGN KEY (`stockid`, `serialno`) REFERENCES `stockserialitems` (`stockid`, `serialno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `suppallocs`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `suppallocs` (
  `id` int(11) NOT NULL auto_increment,
  `amt` double NOT NULL default '0',
  `datealloc` date NOT NULL default '0000-00-00',
  `transid_allocfrom` int(11) NOT NULL default '0',
  `transid_allocto` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `TransID_AllocFrom` (`transid_allocfrom`),
  KEY `TransID_AllocTo` (`transid_allocto`),
  KEY `DateAlloc` (`datealloc`),
  CONSTRAINT `suppallocs_ibfk_1` FOREIGN KEY (`transid_allocfrom`) REFERENCES `supptrans` (`id`),
  CONSTRAINT `suppallocs_ibfk_2` FOREIGN KEY (`transid_allocto`) REFERENCES `supptrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `suppliercontacts`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `suppliercontacts` (
  `supplierid` varchar(10) NOT NULL default '',
  `contact` varchar(30) NOT NULL default '',
  `position` varchar(30) NOT NULL default '',
  `tel` varchar(30) NOT NULL default '',
  `fax` varchar(30) NOT NULL default '',
  `mobile` varchar(30) NOT NULL default '',
  `email` varchar(55) NOT NULL default '',
  `ordercontact` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`supplierid`,`contact`),
  KEY `Contact` (`contact`),
  KEY `SupplierID` (`supplierid`),
  CONSTRAINT `suppliercontacts_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `suppliers`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `suppliers` (
  `supplierid` varchar(10) NOT NULL default '',
  `suppname` varchar(40) NOT NULL default '',
  `address1` varchar(40) NOT NULL default '',
  `address2` varchar(40) NOT NULL default '',
  `address3` varchar(40) NOT NULL default '',
  `address4` varchar(50) NOT NULL default '',
  `address5` varchar(20) NOT NULL default '',
  `address6` varchar(15) NOT NULL default '',
  `lat` FLOAT( 10, 6 ) NOT NULL default 0.0,
  `lng` FLOAT( 10, 6 ) NOT NULL default 0.0,
  `currcode` char(3) NOT NULL default '',
  `suppliersince` date NOT NULL default '0000-00-00',
  `paymentterms` char(2) NOT NULL default '',
  `lastpaid` double NOT NULL default '0',
  `lastpaiddate` datetime default NULL,
  `bankact` varchar(30) NOT NULL default '',
  `bankref` varchar(12) NOT NULL default '',
  `bankpartics` varchar(12) NOT NULL default '',
  `remittance` tinyint(4) NOT NULL default '1',
  `taxgroupid` tinyint(4) NOT NULL default '1',
  `factorcompanyid` int(11) NOT NULL default '1',
  `taxref` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`supplierid`),
  KEY `CurrCode` (`currcode`),
  KEY `PaymentTerms` (`paymentterms`),
  KEY `SupplierID` (`supplierid`),
  KEY `SuppName` (`suppname`),
  KEY `taxgroupid` (`taxgroupid`),
  KEY `suppliers_ibfk_4` (`factorcompanyid`),
  CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`currcode`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `suppliers_ibfk_2` FOREIGN KEY (`paymentterms`) REFERENCES `paymentterms` (`termsindicator`),
  CONSTRAINT `suppliers_ibfk_3` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`),
  CONSTRAINT `suppliers_ibfk_4` FOREIGN KEY (`factorcompanyid`) REFERENCES `factorcompanies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `supptrans`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `supptrans` (
  `transno` int(11) NOT NULL default '0',
  `type` smallint(6) NOT NULL default '0',
  `supplierno` varchar(10) NOT NULL default '',
  `suppreference` varchar(20) NOT NULL default '',
  `trandate` date NOT NULL default '0000-00-00',
  `duedate` date NOT NULL default '0000-00-00',
  `settled` tinyint(4) NOT NULL default '0',
  `rate` double NOT NULL default '1',
  `ovamount` double NOT NULL default '0',
  `ovgst` double NOT NULL default '0',
  `diffonexch` double NOT NULL default '0',
  `alloc` double NOT NULL default '0',
  `transtext` text,
  `hold` tinyint(4) NOT NULL default '0',
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `TypeTransNo` (`transno`,`type`),
  KEY `DueDate` (`duedate`),
  KEY `Hold` (`hold`),
  KEY `SupplierNo` (`supplierno`),
  KEY `Settled` (`settled`),
  KEY `SupplierNo_2` (`supplierno`,`suppreference`),
  KEY `SuppReference` (`suppreference`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type` (`type`),
  CONSTRAINT `supptrans_ibfk_1` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `supptrans_ibfk_2` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `supptranstaxes`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `supptranstaxes` (
  `supptransid` int(11) NOT NULL default '0',
  `taxauthid` tinyint(4) NOT NULL default '0',
  `taxamount` double NOT NULL default '0',
  PRIMARY KEY  (`supptransid`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `supptranstaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `supptranstaxes_ibfk_2` FOREIGN KEY (`supptransid`) REFERENCES `supptrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `systypes`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `systypes` (
  `typeid` smallint(6) NOT NULL default '0',
  `typename` char(50) NOT NULL default '',
  `typeno` int(11) NOT NULL default '1',
  PRIMARY KEY  (`typeid`),
  KEY `TypeNo` (`typeno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
`tagref` tinyint(4) NOT NULL auto_increment,
`tagdescription` varchar(50) NOT NULL,
PRIMARY KEY (`tagref`)
) ENGINE=InnoDB;

--
-- Table structure for table `taxauthorities`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `taxauthorities` (
  `taxid` tinyint(4) NOT NULL auto_increment,
  `description` varchar(20) NOT NULL default '',
  `taxglcode` int(11) NOT NULL default '0',
  `purchtaxglaccount` int(11) NOT NULL default '0',
  `bank` varchar(50) NOT NULL default '',
  `bankacctype` varchar(20) NOT NULL default '',
  `bankacc` varchar(50) NOT NULL default '',
  `bankswift` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`taxid`),
  KEY `TaxGLCode` (`taxglcode`),
  KEY `PurchTaxGLAccount` (`purchtaxglaccount`),
  CONSTRAINT `taxauthorities_ibfk_1` FOREIGN KEY (`taxglcode`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `taxauthorities_ibfk_2` FOREIGN KEY (`purchtaxglaccount`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `taxauthrates`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `taxauthrates` (
  `taxauthority` tinyint(4) NOT NULL default '1',
  `dispatchtaxprovince` tinyint(4) NOT NULL default '1',
  `taxcatid` tinyint(4) NOT NULL default '0',
  `taxrate` double NOT NULL default '0',
  PRIMARY KEY  (`taxauthority`,`dispatchtaxprovince`,`taxcatid`),
  KEY `TaxAuthority` (`taxauthority`),
  KEY `dispatchtaxprovince` (`dispatchtaxprovince`),
  KEY `taxcatid` (`taxcatid`),
  CONSTRAINT `taxauthrates_ibfk_1` FOREIGN KEY (`taxauthority`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `taxauthrates_ibfk_2` FOREIGN KEY (`taxcatid`) REFERENCES `taxcategories` (`taxcatid`),
  CONSTRAINT `taxauthrates_ibfk_3` FOREIGN KEY (`dispatchtaxprovince`) REFERENCES `taxprovinces` (`taxprovinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `taxcategories`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `taxcategories` (
  `taxcatid` tinyint(4) NOT NULL auto_increment,
  `taxcatname` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`taxcatid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `taxgroups`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `taxgroups` (
  `taxgroupid` tinyint(4) NOT NULL auto_increment,
  `taxgroupdescription` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`taxgroupid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `taxgrouptaxes`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `taxgrouptaxes` (
  `taxgroupid` tinyint(4) NOT NULL default '0',
  `taxauthid` tinyint(4) NOT NULL default '0',
  `calculationorder` tinyint(4) NOT NULL default '0',
  `taxontax` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`taxgroupid`,`taxauthid`),
  KEY `taxgroupid` (`taxgroupid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `taxgrouptaxes_ibfk_1` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`),
  CONSTRAINT `taxgrouptaxes_ibfk_2` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `taxprovinces`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `taxprovinces` (
  `taxprovinceid` tinyint(4) NOT NULL auto_increment,
  `taxprovincename` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`taxprovinceid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `unitsofmeasure`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `unitsofmeasure` (
  `unitid` tinyint(4) NOT NULL auto_increment,
  `unitname` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`unitid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `woitems`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `woitems` (
  `wo` int(11) NOT NULL,
  `stockid` char(20) NOT NULL default '',
  `qtyreqd` double NOT NULL default '1',
  `qtyrecd` double NOT NULL default '0',
  `stdcost` double NOT NULL,
  `nextlotsnref` varchar(20) default '',
  PRIMARY KEY  (`wo`,`stockid`),
  KEY `stockid` (`stockid`),
  CONSTRAINT `woitems_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `woitems_ibfk_2` FOREIGN KEY (`wo`) REFERENCES `workorders` (`wo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `worequirements`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `worequirements` (
  `wo` int(11) NOT NULL,
  `parentstockid` varchar(20) NOT NULL,
  `stockid` varchar(20) NOT NULL,
  `qtypu` double NOT NULL default '1',
  `stdcost` double NOT NULL default '0',
  `autoissue` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`wo`,`parentstockid`,`stockid`),
  KEY `stockid` (`stockid`),
  KEY `worequirements_ibfk_3` (`parentstockid`),
  CONSTRAINT `worequirements_ibfk_1` FOREIGN KEY (`wo`) REFERENCES `workorders` (`wo`),
  CONSTRAINT `worequirements_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `worequirements_ibfk_3` FOREIGN KEY (`wo`, `parentstockid`) REFERENCES `woitems` (`wo`, `stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `workcentres`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `workcentres` (
  `code` char(5) NOT NULL default '',
  `location` char(5) NOT NULL default '',
  `description` char(20) NOT NULL default '',
  `capacity` double NOT NULL default '1',
  `overheadperhour` decimal(10,0) NOT NULL default '0',
  `overheadrecoveryact` int(11) NOT NULL default '0',
  `setuphrs` decimal(10,0) NOT NULL default '0',
  PRIMARY KEY  (`code`),
  KEY `Description` (`description`),
  KEY `Location` (`location`),
  CONSTRAINT `workcentres_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `workorders`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `workorders` (
  `wo` int(11) NOT NULL,
  `loccode` char(5) NOT NULL default '',
  `requiredby` date NOT NULL default '0000-00-00',
  `startdate` date NOT NULL default '0000-00-00',
  `costissued` double NOT NULL default '0',
  `closed` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`wo`),
  KEY `LocCode` (`loccode`),
  KEY `StartDate` (`startdate`),
  KEY `RequiredBy` (`requiredby`),
  CONSTRAINT `worksorders_ibfk_1` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `www_users`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `www_users` (
  `userid` varchar(20) NOT NULL default '',
  `password` text NOT NULL,
  `realname` varchar(35) NOT NULL default '',
  `customerid` varchar(10) NOT NULL default '',
  `phone` varchar(30) NOT NULL default '',
  `email` varchar(55) default NULL,
  `defaultlocation` varchar(5) NOT NULL default '',
  `fullaccess` int(11) NOT NULL default '1',
  `lastvisitdate` datetime default NULL,
  `branchcode` varchar(10) NOT NULL default '',
  `pagesize` varchar(20) NOT NULL default 'A4',
  `modulesallowed` varchar(20) NOT NULL default '',
  `blocked` tinyint(4) NOT NULL default '0',
  `displayrecordsmax` int(11) NOT NULL default '0',
  `theme` varchar(30) NOT NULL default 'fresh',
  `language` varchar(5) NOT NULL default 'en_GB',
  PRIMARY KEY  (`userid`),
  KEY `CustomerID` (`customerid`),
  KEY `DefaultLocation` (`defaultlocation`),
  CONSTRAINT `www_users_ibfk_1` FOREIGN KEY (`defaultlocation`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-07-29  9:37:14
-- MySQL dump 10.11
--
-- Host: localhost    Database: weberp
-- ------------------------------------------------------
-- Server version	5.0.51a
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- MySQL dump 10.9
--
-- Host: localhost    Database: weberp
-- ------------------------------------------------------
-- Server version	5.0.18
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `accountgroups`
--

INSERT INTO `accountgroups` VALUES('Fixed Assets',1,0,100,'');
INSERT INTO `accountgroups` VALUES('Current Assets',1,0,700,'');
INSERT INTO `accountgroups` VALUES('Current Liabilities',2,0,800,'');
INSERT INTO `accountgroups` VALUES('Funds',2,1,3000,'');
INSERT INTO `accountgroups` VALUES('General Operations',4,1,3010,'');
INSERT INTO `accountgroups` VALUES('Plaster House',4,1,3020,'');
INSERT INTO `accountgroups` VALUES('Outreach',4,1,3030,'');
INSERT INTO `accountgroups` VALUES('Revenues',3,1,3040,'');

--
-- Dumping data for table `accountsection`
--

INSERT INTO `accountsection` VALUES (1,'Assets');
INSERT INTO `accountsection` VALUES (2,'Liabilities');
INSERT INTO `accountsection` VALUES (3,'Income');
INSERT INTO `accountsection` VALUES (4,'Expenditure');

--
-- Dumping data for table `bankaccounts`
--

INSERT INTO `bankaccounts` VALUES (10112000,'TZS','NBC GENERAL OPERATIONS','','');
INSERT INTO `bankaccounts` VALUES (10141000,'TZS','CASH ON HAND - IMPREST','','');

--
-- Dumping data for table `chartmaster`
--

insert into `chartmaster` values (10112000,'NBC GENERAL OPERATIONS','Current Assets');
insert into `chartmaster` values (10141000,'CASH ON HAND - IMPREST','Current Assets');
insert into `chartmaster` values (10310000,'ACCOUNTS RECEIVABLE','Current Assets');
insert into `chartmaster` values (10430000,'EMPLOYEE ADVANCES','Current Assets');
insert into `chartmaster` values (11130000,'INVENTORY-STORES','Current Assets');
insert into `chartmaster` values (11160000,'INVENTORY-SURGERY','Current Assets');
insert into `chartmaster` values (11166000,'INVENTORY-PHARMACY','Current Assets');
insert into `chartmaster` values (11505000,'LAND &BUILDING','Fixed Assets');
insert into `chartmaster` values (11805000,'EQUIPMENT','Fixed Assets');
insert into `chartmaster` values (11905000,'VEHICLES','Fixed Assets');
insert into `chartmaster` values (12500000,'ACCUM DEPR - BUILDINGS','Fixed Assets');
insert into `chartmaster` values (12800000,'ACCUM DEPR - EQUIPMENT','Fixed Assets');
insert into `chartmaster` values (12900000,'ACCUM DEPR - VEHICLES','Fixed Assets');
insert into `chartmaster` values (20210000,'ACCOUNTS PAYABLE','Current Liabilities');
insert into `chartmaster` values (20230000,'ACCRUED AUDIT & PROF FEES','Current Liabilities');
insert into `chartmaster` values (20310000,'ACCRUED PAYROLL','Current Liabilities');
insert into `chartmaster` values (20320000,'ACCRUED - UTILITIES','Current Liabilities');
insert into `chartmaster` values (20350000,'PAYE PAYABLE','Current Liabilities');
insert into `chartmaster` values (20360000,'NSSF PAYABLE ','Current Liabilities');
insert into `chartmaster` values (20370000,'PPF PAYABLE ','Current Liabilities');
insert into `chartmaster` values (22100000,'GENERAL FUND BALANCE','Funds');
insert into `chartmaster` values (22200000,'EARMARKED FUND BALANCE','Funds');
insert into `chartmaster` values (3310000,'Salaries- core staff','General Operations');
insert into `chartmaster` values (3315000,'Travel -General','General Operations');
insert into `chartmaster` values (320000,'TANESCO','General Operations');
insert into `chartmaster` values (3325000,'Water','General Operations');
insert into `chartmaster` values (3330000,'Stationery & Office Supplies','General Operations');
insert into `chartmaster` values (3335000,'Guests','General Operations');
insert into `chartmaster` values (3340000,'Meetings SOI','General Operations');
insert into `chartmaster` values (3345000,'meetings - Outside','General Operations');
insert into `chartmaster` values (350000,'Communication & Post','General Operations');
insert into `chartmaster` values (3355000,'Subscriptions and newspapers','General Operations');
insert into `chartmaster` values (3360000,'Fuel Vehicles','General Operations');
insert into `chartmaster` values (3365000,'Vehicle -Insurance and road licence','General Operations');
insert into `chartmaster` values (3370000,'Vehicle- Repairs and Maintanance','General Operations');
insert into `chartmaster` values (373000,'Medical bills-SLH, ALMC','General Operations');
insert into `chartmaster` values (3380000,'Salaries','Plaster House');
insert into `chartmaster` values (3381000,'Food ','Plaster House');
insert into `chartmaster` values (3382000,'Firewood, gas etc (cooking)','Plaster House');
insert into `chartmaster` values (3383000,'TANESCO','Plaster House');
insert into `chartmaster` values (3384000,'Water','Plaster House');
insert into `chartmaster` values (3385000,'Cleaning -usafi','Plaster House');
insert into `chartmaster` values (3386000,'Minor equipment','Plaster House');
insert into `chartmaster` values (3387000,'Repairs','Plaster House');
insert into `chartmaster` values (3388000,'Linen','Plaster House');
insert into `chartmaster` values (3390000,'Travel','Outreach');
insert into `chartmaster` values (3391000,'Perdiems','Outreach');
insert into `chartmaster` values (3392000,'Donations','Outreach');
insert into `chartmaster` values (3393000,'Supplies','Outreach');
insert into `chartmaster` values (440000,'REVENUE- DONATIONS-GENERAL','Revenues');
insert into `chartmaster` values (441000,'REVENUE- DONATIONS-PLASTER HOUSE','Revenues');
insert into `chartmaster` values (442000,'REVENUE- DONATIONS-OUTREACH','Revenues');
insert into `chartmaster` values (443000,'REVENUE - INPATIENT','Revenues');
insert into `chartmaster` values (444000,'REVENUE-OP','Revenues');
insert into `chartmaster` values (445000,'REVENUE-OCC THERAPY IP','Revenues');
insert into `chartmaster` values (446000,'REVENUE-OCC THERAPY OP ','Revenues');
insert into `chartmaster` values (447000,'REVENUES-PHYSICAL THERAPY  IP ','Revenues');
insert into `chartmaster` values (448000,'REVENUES-PHYSICAL THERAPY  OP ','Revenues');

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` VALUES (1,'Selian Lutheran Hospital','P.O. Box 3164','ARUSHA','','','','','','Tanzania','','','selianlh@habari.co.tz','TZS',10310000,96001001,20210000,20310000,20232000,96001001,96001001,22201000,1,1,1,96001001);

--
-- Dumping data for table `cogsglpostings`
--

INSERT INTO `cogsglpostings` VALUES (1,'AN','ANY',30101000,'AN');

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` VALUES ('Euros','EUR','Eurozone','cents',1);
INSERT INTO `currencies` VALUES ('Pounds','GBP','United Kingdom','Pence',0.8);
INSERT INTO `currencies` VALUES ('US Dollars','USD','United States','Cents',1);
INSERT INTO `currencies` VALUES ('Tanzania Shilling','TZS','Tanzania','Cents',1);

--
-- Dumping data for table `factorcompanies`
--

INSERT INTO `factorcompanies` ( `id` , `coyname` ) VALUES (null, 'None');

--
-- Dumping data for table `holdreasons`
--

INSERT INTO `holdreasons` VALUES (1,'Good History',0);
INSERT INTO `holdreasons` VALUES (20,'Watch',0);
INSERT INTO `holdreasons` VALUES (51,'In liquidation',1);

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` VALUES ('SEL','Selian','Selian Lutheran Hospital','','','','','Tanzania','','3','','',1,0);
INSERT INTO `locations` VALUES ('PHA','Pharmacy','Selian Lutheran Hospital','','','','','Tanzania','','3','','',1,0);
INSERT INTO `locations` VALUES ('GAR','Ward 1','Selian Lutheran Hospital','','','','','Tanzania','','3','','',1,0);

--
-- Dumping data for table `paymentterms`
--

INSERT INTO `paymentterms` VALUES ('20','Due 20th Of the Following Month',0,22);
INSERT INTO `paymentterms` VALUES ('30','Due By End Of The Following Month',0,30);
INSERT INTO `paymentterms` VALUES ('7','Payment due within 7 days',7,0);
INSERT INTO `paymentterms` VALUES ('CA','Cash Only',1,0);

--
-- Dumping data for table `salesglpostings`
--

INSERT INTO `salesglpostings` VALUES (1,'ANY','ANY',30101000,30101000,'AN');

--
-- Dumping data for table `systypes`
--

INSERT INTO `systypes` VALUES (0,'Journal - GL',2);
INSERT INTO `systypes` VALUES (1,'Payment - GL',1);
INSERT INTO `systypes` VALUES (2,'Receipt - GL',0);
INSERT INTO `systypes` VALUES (3,'Standing Journal',0);
INSERT INTO `systypes` VALUES (10,'Sales Invoice',1);
INSERT INTO `systypes` VALUES (11,'Credit Note',1);
INSERT INTO `systypes` VALUES (12,'Receipt',1);
INSERT INTO `systypes` VALUES (14,'Stock Issue',0);
INSERT INTO `systypes` VALUES (15,'Journal - Debtors',0);
INSERT INTO `systypes` VALUES (16,'Location Transfer',5);
INSERT INTO `systypes` VALUES (17,'Stock Adjustment',16);
INSERT INTO `systypes` VALUES (18,'Purchase Order',0);
INSERT INTO `systypes` VALUES (20,'Purchase Invoice',17);
INSERT INTO `systypes` VALUES (21,'Debit Note',3);
INSERT INTO `systypes` VALUES (22,'Creditors Payment',4);
INSERT INTO `systypes` VALUES (23,'Creditors Journal',0);
INSERT INTO `systypes` VALUES (25,'Purchase Order Delivery',17);
INSERT INTO `systypes` VALUES (26,'Work Order Receipt',2);
INSERT INTO `systypes` VALUES (28,'Work Order Issue',4);
INSERT INTO `systypes` VALUES (29,'Work Order Variance',1);
INSERT INTO `systypes` VALUES (30,'Sales Order',6);
INSERT INTO `systypes` VALUES (31,'Shipment Close',26);
INSERT INTO `systypes` VALUES (35,'Cost Update',14);
INSERT INTO `systypes` VALUES ('36', 'Exchange Difference', '1');
INSERT INTO `systypes` VALUES (40, 'Work Order', '1');
INSERT INTO `systypes` VALUES (50,'Opening Balance',0);
INSERT INTO `systypes` VALUES (500,'Auto Debtor Number',0);

--
-- Dumping data for table `taxauthorities`
--

INSERT INTO `taxauthorities` VALUES (1,'Tanzanian VAT',20360000,20360000,'','','','');

--
-- Dumping data for table `taxgroups`
--

INSERT INTO `taxgroups` VALUES (1,'Default tax group');

--
-- Dumping data for table `taxauthrates`
--

INSERT INTO `taxauthrates` VALUES (1,1,1,0);

--
-- Dumping data for table `taxcategories`
--

INSERT INTO `taxcategories` VALUES (1,'Taxable supply');
INSERT INTO `taxcategories` VALUES (5,'Freight');

--
-- Dumping data for table `taxprovinces`
--

INSERT INTO `taxprovinces` VALUES (1,'Default Tax province');

--
-- Dumping data for table `www_users`
--

INSERT INTO `www_users` VALUES ('admin','selian','Admin user','','','','SEL',8,'2008-064-30 21:34:05','','A4','1,1,1,1,1,1,1,1,',0,50,'professional','en_GB');

--
-- Dumping data for table `edi_orders_segs`
--

INSERT INTO `edi_orders_segs` VALUES (1,'UNB',0,1);
INSERT INTO `edi_orders_segs` VALUES (2,'UNH',0,1);
INSERT INTO `edi_orders_segs` VALUES (3,'BGM',0,1);
INSERT INTO `edi_orders_segs` VALUES (4,'DTM',0,35);
INSERT INTO `edi_orders_segs` VALUES (5,'PAI',0,1);
INSERT INTO `edi_orders_segs` VALUES (6,'ALI',0,5);
INSERT INTO `edi_orders_segs` VALUES (7,'FTX',0,99);
INSERT INTO `edi_orders_segs` VALUES (8,'RFF',1,1);
INSERT INTO `edi_orders_segs` VALUES (9,'DTM',1,5);
INSERT INTO `edi_orders_segs` VALUES (10,'NAD',2,1);
INSERT INTO `edi_orders_segs` VALUES (11,'LOC',2,99);
INSERT INTO `edi_orders_segs` VALUES (12,'FII',2,5);
INSERT INTO `edi_orders_segs` VALUES (13,'RFF',3,1);
INSERT INTO `edi_orders_segs` VALUES (14,'CTA',5,1);
INSERT INTO `edi_orders_segs` VALUES (15,'COM',5,5);
INSERT INTO `edi_orders_segs` VALUES (16,'TAX',6,1);
INSERT INTO `edi_orders_segs` VALUES (17,'MOA',6,1);
INSERT INTO `edi_orders_segs` VALUES (18,'CUX',7,1);
INSERT INTO `edi_orders_segs` VALUES (19,'DTM',7,5);
INSERT INTO `edi_orders_segs` VALUES (20,'PAT',8,1);
INSERT INTO `edi_orders_segs` VALUES (21,'DTM',8,5);
INSERT INTO `edi_orders_segs` VALUES (22,'PCD',8,1);
INSERT INTO `edi_orders_segs` VALUES (23,'MOA',9,1);
INSERT INTO `edi_orders_segs` VALUES (24,'TDT',10,1);
INSERT INTO `edi_orders_segs` VALUES (25,'LOC',11,1);
INSERT INTO `edi_orders_segs` VALUES (26,'DTM',11,5);
INSERT INTO `edi_orders_segs` VALUES (27,'TOD',12,1);
INSERT INTO `edi_orders_segs` VALUES (28,'LOC',12,2);
INSERT INTO `edi_orders_segs` VALUES (29,'PAC',13,1);
INSERT INTO `edi_orders_segs` VALUES (30,'PCI',14,1);
INSERT INTO `edi_orders_segs` VALUES (31,'RFF',14,1);
INSERT INTO `edi_orders_segs` VALUES (32,'DTM',14,5);
INSERT INTO `edi_orders_segs` VALUES (33,'GIN',14,10);
INSERT INTO `edi_orders_segs` VALUES (34,'EQD',15,1);
INSERT INTO `edi_orders_segs` VALUES (35,'ALC',19,1);
INSERT INTO `edi_orders_segs` VALUES (36,'ALI',19,5);
INSERT INTO `edi_orders_segs` VALUES (37,'DTM',19,5);
INSERT INTO `edi_orders_segs` VALUES (38,'QTY',20,1);
INSERT INTO `edi_orders_segs` VALUES (39,'RNG',20,1);
INSERT INTO `edi_orders_segs` VALUES (40,'PCD',21,1);
INSERT INTO `edi_orders_segs` VALUES (41,'RNG',21,1);
INSERT INTO `edi_orders_segs` VALUES (42,'MOA',22,1);
INSERT INTO `edi_orders_segs` VALUES (43,'RNG',22,1);
INSERT INTO `edi_orders_segs` VALUES (44,'RTE',23,1);
INSERT INTO `edi_orders_segs` VALUES (45,'RNG',23,1);
INSERT INTO `edi_orders_segs` VALUES (46,'TAX',24,1);
INSERT INTO `edi_orders_segs` VALUES (47,'MOA',24,1);
INSERT INTO `edi_orders_segs` VALUES (48,'LIN',28,1);
INSERT INTO `edi_orders_segs` VALUES (49,'PIA',28,25);
INSERT INTO `edi_orders_segs` VALUES (50,'IMD',28,99);
INSERT INTO `edi_orders_segs` VALUES (51,'MEA',28,99);
INSERT INTO `edi_orders_segs` VALUES (52,'QTY',28,99);
INSERT INTO `edi_orders_segs` VALUES (53,'ALI',28,5);
INSERT INTO `edi_orders_segs` VALUES (54,'DTM',28,35);
INSERT INTO `edi_orders_segs` VALUES (55,'MOA',28,10);
INSERT INTO `edi_orders_segs` VALUES (56,'GIN',28,127);
INSERT INTO `edi_orders_segs` VALUES (57,'QVR',28,1);
INSERT INTO `edi_orders_segs` VALUES (58,'FTX',28,99);
INSERT INTO `edi_orders_segs` VALUES (59,'PRI',32,1);
INSERT INTO `edi_orders_segs` VALUES (60,'CUX',32,1);
INSERT INTO `edi_orders_segs` VALUES (61,'DTM',32,5);
INSERT INTO `edi_orders_segs` VALUES (62,'RFF',33,1);
INSERT INTO `edi_orders_segs` VALUES (63,'DTM',33,5);
INSERT INTO `edi_orders_segs` VALUES (64,'PAC',34,1);
INSERT INTO `edi_orders_segs` VALUES (65,'QTY',34,5);
INSERT INTO `edi_orders_segs` VALUES (66,'PCI',36,1);
INSERT INTO `edi_orders_segs` VALUES (67,'RFF',36,1);
INSERT INTO `edi_orders_segs` VALUES (68,'DTM',36,5);
INSERT INTO `edi_orders_segs` VALUES (69,'GIN',36,10);
INSERT INTO `edi_orders_segs` VALUES (70,'LOC',37,1);
INSERT INTO `edi_orders_segs` VALUES (71,'QTY',37,1);
INSERT INTO `edi_orders_segs` VALUES (72,'DTM',37,5);
INSERT INTO `edi_orders_segs` VALUES (73,'TAX',38,1);
INSERT INTO `edi_orders_segs` VALUES (74,'MOA',38,1);
INSERT INTO `edi_orders_segs` VALUES (75,'NAD',39,1);
INSERT INTO `edi_orders_segs` VALUES (76,'CTA',42,1);
INSERT INTO `edi_orders_segs` VALUES (77,'COM',42,5);
INSERT INTO `edi_orders_segs` VALUES (78,'ALC',43,1);
INSERT INTO `edi_orders_segs` VALUES (79,'ALI',43,5);
INSERT INTO `edi_orders_segs` VALUES (80,'DTM',43,5);
INSERT INTO `edi_orders_segs` VALUES (81,'QTY',44,1);
INSERT INTO `edi_orders_segs` VALUES (82,'RNG',44,1);
INSERT INTO `edi_orders_segs` VALUES (83,'PCD',45,1);
INSERT INTO `edi_orders_segs` VALUES (84,'RNG',45,1);
INSERT INTO `edi_orders_segs` VALUES (85,'MOA',46,1);
INSERT INTO `edi_orders_segs` VALUES (86,'RNG',46,1);
INSERT INTO `edi_orders_segs` VALUES (87,'RTE',47,1);
INSERT INTO `edi_orders_segs` VALUES (88,'RNG',47,1);
INSERT INTO `edi_orders_segs` VALUES (89,'TAX',48,1);
INSERT INTO `edi_orders_segs` VALUES (90,'MOA',48,1);
INSERT INTO `edi_orders_segs` VALUES (91,'TDT',49,1);
INSERT INTO `edi_orders_segs` VALUES (92,'UNS',50,1);
INSERT INTO `edi_orders_segs` VALUES (93,'MOA',50,1);
INSERT INTO `edi_orders_segs` VALUES (94,'CNT',50,1);
INSERT INTO `edi_orders_segs` VALUES (95,'UNT',50,1);

--
-- Dumping data for table `edi_orders_seg_groups`
--

INSERT INTO `edi_orders_seg_groups` VALUES (0,1,0);
INSERT INTO `edi_orders_seg_groups` VALUES (1,9999,0);
INSERT INTO `edi_orders_seg_groups` VALUES (2,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (3,99,2);
INSERT INTO `edi_orders_seg_groups` VALUES (5,5,2);
INSERT INTO `edi_orders_seg_groups` VALUES (6,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (7,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (8,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (9,9999,8);
INSERT INTO `edi_orders_seg_groups` VALUES (10,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (11,10,10);
INSERT INTO `edi_orders_seg_groups` VALUES (12,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (13,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (14,5,13);
INSERT INTO `edi_orders_seg_groups` VALUES (15,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (19,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (20,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (21,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (22,2,19);
INSERT INTO `edi_orders_seg_groups` VALUES (23,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (24,5,19);
INSERT INTO `edi_orders_seg_groups` VALUES (28,200000,0);
INSERT INTO `edi_orders_seg_groups` VALUES (32,25,28);
INSERT INTO `edi_orders_seg_groups` VALUES (33,9999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (34,99,28);
INSERT INTO `edi_orders_seg_groups` VALUES (36,5,34);
INSERT INTO `edi_orders_seg_groups` VALUES (37,9999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (38,10,28);
INSERT INTO `edi_orders_seg_groups` VALUES (39,999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (42,5,39);
INSERT INTO `edi_orders_seg_groups` VALUES (43,99,28);
INSERT INTO `edi_orders_seg_groups` VALUES (44,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (45,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (46,2,43);
INSERT INTO `edi_orders_seg_groups` VALUES (47,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (48,5,43);
INSERT INTO `edi_orders_seg_groups` VALUES (49,10,28);
INSERT INTO `edi_orders_seg_groups` VALUES (50,1,0);

--
-- Dumping data for table `config`
--

INSERT INTO `config` VALUES ('AllowOrderLineItemNarrative','0');
INSERT INTO `config` VALUES ('AllowSalesOfZeroCostItems','0');
INSERT INTO `config` VALUES ('AutoDebtorNo','0');
INSERT INTO `config` VALUES ('AutoIssue','1');
INSERT INTO `config` VALUES ('CheckCreditLimits','1');
INSERT INTO `config` VALUES ('Check_Price_Charged_vs_Order_Price','1');
INSERT INTO `config` VALUES ('Check_Qty_Charged_vs_Del_Qty','1');
INSERT INTO `config` VALUES ('CountryOfOperation','AUD');
INSERT INTO `config` VALUES ('CreditingControlledItems_MustExist','0');
INSERT INTO `config` VALUES ('DB_Maintenance','30');
INSERT INTO `config` VALUES ('DB_Maintenance_LastRun','2007-09-26');
INSERT INTO `config` VALUES ('DefaultBlindPackNote','1');
INSERT INTO `config` VALUES ('DefaultCreditLimit','1000');
INSERT INTO `config` VALUES ('DefaultDateFormat','d/m/Y');
INSERT INTO `config` VALUES ('DefaultDisplayRecordsMax','50');
INSERT INTO `config` VALUES ('DefaultPriceList','DE');
INSERT INTO `config` VALUES ('DefaultTaxCategory','1');
INSERT INTO `config` VALUES ('DefaultTheme','silverwolf');
INSERT INTO `config` VALUES ('Default_Shipper','1');
INSERT INTO `config` VALUES ('DispatchCutOffTime','14');
INSERT INTO `config` VALUES ('DoFreightCalc','0');
INSERT INTO `config` VALUES ('EDIHeaderMsgId','D:01B:UN:EAN010');
INSERT INTO `config` VALUES ('EDIReference','WEBERP');
INSERT INTO `config` VALUES ('EDI_Incoming_Orders','companies/weberp/EDI_Incoming_Orders');
INSERT INTO `config` VALUES ('EDI_MsgPending','companies/weberp/EDI_MsgPending');
INSERT INTO `config` VALUES ('EDI_MsgSent','companies/weberp/EDI_Sent');
INSERT INTO `config` VALUES ('FreightChargeAppliesIfLessThan','1000');
INSERT INTO `config` VALUES ('FreightTaxCategory','1');
INSERT INTO `config` VALUES ('HTTPS_Only','0');
INSERT INTO `config` VALUES ('InvoicePortraitFormat','0');
INSERT INTO `config` VALUES ('MaxImageSize','300');
INSERT INTO `config` VALUES ('MonthsAuditTrail', '1');
INSERT INTO `config` VALUES ('NumberOfPeriodsOfStockUsage','12');
INSERT INTO `config` VALUES ('OverChargeProportion','30');
INSERT INTO `config` VALUES ('OverReceiveProportion','20');
INSERT INTO `config` VALUES ('PackNoteFormat','1');
INSERT INTO `config` VALUES ('PageLength','48');
INSERT INTO `config` VALUES ('part_pics_dir','companies/weberp/part_pics');
INSERT INTO `config` VALUES ('PastDueDays1','30');
INSERT INTO `config` VALUES ('PastDueDays2','60');
INSERT INTO `config` VALUES ('PO_AllowSameItemMultipleTimes','1');
INSERT INTO `config` VALUES ('ProhibitJournalsToControlAccounts','1');
INSERT INTO `config` VALUES ('ProhibitPostingsBefore','2006-09-30');
INSERT INTO `config` VALUES ('ProhibitNegativeStock','1');
INSERT INTO `config` VALUES ('QuickEntries','10');
INSERT INTO `config` VALUES ('RadioBeaconFileCounter','/home/RadioBeacon/FileCounter');
INSERT INTO `config` VALUES ('RadioBeaconFTP_user_name','RadioBeacon ftp server user name');
INSERT INTO `config` VALUES ('RadioBeaconHomeDir','/home/RadioBeacon');
INSERT INTO `config` VALUES ('RadioBeaconStockLocation','BL');
INSERT INTO `config` VALUES ('RadioBeaconFTP_server','192.168.2.2');
INSERT INTO `config` VALUES ('RadioBeaconFilePrefix','ORDXX');
INSERT INTO `config` VALUES ('RadioBeaconFTP_user_pass','Radio Beacon remote ftp server password');
INSERT INTO `config` VALUES ('reports_dir','companies/weberp/reports');
INSERT INTO `config` VALUES ('RomalpaClause','Ownership will not pass to the buyer until the goods have been paid for in full.');
INSERT INTO `config` VALUES ('Show_Settled_LastMonth','1');
INSERT INTO `config` VALUES ('SO_AllowSameItemMultipleTimes','1');
INSERT INTO `config` VALUES ('TaxAuthorityReferenceName','Tax Ref');
INSERT INTO `config` VALUES ('WeightedAverageCosting','1');
INSERT INTO `config` VALUES ('WikiApp','Disabled');
INSERT INTO `config` VALUES ('WikiPath','wiki');
INSERT INTO `config` VALUES ('YearEnd','3');

--
-- Dumping data for table `unitsofmeasure`
--

INSERT INTO `unitsofmeasure` VALUES (1,'each');
INSERT INTO `unitsofmeasure` VALUES (2,'metres');
INSERT INTO `unitsofmeasure` VALUES (3,'kgs');
INSERT INTO `unitsofmeasure` VALUES (4,'litres');
INSERT INTO `unitsofmeasure` VALUES (5,'length');
INSERT INTO `unitsofmeasure` VALUES (6,'pack');

--
-- Dumping data for table `stockcategory`
--

INSERT INTO `stockcategory` VALUES('A','Medicine', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('B','Medical Supplies', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('C','Office Materials', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('D','Food Supplies', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('E','Plumbing materials', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('F','Electric material', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('G','Painting materials', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('H','Carpentry materials', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('I','Mechanical materials', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('J','Iron sheets', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('K','Cement& Lime Bags', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('L','Medical Equip spares', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('M','Farming equip spares', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('N','Vehicles spares', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('O','Caterpiller spares', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('P','Lister Petter spares', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('Q','Scania spares', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('R','Fuel & Lubricants', 'F',11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('S','Shamba Products/Farm', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('T','Tractor spares', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);
INSERT INTO `stockcategory` VALUES('U','Safety Materials', 'F', 11166000, 80303000, 80303000, 80303000, 11166000);

--
-- Dumping data for table `stockmaster`
--

INSERT INTO stockmaster VALUES('R214410','A','Acetazolamide tabs','Acetazolamide tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F752100','A','Acyclovir tabs','Acyclovir tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F752101','A','Acyclovir cream','Acyclovir cream','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D431000','A','Adrenalin injection ','Adrenalin injection ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F711201','A','Abendazole tabs','Abendazole tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B241000','A','Allopurinol tabs ','Allopurinol tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721500','A','ALU for 15-25kg patients','ALU for 15-25kg patients','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721510','A','ALU for 25-34kg patients','ALU for 25-34kg patients','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721520','A','ALU for 35kg and adult patients','ALU for 35kg and adult patients','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721530','A','ALU for 5-15kg patients','ALU for 5-15kg patients','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R213100','A','Amethocaine eye drops','Amethocaine eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('V251320','A','Aminophylline  tabs','Aminophylline  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('V251321','A','Aminophylline inject.','Aminophylline inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('V241111','A','Amitriptyline  tabs','Amitriptyline  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731220','A','Amoxycillin  caps','Amoxycillin  caps','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731221','A','Amoxycillin syrup','Amoxycillin syrup','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731210','A','Ampicillin  injection ','Ampicillin  injection ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731211','A','Ampiclox cpas','Ampiclox cpas','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M156200','A','Anhaemorrhoid cream','Anhaemorrhoid cream','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M156100','A','Antihaemorrhoid suppository','Antihaemorrhoid suppository','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('Q202220','A','Antirabies vaccine','Antirabies vaccine','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721600','A','Artesunate inject.','Artesunate inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721610','A','Artesunate tabs','Artesunate tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B211000','A','Aspirin tabs','Aspirin tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X271300','A','Ascorbic acid tabs','Ascorbic acid tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K133110','A','Atenolol tabs','Atenolol tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R215100','A','Atropine eye drops','Atropine eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A131100','A','Atropine injection','Atropine injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F735200','A','Azithromycin  tabs','Azithromycin  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731111','A','Benzyl penicilin inject.','Benzyl penicilin inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('V242211','A','Benzhexoh tabs','Benzhexoh tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731121','A','Benzathine penicillin injection','Benzathine penicillin injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L142710','A','Bethamethasone cream','Bethamethasone cream','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R212100','A','Bethamethasone eye drops','Bethamethasone eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M154210','A','Bisacodyl  tabs','Bisacodyl  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R221110','A','Boric acid ear drops','Boric acid ear drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A121000','A','Bupivacaine heavy injection','Bupivacaine heavy injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A121100','A','Bupivacaine spinal injection','Bupivacaine spinal injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X272310','A','Calcium gluconate inject.','Calcium gluconate inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K133610','A','Captopril tabs','Captopril tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E610000','A','Carbamazepine  tabs','Carbamazepine  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('P182100','A','Carbimazole tabs','Carbimazole tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F732310','A','Cefotaxime injection','Cefotaxime injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F732330','A','Ceftriaxone injection 1g','Ceftriaxone injection 1g','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F732331','A','Ceftriaxone 250mg inj','Ceftriaxone 250mg inj','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('P196212','A','Celestone injection','Celestone injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M151210','A','Cimetidine tabs','Cimetidine tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D412101','A','Cetrizine tabs','Cetrizine tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F738100','A','Chloramphenical injection','Chloramphenical injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F738110','A','Chloramphenical  caps','Chloramphenical  caps','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R211100','A','Chloramphenicol ear drops','Chloramphenicol ear drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R211110','A','Chloramphenicol eye drops ','Chloramphenicol eye drops ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R211111','A','Chloramphenicol eye ointment','Chloramphenicol eye ointment','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F738111','A','Chloramphenicol syrup','Chloramphenicol syrup','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D412100','A','Chlorpheniramine   tabs','Chlorpheniramine   tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D412110','A','Chlorpheniramine inject.','Chlorpheniramine inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('V242110','A','Chlorpromazine  tabs 25mg','Chlorpromazine  tabs 25mg','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('V242112','A','Chlorpromazine inject.','Chlorpromazine inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('N162110','A','Chlorpropamide  tabs','Chlorpropamide  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F737100','A','Ciprofloxacin  tabs','Ciprofloxacin  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R211170','A','Ciprofloxacin eye drops','Ciprofloxacin eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F737110','A','Ciprofloxacin injection','Ciprofloxacin injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L143200','A','Clotrimazole cream','Clotrimazole cream','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L143210','A','Clotrimazole pessaries','Clotrimazole pessaries','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731232','A','Cloxacilin syrup','Cloxacilin syrup','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731230','A','Cloxacillin caps','Cloxacillin caps','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731231','A','Cloxacillin  injection ','Cloxacillin  injection ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F736100','A','Co-trimoxazole  tabs','Co-trimoxazole  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F736110','A','Cotrimoxazole syrup','Cotrimoxazole syrup','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W252220','A','Cough mixture','Cough mixture','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R215200','A','Cyclopentolate eye drops','Cyclopentolate eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('G811300','A','Cyclophosphamide injection','Cyclophosphamide injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R212212','A','Dexamethason with chlor eye drops','Dexamethason with chlor eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R212210','A','Dexamethason with Genta.eye drops','Dexamethason with Genta.eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R212211','A','Dexamethason with Neomycin eye ','Dexamethason with Neomycin eye ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R212200','A','Dexamethasone eye drops','Dexamethasone eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D421000','A','Dexamethasone inject.','Dexamethasone inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D421100','A','Dexamethasone tabs ','Dexamethasone tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A133100','A','Diazepam inject.','Diazepam inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A133110','A','Diazepam tabs ','Diazepam tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B231200','A','Diclofenac tabs ','Diclofenac tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K132210','A','Digoxine tabs','Digoxine tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721120','A','Doxycyclin caps ','Doxycyclin caps ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R222210','A','Ephedrine adult nasal drops','Ephedrine adult nasal drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W251130','A','Ephedrine injection','Ephedrine injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R222211','A','Ephedrine paedriatic nasal drops','Ephedrine paedriatic nasal drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('U231100','A','Ergometrine injection','Ergometrine injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('C313100','A','Ergotamine tabs','Ergotamine tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F735100','A','Erythomycin tabs','Erythomycin tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F735110','A','Erythromycin syrup','Erythromycin syrup','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731110','A','Ethambutol  tabs','Ethambutol  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731120','A','Ethambutol with Isoniazide tabs','Ethambutol with Isoniazide tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721200','A','Fansidar tabs','Fansidar tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('H101100','A','Ferrous sulphate tabs','Ferrous sulphate tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('H101110','A','Ferrous with folic acid tabs','Ferrous with folic acid tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('H101111','A','Ferrous with vitamin B complex syrup','Ferrous with vitamin B complex syrup','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F742000','A','Fluconazole inject.','Fluconazole inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F742001','A','Fluconazole 150mg tabs','Fluconazole 150mg tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('V242120','A','Fluphenazine injection','Fluphenazine injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('H102100','A','Folic acid tabs','Folic acid tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K134220','A','Furosemide  injection','Furosemide  injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K134422','A','Furosemide  tbs','Furosemide  tbs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R211130','A','Gentamicin eye drops','Gentamicin eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F734200','A','Gentamycin injection','Gentamycin injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('N162120','A','Glibenclamide tabs','Glibenclamide tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F744000','A','Griseofulvin  tabs','Griseofulvin  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('V242210','A','Haloperidol tabs','Haloperidol tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A112300','A','Halothane inhalation','Halothane inhalation','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('J111110','A','Heparine  injection','Heparine  injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K133420','A','Hydralazine  Tabs','Hydralazine  Tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K133421','A','Hydralazine inj.','Hydralazine inj.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K134120','A','Hydrochlorothiazide tabs','Hydrochlorothiazide tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R212300','A','Hydrocortisone eye drops','Hydrocortisone eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D422000','A','Hydrocortisone injection','Hydrocortisone injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L142700','A','Hydrocortisone skin oint.','Hydrocortisone skin oint.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M152400','A','Hyoscine butylbromide  tbs','Hyoscine butylbromide  tbs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M152410','A','Hyoscine butylbromide inect.','Hyoscine butylbromide inect.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B231300','A','Ibuprofen  tabs ','Ibuprofen  tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B231400','A','Idomethacin tanbs ','Idomethacin tanbs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('P182200','A','Iodine (Lugols solution)','Iodine (Lugols solution)','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('N161100','A','Insulin actrapid','Insulin actrapid','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('N161210','A','Insulin insulatard','Insulin insulatard','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K131130','A','Isosobide dinitrate  tabs','Isosobide dinitrate  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A111200','A','Ketamine injection','Ketamine injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A122000','A','Lignocaine 2% injection','Lignocaine 2% injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A122100','A','Lignocaine with Adrenalin injection','Lignocaine with Adrenalin injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A122101','A','Lidocaine with dextrose','Lidocaine with dextrose','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M155210','A','Loperamide tabs','Loperamide tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('U232300','A','Magnesium sulphate inj.','Magnesium sulphate inj.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M151110','A','Magnesium trilicate tabs','Magnesium trilicate tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M151111','A','Magnesium Trisicate mixture','Magnesium Trisicate mixture','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F711200','A','Mebendazole tabs','Mebendazole tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('N162210','A','Metformin  tabs','Metformin  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R214111','A','Methylcellulose eye drops','Methylcellulose eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K133310','A','Methyldopa tabs','Methyldopa tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M153500','A','Metoclopramide  tabs','Metoclopramide  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F722200','A','Metronidazole tabs ','Metronidazole tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F722210','A','Metronidazole syrup ','Metronidazole syrup ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F722220','A','Metronidazole injection','Metronidazole injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X271700','A','Multivitamin tabs','Multivitamin tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A143100','A','Neostigmine inj.','Neostigmine inj.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F711300','A','Niclosamide  tabs','Niclosamide  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K131320','A','Nifedipine tabs 10mg','Nifedipine tabs 10mg','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K131321','A','Nifedipine tabs 20mg','Nifedipine tabs 20mg','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F739200','A','Nitrofurantoin tabs','Nitrofurantoin tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('P196211','A','Norethisterone tabs','Norethisterone tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F747000','A','Nystatin oral suspension ','Nystatin oral suspension ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F747001','A','Nystatin tabs ','Nystatin tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M155100','A','O.R.S. Satchets','O.R.S. Satchets','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M151310','A','Omeprazole tabs','Omeprazole tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('U231200','A','Oxytocin injection','Oxytocin injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731100','A','P.P.F. injection','P.P.F. injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721100','A','Proguanil tabs','Proguanil tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A142400','A','Pancuronium bromide injection ','Pancuronium bromide injection ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B212000','A','Paracetamol tabs','Paracetamol tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B212100','A','Parcetamol suppository','Parcetamol suppository','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731000','A','Phenoxymethyl penicillin tabs','Phenoxymethyl penicillin tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B224000','A','Pethedine  injection','Pethedine  injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E660000','A','Phenobarbitone tabs ','Phenobarbitone tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E661000','A','Phenobarbitone inj.','Phenobarbitone inj.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E670000','A','Phenytoin  tabs','Phenytoin  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R212213','A','Phenylephrine eye drops','Phenylephrine eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R214110','A','Pilocarpine eye drops','Pilocarpine eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R223150','A','Povidone iodine ','Povidone iodine ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F711400','A','Praziquantel tabs','Praziquantel tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D423000','A','Prednisolone tabs ','Prednisolone tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D412200','A','Promethazine inject.','Promethazine inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D412210','A','Promethazine tabs','Promethazine tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K131220','A','Propranolol  tabs','Propranolol  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721110','A','Quinine  tabs ','Quinine  tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F721111','A','Quinine  injection','Quinine  injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('M151240','A','Ranitidine  tabs','Ranitidine  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731160','A','RH 150/100mg','RH 150/100mg','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731161','A','RH 150/75 TABS','RH 150/75 TABS','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731162','A','RHEZ combined tabs','RHEZ combined tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W251110','A','Salbutamol 4mg tabs','Salbutamol 4mg tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W251111','A','Salbutamol inhalation','Salbutamol inhalation','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L144320','A','Silvernitrate','Silvernitrate','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L141140','A','Silversulphadiazine cream','Silversulphadiazine cream','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R212500','A','Sodium cromoglycate eye drops','Sodium cromoglycate eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X272311','A','Sodium bicarbonate injection','Sodium bicarbonate injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('K135320','A','Spironolactone  tabs ','Spironolactone  tabs ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F731180','A','Streptomycin inject.','Streptomycin inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A141100','A','suxamethonium injection ','suxamethonium injection ','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('Q202221','A','Tetanus immunoglobulin inj','Tetanus immunoglobulin inj','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F733100','A','Tetracycline caps','Tetracycline caps','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R211160','A','Tetracycline eye oint.','Tetracycline eye oint.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A111400','A','Thiopental injection','Thiopental injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L141110','A','Tetracycline skin oint.','Tetracycline skin oint.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('P181100','A','Thyroxine tabs','Thyroxine tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R214210','A','Timolol eye drops','Timolol eye drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F722400','A','Tinidazole  tabs','Tinidazole  tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B225001','A','Tramadol caps','Tramadol caps','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B225000','A','Tramadol inject.','Tramadol inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('P196213','A','Triamcinolone injection','Triamcinolone injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L141151','A','Triple action antibiotic cream','Triple action antibiotic cream','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X271100','A','Vitamin A  Caps','Vitamin A  Caps','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X271250','A','Vitamin B complex inject.','Vitamin B complex inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X271251','A','Vitamin B Complex tabs','Vitamin B Complex tabs','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('H102300','A','Vitamin B12 inject.','Vitamin B12 inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('J112100','A','Vitamin k inject.','Vitamin k inject.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('S140001','A','Water for injection','Water for injection','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L143100','A','Whitfields oint.','Whitfields oint.','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A122110','A','Xylocaine jelly','Xylocaine jelly','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('A122111','A','Xylocaine spray','Xylocaine spray','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('R222220','A','Xylomethazoline nasal drops','Xylomethazoline nasal drops','each','B','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B00002','B','Gauze hydrophylic','Gauze hydrophylic','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B00003','B','P.O.P 10cm','P.O.P 10cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B00004','B','P.O.P  15cm','P.O.P  15cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('B0001','B','Cotton wool ','Cotton wool ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BG0001','B','Surgical gloves size 6.5','Surgical gloves size 6.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BG0002','B','Surgical gloves size 7','Surgical gloves size 7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BG0003','B','Surgical gloves size 7.5','Surgical gloves size 7.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BG0004','B','Surgical gloves size 8','Surgical gloves size 8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BG0005','B','Examination gloves','Examination gloves','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BG0006','B','Mask disposable','Mask disposable','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0001','B','IV cannulars 20g','IV cannulars 20g','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN00010','B','Syringe 2ml','Syringe 2ml','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN00011','B','Syringe 10ml','Syringe 10ml','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0002','B','IV cannulars 22g','IV cannulars 22g','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0003','B','IV giving sets','IV giving sets','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0004','B','Syringes 5ml','Syringes 5ml','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0005','B','Syringes 60mls','Syringes 60mls','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0006','B','Syringes insuline,1ml','Syringes insuline,1ml','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0007','B','Blood giving sets','Blood giving sets','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0008','B','Blood taking set','Blood taking set','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BN0009','B','IV cannular 24g','IV cannular 24g','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0001','B','Surgical blades size 10','Surgical blades size 10','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00010','B','Suture vicryl No.0V626E ligature','Suture vicryl No.0V626E ligature','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00011','B','Suture vicryl No.2/0 CT V586H','Suture vicryl No.2/0 CT V586H','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00012','B','Suture vicryl No.2/0RB V317H','Suture vicryl No.2/0RB V317H','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00013','B','Suture No. 2/0V625H ligature','Suture No. 2/0V625H ligature','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00014','B','Suture Prolene No.2/0 ','Suture Prolene No.2/0 ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00015','B','Suture Prolene No.3/0 ','Suture Prolene No.3/0 ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00017','B','Suture vicryl No.3/0 CT ','Suture vicryl No.3/0 CT ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00018','B','Suture polysorb No.3/0','Suture polysorb No.3/0','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00019','B','Suture vicryl No.1RB V365H','Suture vicryl No.1RB V365H','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0002','B','Surgical blades size 11','Surgical blades size 11','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00020','B','Suture vicryl No1 CT','Suture vicryl No1 CT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS00021','B','Suture vicryl No1 V627H Ligature','Suture vicryl No1 V627H Ligature','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0003','B','Surgical blades size 12','Surgical blades size 12','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0004','B','Surgical blades size 15','Surgical blades size 15','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0005','B','Surgical blades size 20','Surgical blades size 20','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0006','B','Surgical blades size 21','Surgical blades size 21','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0007','B','Sugical blades size 23','Sugical blades size 23','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0008','B','Sugical blades size 24','Sugical blades size 24','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('BS0009','B','Surgical blade size 22','Surgical blade size 22','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D00001','B','Adhesive tape size 1.25cm','Adhesive tape size 1.25cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('D00002','B','Adhesive tape size 2.5cm','Adhesive tape size 2.5cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP001','B','Carboxymethylcellulose powder','Carboxymethylcellulose powder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP002','B','Amoxycillin powder','Amoxycillin powder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP003','B','Quinine powder','Quinine powder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP004','B','Light magnesium carbonate powder','Light magnesium carbonate powder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP005','B','Amonium chloride','Amonium chloride','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP006','B','Iodine crystals','Iodine crystals','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP007','B','Aromatic amooni solution','Aromatic amooni solution','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP008','B','Liquorice liquid extract','Liquorice liquid extract','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP009','B','Magnesium trisilicate powder','Magnesium trisilicate powder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP010','B','Sodium bicarbonate powder','Sodium bicarbonate powder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DDP011','B','Glycerol','Glycerol','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DIS001','B','Virkon powder','Virkon powder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DIS002','B','Alcohol swabs','Alcohol swabs','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DIS003','B','Mbu spray','Mbu spray','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DIS004','B','Methylated spirit','Methylated spirit','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('DIS005','B','Hydrogen perxode','Hydrogen perxode','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00001','B','Sphygnomanometer,s.k.','Sphygnomanometer,s.k.','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00002','B','Sphygnomanometer,simple aneroid','Sphygnomanometer,simple aneroid','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00003','B','Oto/opthalmoscope ','Oto/opthalmoscope ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00004','B','Thermometer  digital','Thermometer  digital','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00005','B','Thermometer oral','Thermometer oral','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00006','B','Twin suction pump','Twin suction pump','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00007','B','IV bottles','IV bottles','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00008','B','Stetoscope , feato, metal','Stetoscope , feato, metal','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('E00009','B','Stethoscope','Stethoscope','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0001','B','Dextrose powder','Dextrose powder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0002','B','Sodium chloride salt','Sodium chloride salt','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0003','B','Sodium lactate','Sodium lactate','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0004','B','Potassium chloride','Potassium chloride','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0005','B','Potassium iodide','Potassium iodide','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0006','B','Calcium chloride','Calcium chloride','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0007','B','Citric acid','Citric acid','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0008','B','Tri sodium citrate','Tri sodium citrate','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0009','B','Rubber stopers','Rubber stopers','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0010','B','IV bottles','IV bottles','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('IV0011','B','Decrimping tool','Decrimping tool','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00001','B','ALT/GPT kinetics','ALT/GPT kinetics','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00002','B','Anti A antiserum','Anti A antiserum','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00003','B','Anti B antiserum','Anti B antiserum','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00004','B','Anti D antiserum','Anti D antiserum','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00005','B','AST/GOT kinetic','AST/GOT kinetic','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00006','B','Cell clean','Cell clean','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00007','B','Cell pack','Cell pack','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00008','B','Field stain A','Field stain A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00009','B','Field stain B','Field stain B','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00010','B','Glucose test strips','Glucose test strips','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00011','B','Gynacological gloves','Gynacological gloves','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00012','B','Hepatitis B test reagent','Hepatitis B test reagent','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00013','B','Immersion Oil ','Immersion Oil ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00015','B','Microscope glass slide','Microscope glass slide','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00016','B','Pipettes,adjustable volume,5-50cl','Pipettes,adjustable volume,5-50cl','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00017','B','Pipettes,fixed volume,1ml','Pipettes,fixed volume,1ml','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00020','B','Pregnancy test reagent','Pregnancy test reagent','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00021','B','Stromatolyser','Stromatolyser','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00022','B','Thermal paper roll (for sysmex)','Thermal paper roll (for sysmex)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00023','B','Urine test strips 7parameters','Urine test strips 7parameters','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00025','B','Urine test strips 4parameters','Urine test strips 4parameters','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00026','B','Microscope cover slips','Microscope cover slips','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00027','B','Determine','Determine','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00028','B','HIV test kit-capillus','HIV test kit-capillus','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00029','B','Chemistry control level I','Chemistry control level I','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00030','B','Total protein kit','Total protein kit','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00031','B','Uric acid +STD kit','Uric acid +STD kit','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00032','B','Urea Nitrogen set','Urea Nitrogen set','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00033','B','Bilirubin, total','Bilirubin, total','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00034','B','Bilirubin direct','Bilirubin direct','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00035','B','CD4 test kit','CD4 test kit','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00036','B','Chemistry control level II','Chemistry control level II','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00037','B','Facscount reagent','Facscount reagent','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00038','B','Facsflow sheath solutin','Facsflow sheath solutin','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00039','B','Facs control kit','Facs control kit','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00040','B','Print paper for Facs machine','Print paper for Facs machine','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00041','B','Glucometer (supreme)','Glucometer (supreme)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00042','B','HIV test kit - eurocheck','HIV test kit - eurocheck','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00043','B','Blood collection tubes, with EDTA','Blood collection tubes, with EDTA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00044','B','Blood collection tubes , dry','Blood collection tubes , dry','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00045','B','Widal test kit','Widal test kit','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00046','B','RPR test reagent','RPR test reagent','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00047','B','Pipettes,mini pipettes,20mcl','Pipettes,mini pipettes,20mcl','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00048','B','Brucella test kit','Brucella test kit','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('L00049','B','Bovine albumine brucella test','Bovine albumine brucella test','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0001','B','Floor cloth','Floor cloth','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0002','B','Hand brush','Hand brush','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0003','B','Hard broom','Hard broom','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0004','B','Loundry compound','Loundry compound','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0005','B','Loundry gloves','Loundry gloves','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0006','B','Mops','Mops','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0007','B','Ruber squezer','Ruber squezer','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0008','B','sabuni ya unga- foma','sabuni ya unga- foma','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0009','B','Sabuni ya mche','Sabuni ya mche','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0010','B','Sabuni ya maji','Sabuni ya maji','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0011','B','Septol','Septol','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0012','B','Sodium hypochlorite soln (JIK)','Sodium hypochlorite soln (JIK)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0014','B','Soft broom','Soft broom','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0015','B','Toilet brush','Toilet brush','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0016','B','Toilet paper','Toilet paper','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('SC0017','B','Vim','Vim','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00001','B','Endotracheal tube size 2.5','Endotracheal tube size 2.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00002','B','Endotracheal tube size 3.5','Endotracheal tube size 3.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00003','B','Endotracheal tube size 4','Endotracheal tube size 4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00004','B','Endotracheal tube size 4.5','Endotracheal tube size 4.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00005','B','Endotracheal tube size 5','Endotracheal tube size 5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00006','B','Endotracheal tube size 5.5','Endotracheal tube size 5.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00007','B','Endotracheal tube size 6','Endotracheal tube size 6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00008','B','Endotracheal tube size 6.5','Endotracheal tube size 6.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00009','B','Endotracheal tube size 7.5','Endotracheal tube size 7.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00010','B','Endotracheal tube size 8','Endotracheal tube size 8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00011','B','Catheter size 10, 2ways','Catheter size 10, 2ways','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00012','B','Catheter size 14,2way','Catheter size 14,2way','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00014','B','Catheter foley size 18-2way','Catheter foley size 18-2way','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00015','B','Catheter foley size 16-2way','Catheter foley size 16-2way','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00016','B','Catheter foley size 22-2way','Catheter foley size 22-2way','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00017','B','Catheter foley size 24-2way','Catheter foley size 24-2way','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00018','B','Catheter foley size 8-2way','Catheter foley size 8-2way','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00019','B','Catheter size 22,3ways','Catheter size 22,3ways','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00020','B','Feeding tubes size 6','Feeding tubes size 6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00021','B','Feeding tubes size 8','Feeding tubes size 8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00022','B','Feeding tubes size 10','Feeding tubes size 10','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00023','B','Stomach tube size 12','Stomach tube size 12','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00024','B','Stomach tube size14','Stomach tube size14','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00025','B','Stomach tube size22','Stomach tube size22','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00026','B','Rectal tubes size 22','Rectal tubes size 22','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00027','B','Urinal bags','Urinal bags','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00028','B','Urinal Bottles','Urinal Bottles','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00029','B','Suction nelaton catheter size 10','Suction nelaton catheter size 10','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00030','B','Suction nelaton catheter size 12','Suction nelaton catheter size 12','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00031','B','Suction nelaton catheter size 14','Suction nelaton catheter size 14','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00032','B','Chest drain tubes 20g','Chest drain tubes 20g','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00033','B','Chest drain tubes 24g','Chest drain tubes 24g','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00034','B','Chest drain tubes  32g','Chest drain tubes  32g','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00035','B','Catheter foley size 20-2way','Catheter foley size 20-2way','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00036','B','Cathrter size 20 3way','Cathrter size 20 3way','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00037','B','Feeding tube size 16','Feeding tube size 16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('T00038','B','Feeding tube size 5','Feeding tube size 5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X00001','B','X-ray developer','X-ray developer','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X00002','B','X-ray fixer','X-ray fixer','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X00003','B','X-ray films 18cmx24cm','X-ray films 18cmx24cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X00004','B','X-ray films 24cmx30cm','X-ray films 24cmx30cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X00005','B','X-ray films 35cmx35cm','X-ray films 35cmx35cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X00006','B','X-ray films 35cmx43cm','X-ray films 35cmx43cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('X00007','B','ECG paper print rolls','ECG paper print rolls','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0001','C','Analysis Book','Analysis Book','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0002','C','Bin card -HLH','Bin card -HLH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0003','C','Bin card -MOH','Bin card -MOH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0004','C','Blue pen','Blue pen','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0005','C','Box file','Box file','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0006','C','Cartridge 49A','Cartridge 49A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0007','C','Cash register ribbon','Cash register ribbon','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0008','C','Clinic cards -children','Clinic cards -children','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0009','C','Cloth card','Cloth card','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0010','C','Correcting fluid','Correcting fluid','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0011','C','Counter book 3Q','Counter book 3Q','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0012','C','Counter book 4Q','Counter book 4Q','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0013','C','Dupplicating ink','Dupplicating ink','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0014','C','Envelope  A4','Envelope  A4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0015','C','Envelope -air mail','Envelope -air mail','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0016','C','Envelope- manila','Envelope- manila','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0017','C','Erraser (vifutio)','Erraser (vifutio)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0018','C','Excersize book large','Excersize book large','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0019','C','Excersize book small','Excersize book small','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0020','C','File folder','File folder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0021','C','History sheets','History sheets','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0022','C','Hot water bottles','Hot water bottles','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0023','C','In Out cards','In Out cards','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0024','C','ink for copy printer ','ink for copy printer ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0025','C','Inkjet cartridge No 131','Inkjet cartridge No 131','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0026','C','inkjet cartridge no 57','inkjet cartridge no 57','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0027','C','Inkjet cartridge No. 135','Inkjet cartridge No. 135','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0028','C','Inkjet cartridge no.56','Inkjet cartridge no.56','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0029','C','Inkjet cartridge no.13A','Inkjet cartridge no.13A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0030','C','Manila sheets   ','Manila sheets   ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0031','C','Manila sheets -embosed','Manila sheets -embosed','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0032','C','Marker pen','Marker pen','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0033','C','Master rool book','Master rool book','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0034','C','master rool for copy printer','master rool for copy printer','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0035','C','Office glue','Office glue','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0036','C','OPD cards buff','OPD cards buff','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0037','C','OPD cards green','OPD cards green','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0038','C','OPD cards red','OPD cards red','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0039','C','OPD register paper rolls','OPD register paper rolls','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0040','C','Paper clips','Paper clips','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0041','C','Paper tray','Paper tray','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0042','C','Pencil','Pencil','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0057','C','Pedal bin','Pedal bin','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0043','C','Photocopy paper','Photocopy paper','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0044','C','Red pen','Red pen','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0045','C','Ring binder','Ring binder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0046','C','Ruller','Ruller','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0047','C','Staple pins No 10','Staple pins No 10','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0048','C','Staple pins size 24/6','Staple pins size 24/6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0049','C','Stapler','Stapler','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0050','C','Stapple remover','Stapple remover','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0051','C','stiff cover book','stiff cover book','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0052','C','Torner for conon copier','Torner for conon copier','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0053','C','Torner for nashuatec copier','Torner for nashuatec copier','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0054','C','Vehicle log book','Vehicle log book','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0055','C','Wall clock','Wall clock','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('ST0056','C','Carbon paper','Carbon paper','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F00001','D','Sugar- white','Sugar- white','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F00002','D','Majani ya chai','Majani ya chai','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F00003','D','Chumvi','Chumvi','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F00004','D','Mafuta ya alizeti','Mafuta ya alizeti','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('F00005','D','Maziwa ya unga','Maziwa ya unga','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00001','S','TOMATO (MONEY MAKER)','TOMATO (MONEY MAKER)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00002','S','SWISSCHARD (FORDHOOK BRIAUT)','SWISSCHARD (FORDHOOK BRIAUT)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00003','S','CARROT (NANTOS CORELESS)','CARROT (NANTOS CORELESS)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00005','S','TOMATO (MARGLOBE)','TOMATO (MARGLOBE)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00006','S','CHINESE CABBAGE (CHICHILI)','CHINESE CABBAGE (CHICHILI)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00008','S','CABBAGE (GIANT DRUMHEAD)','CABBAGE (GIANT DRUMHEAD)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00009','S','GARDEN SPRINKLER','GARDEN SPRINKLER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00011','F','FRIDGE W . P 190','FRIDGE W . P 190','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0002','T','TDTO OIL 208 LTS','TDTO OIL 208 LTS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0003','T','FILTER 1R 0714','FILTER 1R 0714','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00035','T','AIR FILTER 25436','AIR FILTER 25436','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00036','T','BUCKET TIPS 193252/9N4252','BUCKET TIPS 193252/9N4252','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0004','T','ELEMENT 0935369','ELEMENT 0935369','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0005','T','PIN 132463','PIN 132463','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0006','Q','TID 9N 4252','TID 9N 4252','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0007','Q','FUEL FILTERS 1838187','FUEL FILTERS 1838187','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0008','Q','RETAINER 145733','RETAINER 145733','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0009','F','VENUS COOKER','VENUS COOKER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00100','F','FLOAR SWITCH','FLOAR SWITCH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0011','F','CABLE 95M W32579','CABLE 95M W32579','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00124','M','DAWA YA MCHWA (Gladiator)','DAWA YA MCHWA (Gladiator)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00125','I','WELDING -HOLDER','WELDING -HOLDER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00126','H','SAW -SET','SAW -SET','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00127','H','MAKING GAUGE','MAKING GAUGE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00128','H','JIG SAW BLADES','JIG SAW BLADES','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00129','H','HANDLE FOR GLASS','HANDLE FOR GLASS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00200','E','GARDEN TAP LOCK 3/4','GARDEN TAP LOCK 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00201','E','NIPPLE 3','NIPPLE 3','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00202','E','SINGLE -HANDLE KITCHEN FAUCET','SINGLE -HANDLE KITCHEN FAUCET','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00206','E','P V C ELBOW 1 1/2','P V C ELBOW 1 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00209','E','TEE COUPLING 3/4','TEE COUPLING 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00223','N','CLUTH DISC','CLUTH DISC','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00225','N','WIPER BLADE','WIPER BLADE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0025','H','HOOCKS NO 6','HOOCKS NO 6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0026','H','ALPHA CLEAR','ALPHA CLEAR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0027','H','HIGH GLOSS THINER','HIGH GLOSS THINER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0028','E','WHEEL BARROW S.A','WHEEL BARROW S.A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W003099','F','MAIN SWITCH 100 AMPS TPN','MAIN SWITCH 100 AMPS TPN','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0032','F','CONTACTORS 40 AMP','CONTACTORS 40 AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0034','F','FUSE 10 AMPS','FUSE 10 AMPS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0036','F','BATTERY 12X7 UPS','BATTERY 12X7 UPS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W00500','F','EMULSION PEARL ROBB','EMULSION PEARL ROBB','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W010','F','EXTENSION PROTECTOR','EXTENSION PROTECTOR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0100','E','CHANEL IRON 2 1/2','CHANEL IRON 2 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01001','H','Nails 1"','Nails 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01002','H','Nails 1.25"','Nails 1.25"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01003','H','Nails 1.5','Nails 1.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01004','H','Nails 2"','Nails 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01005','H','Nails 2 1/2"','Nails 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01006','H','Nails 3"','Nails 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01007','H','Nails 4"','Nails 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01008','H','Nails 5"','Nails 5"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01009','H','Nails 6"','Nails 6"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01010','H','Nails Bati','Nails Bati','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01013','E','GARDEN HOSE YELLOW 50m','GARDEN HOSE YELLOW 50m','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W011','H','BRASS HINGES 2 1/2','BRASS HINGES 2 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01203','Q','FRONT STUDS +NUTS MF','FRONT STUDS +NUTS MF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01212','H','Wood Preservative','Wood Preservative','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01213','F','Cylinder Gas','Cylinder Gas','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01230','F','GAS HEATER','GAS HEATER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01231','M','QUICK PHOS','QUICK PHOS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01235','F','WHIRL POOL REFRIGERATOR','WHIRL POOL REFRIGERATOR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01236','F','ROBIN GENERATOR DIESEL','ROBIN GENERATOR DIESEL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01237','F','EARTH CLAMP','EARTH CLAMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01244','F','YORK BRIDGE MIXTURE','YORK BRIDGE MIXTURE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01245','H','SAND PAPER NO 2','SAND PAPER NO 2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01249','H','SANDING PAPER 60/100','SANDING PAPER 60/100','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W01250','E','SURURU','SURURU','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020001','E','TOILET.S.TRAP','TOILET.S.TRAP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020011','E','Ball Valve 1" (U.K )','Ball Valve 1" (U.K )','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02002','E','Basin Top 1/2"','Basin Top 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020021','E','Bend 3"','Bend 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02003','E','Connector Tube 1/2"','Connector Tube 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020031','E','Conector 3/4"','Conector 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020032','E','Conector 1"','Conector 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02004','E','Bend 1"','Bend 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020042','E','GATE VALVE 3"','GATE VALVE 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020043','E','WATER METER','WATER METER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020044','E','ELOSTIC GLUE','ELOSTIC GLUE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020045','E','UNION 3"','UNION 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020046','E','SOLFIX','SOLFIX','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02005','E','Coupling Plastic 1"','Coupling Plastic 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020051','E','Coupling plastick 1 1/2"','Coupling plastick 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02006','E','Coupling 2"','Coupling 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02007','E','Coupling 2 1/2"','Coupling 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02008','E','Elbow 1/2"','Elbow 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020087','E','RED.BUSH 1 1/2 X1 1/4','RED.BUSH 1 1/2 X1 1/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020088','E','RED.BUSH 2"X1/2','RED.BUSH 2"X1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02009','E','Elbow 3/4"','Elbow 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02010','E','Elbow 1"','Elbow 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020100','E','SOCKET 3/4 X1/2','SOCKET 3/4 X1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02011','E','Elbow 1 1/4"','Elbow 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02012','E','Elbow 1 1/2"','Elbow 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020124','E','D/B/D/D SINK & TRAP','D/B/D/D SINK & TRAP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02013','E','Elbow 2"','Elbow 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02014','E','Elbow 2 1/2"','Elbow 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020141','E','SOCKET 4" PLASTIC','SOCKET 4" PLASTIC','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020143','E','RED.SOCKET 2 1/2 X2"','RED.SOCKET 2 1/2 X2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020144','E','RED.SOCKET 4" X 2 1/2','RED.SOCKET 4" X 2 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02016','E','Floator 1/2"','Floator 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02017','E','Gatevalve 1/2"','Gatevalve 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02018','E','Gatevalve 2"','Gatevalve 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02019','E','Gatevalve 2 1/2"','Gatevalve 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02020','E','Gell trap','Gell trap','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02021','E','Nipple 1/2"','Nipple 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02022','E','Nipple 3/4"','Nipple 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02023','E','Nipple 1"','Nipple 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020231','E','Nipple 1 1/4"','Nipple 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02024','E','Nipple 2"','Nipple 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0202401','E','Nepple 2 1/2"','Nepple 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020241','E','Nipple 3"','Nipple 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02025','E','Pipes 1/2"','Pipes 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02030','E','Plastick Elbow 4"','Plastick Elbow 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020314','E','RED.SOCKET 1 1/2X3/4','RED.SOCKET 1 1/2X3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02033','E','Plug 1/2"','Plug 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02034','E','Plug 3/4"','Plug 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020351','E','Plug 2"','Plug 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020352','E','Plug 3"','Plug 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02036','E','Plug 1 1/4"','Plug 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02038','E','Reducer Bush 1 1/2" to 3/4"','Reducer Bush 1 1/2" to 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020381','E','R. Bush 3 x 1 1/2','R. Bush 3 x 1 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020391','E','RED.BUSH 3/4X1/2','RED.BUSH 3/4X1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020392','E','TEE 3/4 YENYE MDOMO 4','TEE 3/4 YENYE MDOMO 4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020393','E','CROSS TEE 3/4','CROSS TEE 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02040','E','REDUCING BUSH 1 to 3\4','REDUCING BUSH 1 to 3\4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020401','E','RED. SOCKET 1X3/4','RED. SOCKET 1X3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020402','E','FLOATOR 1"','FLOATOR 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02041','E','R .BUSH 11/4 X 1','R .BUSH 11/4 X 1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02042','E','Reducer 1 1/2" to 1"','Reducer 1 1/2" to 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02044','E','Saddle Clamps 2"','Saddle Clamps 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020441','E','SADDLE CLAMP 1 1/2X1','SADDLE CLAMP 1 1/2X1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020442','E','SINK RUBBER','SINK RUBBER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020443','E','SADDLE CLAMP 2"X1"','SADDLE CLAMP 2"X1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02045','E','Saddle Clamp 4"','Saddle Clamp 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020456','E','Glavs Plastick','Glavs Plastick','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02046','E','Socket 1/2"','Socket 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02047','E','Socket 3/4"','Socket 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02048','E','Socket 1"','Socket 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02049','E','Socket 1 1/4"','Socket 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02050','E','Socket 1 1/2"','Socket 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02051','E','Socket 2"','Socket 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02052','E','Socket 2 1/2"','Socket 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020522','E','SOCKET 4"','SOCKET 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02053','E','Stop cock 1/2"','Stop cock 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020530','E','LOCKING TAP 1/2','LOCKING TAP 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020531','E','SINK TAP 1/2','SINK TAP 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020532','E','OMCO 1/2','OMCO 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02054','E','Stop cock 3/4"','Stop cock 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02055','E','Taps 1/2" Hitaji ufunguo','Taps 1/2" Hitaji ufunguo','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020551','E','Ordinary tap 1/2"','Ordinary tap 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02056','E','Taps 3/4"','Taps 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020561','E','Tap ya Pekee 3/4"','Tap ya Pekee 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02057','E','Tee 1/2"','Tee 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02058','E','Tee 3/4"','Tee 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02059','E','Tee 1 1/4"','Tee 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02060','E','Tee 1 1/2 Plastick','Tee 1 1/2 Plastick','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02061','E','Tee 2"','Tee 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020611','E','Tee G.S 3"','Tee G.S 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02062','E','Toilet Seat','Toilet Seat','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02063','E','Trap 1 1/4"','Trap 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020631','E','Crom bottle trap 1 1/2"','Crom bottle trap 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020633','E','Trap 1 1/2"','Trap 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02064','E','Union 1/2"','Union 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02065','E','Union 3/4"','Union 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020651','E','Union 1"','Union 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02067','E','Union 1 1/2"','Union 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020670','E','Gate Valve 1 1/4"','Gate Valve 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020672','E','Union 1 1/4"','Union 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0206721','E','Union 2 1/2"','Union 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02069','E','Stop cork 1 1/2"','Stop cork 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02070','E','Gatevalve 3/4"','Gatevalve 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02071','E','Gatevalve 1"','Gatevalve 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W020731','E','Wash Basin- Hand','Wash Basin- Hand','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02074','E','Pillar Tape(Heavy)','Pillar Tape(Heavy)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02080','E','PLASTIC BOTTLE TRAP 1 1\4','PLASTIC BOTTLE TRAP 1 1\4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02081','E','TEE 1','TEE 1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02082','E','CHOO P TRAP','CHOO P TRAP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02083','E','TRED TAPE','TRED TAPE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02084','E','FLEXIBLE PIPE 1.5','FLEXIBLE PIPE 1.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02088','E','Plastic Tap 3\4','Plastic Tap 3\4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02089','E','RED. BUSH 2 1/2 X 2"','RED. BUSH 2 1/2 X 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02091','E','Toilet.S.Trap','Toilet.S.Trap','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02094','E','Connector 3/4"','Connector 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02095','E','Connector 1"','Connector 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02096','E','Connector 1 1/2"','Connector 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02100','E','NON RETURN VALVE 2 1\2','NON RETURN VALVE 2 1\2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W021010','E','WATER METER 3/4','WATER METER 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W021011','E','HANDLE FOR STAY WINDOW','HANDLE FOR STAY WINDOW','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W021012','E','HOOKS NO 12','HOOKS NO 12','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W021013','E','CLIPS 5MM','CLIPS 5MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02103','E','Pipe Jointing (Boss White)','Pipe Jointing (Boss White)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02104','E','BOB TAP 1.5','BOB TAP 1.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02105','E','Gate Valve 3"','Gate Valve 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02106','E','BEND 1\2','BEND 1\2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02107','E','MAIN HOLE COVER 12X12CM','MAIN HOLE COVER 12X12CM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02108','E','Water Meter','Water Meter','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02111','E','CONNECTOR 2"','CONNECTOR 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02112','E','CONECTOR 2 1\2','CONECTOR 2 1\2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02113','E','GALV TEE 2 1\2','GALV TEE 2 1\2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02115','E','Union 3"','Union 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02118','E','BLUE TEE 1"','BLUE TEE 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02120','E','Coupling Plastic 1 1/2"','Coupling Plastic 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02121','E','BLUE NIPPLE 1"','BLUE NIPPLE 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02122','E','BLUE PLASTIC NIPPLE 1 1\2','BLUE PLASTIC NIPPLE 1 1\2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02123','E','BLUE UNION 1\2','BLUE UNION 1\2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02124','E','PLASTIC BLUE UNION 1 1\2','PLASTIC BLUE UNION 1 1\2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02126','E','Red.Bush 1 1/2 x1 1/4','Red.Bush 1 1/2 x1 1/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02127','E','Red. Bush 2"x1/2','Red. Bush 2"x1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02128','E','Gate Valve 1 1/2"','Gate Valve 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02130','E','DOUBLE TAPE 3/4','DOUBLE TAPE 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02131','E','LONG SHOWER TAPE','LONG SHOWER TAPE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02132','E','NON RETURN VALVE 2"','NON RETURN VALVE 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02133','E','Socket 4"Plastic','Socket 4"Plastic','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02134','E','Elbow 3"','Elbow 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02137','E','Nipple 1 1/4"','Nipple 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02138','E','Nipple 1 1/2"','Nipple 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02139','E','Nipple 2 1/2"','Nipple 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02144','E','Plug 2"','Plug 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02145','E','COUPLING 3/4"','COUPLING 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02147','E','SINK TAP 1/2 (Lavatory Mixer','SINK TAP 1/2 (Lavatory Mixer','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02148','E','Sand paper No O','Sand paper No O','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02149','E','Sand Paper No 2','Sand Paper No 2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02151','E','Plug 3"','Plug 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02152','E','Bolt 1/4 x 2"','Bolt 1/4 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02153','E','Red. Bush 3"x 1 1/2','Red. Bush 3"x 1 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02154','E','Red. Bush 3/4 x 1/2','Red. Bush 3/4 x 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02156','E','Cross Tee 3/4','Cross Tee 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02158','E','Floator 1"','Floator 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02161','E','Saddle Clamps 2"','Saddle Clamps 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02162','E','Sink Rubber','Sink Rubber','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02163','E','Saddle Clamp 2" x 1"','Saddle Clamp 2" x 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02165','E','Glaves Plastick','Glaves Plastick','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02166','E','Socket 3"','Socket 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02167','E','Socket 4"','Socket 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02169','E','Sink Tap 1/2','Sink Tap 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02171','E','Ordinary tap 1/2"','Ordinary tap 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02173','E','Tap ya Pekee 3/4"','Tap ya Pekee 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02176','E','Tee G. S 3"','Tee G. S 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02179','E','Trap 1 1/2"','Trap 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02180','E','Gate Valve 1 1/4"','Gate Valve 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02181','E','Union 2"','Union 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02182','E','Union 1 1/4"','Union 1 1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02183','E','Union 2 1/2"','Union 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02185','E','Wash Basin -Hand','Wash Basin -Hand','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02188','E','RHINO HOSE 18MM X 30M','RHINO HOSE 18MM X 30M','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02189','E','CHOO CHA UDONGO-CHINI','CHOO CHA UDONGO-CHINI','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02190','E','SADDLE CLAMP 2 1/2 X 1"','SADDLE CLAMP 2 1/2 X 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02191','E','RED SOCKET 1 1/2"X 1"','RED SOCKET 1 1/2"X 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02192','E','NON RETURN VALVE 1"','NON RETURN VALVE 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02255','E','REDUCING BUSH 3"X2 1/2','REDUCING BUSH 3"X2 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02294','E','R.BUSH 1/2"','R.BUSH 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02296','E','SADDLE CLAMP 2"X3/4"','SADDLE CLAMP 2"X3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02303','E','COMPRESSOR TANK','COMPRESSOR TANK','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02304','E','PUMP(AL-KO HW 1400-5)','PUMP(AL-KO HW 1400-5)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02305','E','TINDO','TINDO','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02310','E','Sand paper no O','Sand paper no O','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02331','E','PRESSURE VALVE 2"','PRESSURE VALVE 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0251','E','BINDING WIRE','BINDING WIRE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0252','E','NONDO 6mm ROLL','NONDO 6mm ROLL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02548','E','JOINT KIT','JOINT KIT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0255','E','JACK 2TONS 1141734','JACK 2TONS 1141734','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02558','E','BEND 2 1/2"','BEND 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02559','E','TRUNKING 25X38','TRUNKING 25X38','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02560','E','TRUNKING 16X25','TRUNKING 16X25','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02570','E','MININGA 1X8','MININGA 1X8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02573','E','WHEEL CHAIR 50X17','WHEEL CHAIR 50X17','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02574','E','WHEEL CHAIR 75X21','WHEEL CHAIR 75X21','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02583','E','MININGA 4X4','MININGA 4X4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02584','E','PLASTICK FLUSH TANK','PLASTICK FLUSH TANK','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02586','E','DEAD LOCK (BIRD LOCK)','DEAD LOCK (BIRD LOCK)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02587','E','SINK CORK 1/2"','SINK CORK 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02588','E','Tap 3/4" ya pekee','Tap 3/4" ya pekee','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02589','E','TAP 1/2" PEKEE','TAP 1/2" PEKEE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W025890','E','WASH-DOWN-TOILET','WASH-DOWN-TOILET','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W025893','E','FURSE CUP ZIBUO','FURSE CUP ZIBUO','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02590','E','HEATER-YA-MAJI MOTO','HEATER-YA-MAJI MOTO','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02592','E','CYPRESS 1X10X15','CYPRESS 1X10X15','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02596','E','G.S PIPE 1/2','G.S PIPE 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02597','E','FLAT IRON 3/4','FLAT IRON 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0266','E','Union 1"','Union 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0267','E','AFRICAN TOILET','AFRICAN TOILET','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02670','E','PVC 6','PVC 6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02671','E','PVC 4','PVC 4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02672','H','PLY WOOD KENYA','PLY WOOD KENYA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02673','H','MITA.3 G.28','MITA.3 G.28','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02674','H','MITA.2G.28','MITA.2G.28','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02676','H','NONDO 16mm','NONDO 16mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02677','H','PLYWOOD 4mm','PLYWOOD 4mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02678','H','NONDO 10mm MAKONDE','NONDO 10mm MAKONDE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02679','H','NONDO 12mm MAKONDE','NONDO 12mm MAKONDE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0268','H','S/B/S/D SINK B TRAP','S/B/S/D SINK B TRAP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02681','J','BATI M.3 G.30','BATI M.3 G.30','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02682','J','NONDO 10mm BILA MAKONDE','NONDO 10mm BILA MAKONDE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02683','F','CONDUCT PIPE 1/2','CONDUCT PIPE 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02684','E','PVC ROOL 3/4','PVC ROOL 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02685','J','T-IRON','T-IRON','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02686','J','FLAT IRON 3/4X3','FLAT IRON 3/4X3','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02687','J','Z-IRON 3/4X3mm','Z-IRON 3/4X3mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02689','K','LIME BAGS','LIME BAGS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0269','J','KOFIA YA BATI','KOFIA YA BATI','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0275','H','CHIPBORD 8mm','CHIPBORD 8mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02755','E','Flush tank ya plastik','Flush tank ya plastik','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02757','E','SOFT BOARD','SOFT BOARD','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02894','E','DOUBLE TRAP 1 1/2"','DOUBLE TRAP 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02895','F','ARALDITE','ARALDITE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02896','E','PEX G.VALVE 3/4"','PEX G.VALVE 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02897','E','SANWA TAP 1/2"','SANWA TAP 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02958','E','PLASTICK ELBOW','PLASTICK ELBOW','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02984','E','PLUG 1"','PLUG 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02988','E','PVC ELBOW 6','PVC ELBOW 6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W02992','E','VIOO VYA KUJITAZAMA 60X40','VIOO VYA KUJITAZAMA 60X40','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030000','F','SADDLE CLEMPS 2X3/4','SADDLE CLEMPS 2X3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030008','F','BULB 100 W HOOKS','BULB 100 W HOOKS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03001','F','4 Way Extension W/cable','4 Way Extension W/cable','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03004','F','Protector Adaptor','Protector Adaptor','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03005','F','Bulb Holder','Bulb Holder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030050','F','BULB HOLDER','BULB HOLDER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030052','F','BULB HALOGEN TUBE 1000W','BULB HALOGEN TUBE 1000W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030054','F','BULB HOLDER ZA PEKEE','BULB HOLDER ZA PEKEE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030055','F','ISPECTION LAMP','ISPECTION LAMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030056','F','SUGER PROTECTION PLUG','SUGER PROTECTION PLUG','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030059','F','ROUND SAFETY PLUG 15A','ROUND SAFETY PLUG 15A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03006','F','Bulb Watt 40','Bulb Watt 40','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030060','F','WATER PROOF J/BOX','WATER PROOF J/BOX','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030061','F','PLUG VOLEX','PLUG VOLEX','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03007','F','Bulb Watt 60','Bulb Watt 60','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030071','F','BULB 100W','BULB 100W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03008','F','Futi 4 Fitting','Futi 4 Fitting','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03009','F','Fitting futi 2','Fitting futi 2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03010','F','Junction box','Junction box','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03011','F','Mult-Plug cadaptor','Mult-Plug cadaptor','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03012','F','Safety Plug 13Amp','Safety Plug 13Amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030132','F','Double switch','Double switch','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030142','F','BULB 60W HOOKS','BULB 60W HOOKS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03015','F','Square box','Square box','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03016','F','Starters','Starters','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03018','F','Switch Socket','Switch Socket','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03019','F','Tube Light Futi 2','Tube Light Futi 2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03020','F','Tube Light Futi 4','Tube Light Futi 4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030201','F','PUSH BUTTONS','PUSH BUTTONS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03021','F','Wire 2.5mm','Wire 2.5mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030212','F','Wire 6mm','Wire 6mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030213','F','WIRE 16mm SIGLE','WIRE 16mm SIGLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03022','F','Wire 1.5mm','Wire 1.5mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030221','F','Soldering wire 2mm','Soldering wire 2mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030225','F','Fuse Wire Tinned Copper 10A','Fuse Wire Tinned Copper 10A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030226','F','Flexible Cable 14014 x 2c','Flexible Cable 14014 x 2c','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03026','F','Mainswitch','Mainswitch','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030271','F','Clips 9mm','Clips 9mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03028','F','Clips 8mm','Clips 8mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03035','F','CLIPS 10mm','CLIPS 10mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03037','F','BULB HALOGEN TUBE 1000W','BULB HALOGEN TUBE 1000W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030376','F','CONNECTOR STRIP','CONNECTOR STRIP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03039','F','BULB HOLDER ZA PEKEE','BULB HOLDER ZA PEKEE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03041','F','Fuse 2A Big','Fuse 2A Big','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030411','F','Fuse 3A Big','Fuse 3A Big','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030412','F','Fuse 5A Big','Fuse 5A Big','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030415','F','Fuse 13A','Fuse 13A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03042','F','Fuse 1A Small','Fuse 1A Small','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030421','F','Fuse 2A Small','Fuse 2A Small','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030424','F','Fuse 10A Small','Fuse 10A Small','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0304241','F','Fuse 5Amp','Fuse 5Amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0304242','F','Fuse 20Amp','Fuse 20Amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0304243','F','Fuse 3Amp','Fuse 3Amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0304244','F','Fuse 10Amp','Fuse 10Amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030425','F','EARTH ROD','EARTH ROD','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030426','F','HEATER (NATIONAL HOME SHOWER)','HEATER (NATIONAL HOME SHOWER)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030443','F','SAFETY PLUG 15 AMP','SAFETY PLUG 15 AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03045','F','Red Light Bulb 40w','Red Light Bulb 40w','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03047','F','HEATER (KUCHEMSHA MAJI)','HEATER (KUCHEMSHA MAJI)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03048','F','JUCTION BOX 20A','JUCTION BOX 20A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03049','F','TRIPLE SWITCH','TRIPLE SWITCH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03050','F','MOTOR CIRCUT BREAK','MOTOR CIRCUT BREAK','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03051','F','MAIN SWITCH 3 WAY','MAIN SWITCH 3 WAY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03053','F','WATER PROOF J/BOX','WATER PROOF J/BOX','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03055','F','BOTTLE FUSE 10/500','BOTTLE FUSE 10/500','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03058','F','BULB 100W','BULB 100W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03059','F','junction box 30A','junction box 30A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03061','F','ATF DEXTRON 11','ATF DEXTRON 11','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03062','F','Double Switch','Double Switch','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03063','F','ELCB 63A','ELCB 63A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03065','F','Fuse 1amp','Fuse 1amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03066','F','Wire 6mm','Wire 6mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03067','F','Wire 16mm Single','Wire 16mm Single','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03071','F','Fuse Wire Tinned Copper 10A','Fuse Wire Tinned Copper 10A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03072','F','Flexible Cable 14014 x 2c','Flexible Cable 14014 x 2c','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03074','F','Clips 9mm','Clips 9mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03075','F','Fuse 3A Big','Fuse 3A Big','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03076','F','Fuse 5A Big','Fuse 5A Big','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03077','F','Fuse 13A','Fuse 13A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03082','F','Fuse 5A','Fuse 5A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03083','F','Fuse 20A','Fuse 20A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03084','F','Fuse 3A','Fuse 3A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03085','F','Fuse 10A','Fuse 10A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03086','F','Earth Rod','Earth Rod','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03087','F','Heater(National Home Shower)','Heater(National Home Shower)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03088','F','Fuse 15A Small','Fuse 15A Small','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03089','F','Fuse 3A Small','Fuse 3A Small','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03090','F','Bulb 0.5 Watt','Bulb 0.5 Watt','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03092','F','Wire 0.5mm','Wire 0.5mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03093','F','Switch Socket 15A','Switch Socket 15A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03094','F','MAIN SWITCH 6 WAY','MAIN SWITCH 6 WAY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03095','F','EARTH LEAKAGE C BREACKER 63AMP','EARTH LEAKAGE C BREACKER 63AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03096','F','EARTH CABLE WIRE 2.5mm','EARTH CABLE WIRE 2.5mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030968','F','MAIN SWITCH SINGLE PHASE','MAIN SWITCH SINGLE PHASE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W030969','F','D.O.L STARTER','D.O.L STARTER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03099','F','CLIPS 7mm','CLIPS 7mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0309911','F','FLEXIBLE CABLE 2.5MM WHITE','FLEXIBLE CABLE 2.5MM WHITE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03100','F','WHITE CABLE 4mm','WHITE CABLE 4mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03101','F','METAL CLIPS 2"','METAL CLIPS 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03102','F','SHOE TACKS 1"','SHOE TACKS 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03103','F','PLATIC CONNECTOR','PLATIC CONNECTOR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03106','F','OSRAM BULB 40W','OSRAM BULB 40W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03107','F','BULB COMESTAR','BULB COMESTAR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03108','F','PHILIPS 20WATTS','PHILIPS 20WATTS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03109','F','FUSE 8 amps','FUSE 8 amps','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03112','F','15A SMALL FUSE','15A SMALL FUSE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03113','F','FUSE 3A SMALL','FUSE 3A SMALL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03116','F','CONTACTOR LC1D32M7','CONTACTOR LC1D32M7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03118','F','DIGITAL MULTIMETER','DIGITAL MULTIMETER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03124','F','WIRE 4MM','WIRE 4MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03131','F','BULB 15 WATT THREAD','BULB 15 WATT THREAD','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0315','F','6 Way Protector','6 Way Protector','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03188','F','Bulb Holder slop','Bulb Holder slop','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03189','F','Bulb Holder Cm50610(12)','Bulb Holder Cm50610(12)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03190','F','FUSE 10AMPS','FUSE 10AMPS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03191','F','FUSE 5AMP','FUSE 5AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03192','F','FUSE 250AMP','FUSE 250AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03193','F','FUSE 3AG','FUSE 3AG','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03194','F','EXTESION WIRE BULB HOLDER','EXTESION WIRE BULB HOLDER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03195','F','CLIPS ZA X-RAY','CLIPS ZA X-RAY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03196','F','PLASTIC TERMINAL 6MM','PLASTIC TERMINAL 6MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0320','F','FLASHER UNIT 81980-32010','FLASHER UNIT 81980-32010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03200','F','RADIO CALL PIN','RADIO CALL PIN','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03201','F','CABLE LUGS 25mm','CABLE LUGS 25mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03203','F','CABLE LUGS BRASS','CABLE LUGS BRASS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03204','F','CABLE LUGS COPPER','CABLE LUGS COPPER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03205','F','CABLE LUGS 70mm','CABLE LUGS 70mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03208','F','CABLE LUGS 10mm','CABLE LUGS 10mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03209','F','BULB 15 W THREAD','BULB 15 W THREAD','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0321','F','TYRES 16.9 X38','TYRES 16.9 X38','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0322','F','TYRES 13.6 X 28','TYRES 13.6 X 28','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03250','F','LINK BUSH STABILIZER','LINK BUSH STABILIZER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03251','F','BEARING 30,57,N 45225-60010','BEARING 30,57,N 45225-60010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03252','F','CORNER LAMP 81510-60520','CORNER LAMP 81510-60520','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03253','L','SHAFT 45210-60070','SHAFT 45210-60070','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03255','F','BULB 14W TREADS','BULB 14W TREADS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03258','N','HAND BRAKE SWITCH 84550-60011','HAND BRAKE SWITCH 84550-60011','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03259','N','RELAY 90987-03001','RELAY 90987-03001','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0326','N','LINK STABILIZER ASSY 48802-60090','LINK STABILIZER ASSY 48802-60090','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03260','N','HEAD LAMP RELAY 90987-02006','HEAD LAMP RELAY 90987-02006','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0327','N','PANHARD BUSH 48706-60030','PANHARD BUSH 48706-60030','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0328','N','STEERING DAMPER 45700-60051','STEERING DAMPER 45700-60051','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03294','F','WIRE 4 CORE','WIRE 4 CORE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03295','F','BULB 11W TREAD','BULB 11W TREAD','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03296','H','FIGHTER LOCK','FIGHTER LOCK','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0330','F','EXTENSION CABLE','EXTENSION CABLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0331','N','WIPER MOTOR ASSY 85110-60180','WIPER MOTOR ASSY 85110-60180','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03318','L','GURUDUMU WHEEL CHAIR','GURUDUMU WHEEL CHAIR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0332','N','TIMING BELT 13568-19065','TIMING BELT 13568-19065','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03334','H','THINNER','THINNER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03335','H','ALFA PAINT','ALFA PAINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03336','H','SHELACAL PAINT','SHELACAL PAINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03337','F','L P MFUNIKO WA GAS','L P MFUNIKO WA GAS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03354','F','CABLE TRUNCKING 38X25','CABLE TRUNCKING 38X25','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03421','F','CLIPS 10MM','CLIPS 10MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03427','F','BULB W 0.5BLUE','BULB W 0.5BLUE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03429','F','WIRE 0.5MM','WIRE 0.5MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03435','F','HIVOLT GUARD','HIVOLT GUARD','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03437','F','CONNECTOR 3phases','CONNECTOR 3phases','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03462','F','WIRE 1 CORE 2.5MM','WIRE 1 CORE 2.5MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03464','F','ROUND S. SOCKET','ROUND S. SOCKET','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03465','F','PLUG 15A','PLUG 15A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03885','F','BULB 14W HOOKS','BULB 14W HOOKS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03886','H','FEALTY LOCK CYLINDER','FEALTY LOCK CYLINDER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03887','F','TIPLE SWITCH PEKEE','TIPLE SWITCH PEKEE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03888','F','TELEPHONE CABLE','TELEPHONE CABLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03889','F','MASHINE YA PUCHI','MASHINE YA PUCHI','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03890','F','SHOCK TRANSFOMA 40W','SHOCK TRANSFOMA 40W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03893','F','PLATE 8X2mm','PLATE 8X2mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03896','F','SHOCK TRANSFOMA','SHOCK TRANSFOMA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W03897','F','FLEXIBLE CABLE 4 CORE','FLEXIBLE CABLE 4 CORE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W040','H','SCREW 2x8','SCREW 2x8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04001','H','Screws 1/2 x 4','Screws 1/2 x 4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04002','H','Screws 1/2 x 5','Screws 1/2 x 5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04003','H','Screws 1/2 x6','Screws 1/2 x6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04004','H','Screws 5/8 x7','Screws 5/8 x7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04006','H','Screws 3/4 x6','Screws 3/4 x6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04007','H','Screws 3/4 x7','Screws 3/4 x7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04008','H','Screws 3/4 x 8','Screws 3/4 x 8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04009','H','Screws 1x6','Screws 1x6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04011','H','Screws 1x8','Screws 1x8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04012','H','Screws 1 1/4 x7','Screws 1 1/4 x7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04014','H','Screws 1 1/2x6','Screws 1 1/2x6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04015','H','Screws 1 1/2x7','Screws 1 1/2x7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04016','H','Screws 1 1/2x8','Screws 1 1/2x8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04019','H','Screws 1 1/2x12','Screws 1 1/2x12','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04020','H','Screws 1 1/4x8','Screws 1 1/4x8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04025','H','Screws 1x8','Screws 1x8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04026','H','Screws 3/4 x 4','Screws 3/4 x 4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04029','H','Screws 3 x 10','Screws 3 x 10','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04030','H','SCREW 1x10','SCREW 1x10','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04032','H','Flosher 8.5','Flosher 8.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04033','H','Flosher 6.5','Flosher 6.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04034','H','TOWER BOLT 4"X3/8"','TOWER BOLT 4"X3/8"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04036','H','BRASS SCREW 4"X3/4','BRASS SCREW 4"X3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04037','H','BRASS SCREW 6X1','BRASS SCREW 6X1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04038','H','PANEL PINS 1"X17"','PANEL PINS 1"X17"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04039','H','PANEL PINS 3/4"','PANEL PINS 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04041','H','Oxford Locks','Oxford Locks','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04042','H','SANDA PAPER P:80','SANDA PAPER P:80','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04043','H','SAND PAPER P:120','SAND PAPER P:120','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04056','H','SCREWS 1" TO 5"','SCREWS 1" TO 5"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04099','H','SCREWS 2"//10"','SCREWS 2"//10"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W041000','H','FLOSHLER 8.5','FLOSHLER 8.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W041001','H','FLOSHLER 6.5','FLOSHLER 6.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W041002','H','HOOKS 16','HOOKS 16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04115','I','BOLT 3"','BOLT 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04651','F','CIRCUIT BREAKER 3PHASE','CIRCUIT BREAKER 3PHASE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W04652','G','BLACK POLY SHEET','BLACK POLY SHEET','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050007','G','ROLLAR 1','ROLLAR 1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050008','G','ROLLAR 3/4','ROLLAR 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05001','G','Aluminium Paint','Aluminium Paint','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050010','H','FOMAICA','FOMAICA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050010,','H','Fomaica','Fomaica','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050011','G','ALLUMINIUM PAINT','ALLUMINIUM PAINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05003','G','Brilliant White','Brilliant White','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05004','G','National Paint (Red)','National Paint (Red)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05005','G','Pearl Paint','Pearl Paint','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05006','G','Ceiling Paint White','Ceiling Paint White','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05007','G','Oil Paint White','Oil Paint White','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05010','G','Roofing Paint (Red Paint Bati)','Roofing Paint (Red Paint Bati)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050100','G','LIGHT BLUE OIL PAINT','LIGHT BLUE OIL PAINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0501008','G','Radio Call CP040 Walinzi','Radio Call CP040 Walinzi','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05011','G','Undercoat White','Undercoat White','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050111','H','Oxford Lock Handle','Oxford Lock Handle','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0501120','E','GARDEN HOSE PIPE 3/4','GARDEN HOSE PIPE 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050114','H','MORTICE LOCK SOLEX','MORTICE LOCK SOLEX','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050119','E','R /SOCKET 1 X 3/4','R /SOCKET 1 X 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05012','G','Clear Varnish','Clear Varnish','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05013','G','Maroo Varnish','Maroo Varnish','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05014','G','CRACK FILLER','CRACK FILLER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05015','G','Turpentine','Turpentine','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050170','G','TURBOBRIGHT GLOSS-CLEAR','TURBOBRIGHT GLOSS-CLEAR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05018','E','Putty','Putty','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05019','G','Floor Polish - Red','Floor Polish - Red','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05022','E','White Wall Tiles','White Wall Tiles','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W050231','H','Oil from Norway for wood (Di-Desks Olje)','Oil from Norway for wood (Di-Desks Olje)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05024','G','Wax Polish','Wax Polish','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05025','G','Rubber Paint','Rubber Paint','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05026','G','Pearl Emulsion','Pearl Emulsion','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05028','G','SUN PROOF VARNISH','SUN PROOF VARNISH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05029','H','Brass Padlock ART 265','Brass Padlock ART 265','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05031','G','BABY BLUE PAINT','BABY BLUE PAINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05035','G','VARNISH NORWAY','VARNISH NORWAY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05037','G','TURBOR BRIGHT HARDENER','TURBOR BRIGHT HARDENER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05045','K','WATER PROFF CEMENT','WATER PROFF CEMENT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05050','F','DOUBLE WAY SWITCH SOCKET','DOUBLE WAY SWITCH SOCKET','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05053','G','JUTON BENAR','JUTON BENAR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05057','G','RED OXID PRIME','RED OXID PRIME','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05058','G','XYLADECOR (FABRIGE)','XYLADECOR (FABRIGE)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05059','G','ALKALI RUBBER PRIMERWHITE PAINT','ALKALI RUBBER PRIMERWHITE PAINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05061','G','SUPPER GLASS WHITE','SUPPER GLASS WHITE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05063','G','VESTA VARNISH STAIN DARK OAK','VESTA VARNISH STAIN DARK OAK','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05079','G','EMUL.TOPEZ BLUE','EMUL.TOPEZ BLUE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05082','G','GROWN PERMANENT GREEN','GROWN PERMANENT GREEN','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05098','E','VIOO 6MM 186X50','VIOO 6MM 186X50','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05099','E','VIOO 6MM 98/96X21/22','VIOO 6MM 98/96X21/22','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05124','G','BLACK PAINT','BLACK PAINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05147','H','DOOR CLOSER','DOOR CLOSER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05148','H','DOUBLEACTRON HINGES','DOUBLEACTRON HINGES','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05149','H','CLEAR GLASS 4MM','CLEAR GLASS 4MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05150','E','GUTTER CONNECTOR','GUTTER CONNECTOR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05151','E','SUPPORT BRACKET','SUPPORT BRACKET','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05152','I','BOLT WITH NUT','BOLT WITH NUT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05330','G','Brush 1"','Brush 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05331','E','CONNECTOR 16mm','CONNECTOR 16mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05332','G','BRUSH 2"','BRUSH 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05333','G','BRUSH 2 1/2"','BRUSH 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05334','G','BRUSH 4"','BRUSH 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05335','G','BRUSH 3"','BRUSH 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05555','G','EXPERT POLISH 5L','EXPERT POLISH 5L','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05556','H','GAGE TEMPERATURE 83420-20020','GAGE TEMPERATURE 83420-20020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05898','H','SHARPENING STONE 109"','SHARPENING STONE 109"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W05899','H','SHARPENING STONE 108','SHARPENING STONE 108','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W06007','H','Hinge 2 1/2" Ulaya','Hinge 2 1/2" Ulaya','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W060071','H','HUKAR SHABA 7120-0-03-00','HUKAR SHABA 7120-0-03-00','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W06008','H','Hinge 2 1/2" - Bawaba','Hinge 2 1/2" - Bawaba','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W06009','H','Hinge 2 3/4" - Ulaya','Hinge 2 3/4" - Ulaya','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W06010','H','Hinge 3"- Bawaba','Hinge 3"- Bawaba','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W060101','H','Hinge 3" brass','Hinge 3" brass','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W060102','H','Hinge 4" brass','Hinge 4" brass','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W06011','H','Hinge 3 1/2" -Ulaya','Hinge 3 1/2" -Ulaya','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W06014','H','Hinge 4 3/4"','Hinge 4 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W06015','H','Brass Hinges 4"X 2 5/8','Brass Hinges 4"X 2 5/8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W070011','I','BOLTS AND NUTS BSW 3/8 X1^','BOLTS AND NUTS BSW 3/8 X1^','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07005','I','Spring Washer 5/16','Spring Washer 5/16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07006','I','Flat Washer 3/8','Flat Washer 3/8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07008','I','Bolt UNF 3/8 x 1"','Bolt UNF 3/8 x 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07009','I','Bolt & Nut UNF 3/8x 1"','Bolt & Nut UNF 3/8x 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07010','I','Bolt & Nut UNC 3/8 x 1 1/2','Bolt & Nut UNC 3/8 x 1 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W070101','I','BOLTS+NUTS 20X50','BOLTS+NUTS 20X50','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07012','I','UNF 3/8 x 2"','UNF 3/8 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07013','I','Bolt & Nut 3/8 x 2"','Bolt & Nut 3/8 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07014','I','UNF 3/8 x 3"','UNF 3/8 x 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07015','I','Bolt BSW 3/8 x 3"','Bolt BSW 3/8 x 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07018','I','Bolt & Nut 7/16 x 1"','Bolt & Nut 7/16 x 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07019','I','Bolts & NUts 7/16 x 1 1/2 UNF','Bolts & NUts 7/16 x 1 1/2 UNF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07020','I','Bolt & Nut UNF 7/16 x 2"','Bolt & Nut UNF 7/16 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07021','I','Bolt 7/16 x 2"','Bolt 7/16 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07023','I','Bolt 1/2 x 2"','Bolt 1/2 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07024','I','Bolt BSW 1/2 x 2"','Bolt BSW 1/2 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07025','I','Spring Washer 1/2"','Spring Washer 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07028','I','Bolt BSW 9/16 x 3"','Bolt BSW 9/16 x 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07029','I','Bolt BSW 5/8 x 2"','Bolt BSW 5/8 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07030','I','Nut UNC 5/8','Nut UNC 5/8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07031','I','Spring Washer 5/8','Spring Washer 5/8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07032','I','Bolt & Nut BSW 3/4 x 1 1/2"','Bolt & Nut BSW 3/4 x 1 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07033','I','Bolt & Nut BSW 3/4 x 2"','Bolt & Nut BSW 3/4 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07034','I','Spring Wash 3/4','Spring Wash 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07035','I','Bolt 10 x 50 mm','Bolt 10 x 50 mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07036','I','BOlt 10 x 50 mm','BOlt 10 x 50 mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07037','I','Bolt unc 1/2 x1','Bolt unc 1/2 x1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07038','I','BOLTS UNF','BOLTS UNF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07039','I','GALV. BOLT SIZE 1/4 X1 1/2','GALV. BOLT SIZE 1/4 X1 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07040','I','BOLT 5/16X3"','BOLT 5/16X3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07041','I','Bolts +Nuts UNC 5/16 x 2"','Bolts +Nuts UNC 5/16 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07042','I','UNF BOLT 5/8 x 2"','UNF BOLT 5/8 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07043','I','UNC 5/8 x 4" BOLT','UNC 5/8 x 4" BOLT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07044','I','Unc bolt 5/8 x 2 1/2','Unc bolt 5/8 x 2 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07045','I','ucn bolt 5/16 x 1 1/2','ucn bolt 5/16 x 1 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07046','I','Unc bolt 5/16 x 1','Unc bolt 5/16 x 1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07047','I','bolt 10 x60mm','bolt 10 x60mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07048','I','FLAT WASHER 5/16','FLAT WASHER 5/16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07049','I','SPRING WASHER 1"','SPRING WASHER 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07051','I','UNF BOLT 1/4 X 2"','UNF BOLT 1/4 X 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07052','I','UNC BOLT 5/16 x 2"','UNC BOLT 5/16 x 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07054','I','Bolt + Nut 3/4 x 2 1/2','Bolt + Nut 3/4 x 2 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07056','I','UNF BOLT 3/8 x 2 1/2"','UNF BOLT 3/8 x 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07057','I','NUTS 12mm','NUTS 12mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07058','I','BOLTS & NUTS 16x75Mm','BOLTS & NUTS 16x75Mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07059','I','SPRING WASHEL 3/4','SPRING WASHEL 3/4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07060','I','unf bolt 9/16','unf bolt 9/16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07061','I','BOLT+NUTS 21/2"TO 1/2"','BOLT+NUTS 21/2"TO 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07062','I','BOLTS+NUTS 3"//1/4"','BOLTS+NUTS 3"//1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07063','I','ROOFING BOLTS 1/4"/21/2"','ROOFING BOLTS 1/4"/21/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07064','I','WASHERS 8//60','WASHERS 8//60','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07065','I','BOLTS+NUTS 8#60cm','BOLTS+NUTS 8#60cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07066','I','BOLTS + NUTS 2"//1/4"','BOLTS + NUTS 2"//1/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07067','I','CUP HOOKS 11/2"','CUP HOOKS 11/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07070','I','BOLT +NUTS 9/16 X 8"','BOLT +NUTS 9/16 X 8"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07071','I','UNC 5/8 X 3"','UNC 5/8 X 3"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W07099','H','BAWABA ULAYA 11/4TO1"','BAWABA ULAYA 11/4TO1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W0801','S','ACTELIC DUST 200G','ACTELIC DUST 200G','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10001','H','Sandpaper no.2 (msasa)','Sandpaper no.2 (msasa)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W100011','H','Msasa No.2 1/2','Msasa No.2 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10003','H','Sandpaper no.1 1/2 (Msasa)','Sandpaper no.1 1/2 (Msasa)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10005','H','Ponal Glue','Ponal Glue','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W100051','H','Ponal Glue 4 Litre','Ponal Glue 4 Litre','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10006','F','Solution Tape','Solution Tape','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10007','R','Brake Fluid','Brake Fluid','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10009','N','Solution 25g','Solution 25g','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10010','S','Actellic Dust 200G','Actellic Dust 200G','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10011','H','Msasa No.0 Very Fine','Msasa No.0 Very Fine','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10019','I','Arc Welding','Arc Welding','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10020','K','Cement','Cement','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10022','I','Arc-Welding stick','Arc-Welding stick','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W100223','I','STICK STEEL','STICK STEEL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10023','H','MORTICE LOCK UNION','MORTICE LOCK UNION','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10029','H','Saw blades 10D','Saw blades 10D','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10030','G','French Polish','French Polish','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10031','G','Drawer Lock','Drawer Lock','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10032','E','Tape 1/2"','Tape 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10035','I','Cutting Disc 180 x3 x 22','Cutting Disc 180 x3 x 22','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10037','I','GRINDING DISC 9"*1\4*7\8','GRINDING DISC 9"*1\4*7\8','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10039','H','Misumeno ya Mbao','Misumeno ya Mbao','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10040','H','Handle ya Kabati','Handle ya Kabati','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10042','H','GAUSE WIRE (ROOL)','GAUSE WIRE (ROOL)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W102012','H','CHIPBOARD','CHIPBOARD','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W10202','I','Arc Aluminium stick','Arc Aluminium stick','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11001','E','Steel window fastener L','Steel window fastener L','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110011','E','Window handle R','Window handle R','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110012','E','HANDLE FOR STEEL WINDOW RR','HANDLE FOR STEEL WINDOW RR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110013','E','HANDLE FOR STEEL WINDOW LL','HANDLE FOR STEEL WINDOW LL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11002','E','Steel window Fastener L','Steel window Fastener L','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110021','E','Window Handle L','Window Handle L','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110032','H','Cylinder lock 7412','Cylinder lock 7412','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110041','H','TOWER BOLT <NYEUSI> 4','TOWER BOLT <NYEUSI> 4','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110076','H','PAD LOCK T-RHUMB','PAD LOCK T-RHUMB','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11008','H','Tower Bolt Brass 6"','Tower Bolt Brass 6"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110081','H','Tower Bolt Brass 4"','Tower Bolt Brass 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11023','J','Cement Sprayer (Mashine ya Puching)','Cement Sprayer (Mashine ya Puching)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11024','H','Shoe Tacks 5/8"','Shoe Tacks 5/8"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11026','H','Panel Pins 1 1/2','Panel Pins 1 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11027','R','WD 40 Dawa Ya kutu','WD 40 Dawa Ya kutu','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11034','E','HANDLE FOR STILLWINDOW','HANDLE FOR STILLWINDOW','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110360','H','RAILWAY HINGES 5"','RAILWAY HINGES 5"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110361','H','TOWER BOLT 4"','TOWER BOLT 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110504','H','Union lock 680-06-77as','Union lock 680-06-77as','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110506','H','Bird Zink Alloy Dead Lock 0515 A.B','Bird Zink Alloy Dead Lock 0515 A.B','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11061','H','Brass Drower Lock','Brass Drower Lock','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11063','U','Fire Extinguishers','Fire Extinguishers','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11068','H','KISU CHA RANDA No.6','KISU CHA RANDA No.6','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11072','H','S0LEX -KUFULI','S0LEX -KUFULI','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11073','H','CHICKEN WIRE','CHICKEN WIRE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110740','H','VIRO CYLINDER LOCK ART 104/A(710)','VIRO CYLINDER LOCK ART 104/A(710)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110741','H','YALE SECURITY LOCK 2007','YALE SECURITY LOCK 2007','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W110742','H','PAD LOCK 261','PAD LOCK 261','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11076','H','BELT PIX SPZ 1275','BELT PIX SPZ 1275','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11077','H','COMB SHAPENING STONE','COMB SHAPENING STONE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11078','F','GAS FITTINGS','GAS FITTINGS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11080','H','Komeo ya milango','Komeo ya milango','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11081','H','Tower Bolt Brass 2 1\2','Tower Bolt Brass 2 1\2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11084','M','Majembe','Majembe','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11088','H','VIRO DEAD LOCK 7702','VIRO DEAD LOCK 7702','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11089','H','RAWL BOLTS M10','RAWL BOLTS M10','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11090','H','RAWL BOLTS 8M ( 5/16)','RAWL BOLTS 8M ( 5/16)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11093','H','FISCHER 12Mm (S 12 )','FISCHER 12Mm (S 12 )','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11094','H','FLYSCHER 10Mm ( S 10 )','FLYSCHER 10Mm ( S 10 )','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11096','H','YALE UNION (AL 685-24-955AS','YALE UNION (AL 685-24-955AS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W11097','H','MULTIPURRPOSE DRAWER LOCK EKRI (BRASS)','MULTIPURRPOSE DRAWER LOCK EKRI (BRASS)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12002','P','Main Bearing PN.572-50650','Main Bearing PN.572-50650','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12003','P','Drive Belt (FAN) 366-06739','Drive Belt (FAN) 366-06739','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12004','P','Con Rod Bolt 351-50050','Con Rod Bolt 351-50050','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12005','P','Bush 201-44950','Bush 201-44950','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12010','P','Oil Filter 352-31720','Oil Filter 352-31720','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W120101','P','Oil Filter 751-12870','Oil Filter 751-12870','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12011','P','Oil Filter Element 201-55370','Oil Filter Element 201-55370','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12012','P','Oil Filter 291-40910','Oil Filter 291-40910','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12013','P','Fuel Filter 751-18100','Fuel Filter 751-18100','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12023','P','Joint Set 657-19706','Joint Set 657-19706','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12026','P','Link 366-07913','Link 366-07913','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12028','P','Con. Link. 572-11790','Con. Link. 572-11790','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12029','P','Nozzle 202-36720','Nozzle 202-36720','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12031','P','Nuts 270-00006','Nuts 270-00006','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12032','P','Oil Pump 354-50440','Oil Pump 354-50440','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W120334','P','FLEETGUARD -AF -25539 AIR FILTER','FLEETGUARD -AF -25539 AIR FILTER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12034','P','Jabsco Pump 572-10451','Jabsco Pump 572-10451','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12035','P','Ring 601-38490','Ring 601-38490','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12037','P','Rocker Push ARM 373-10170','Rocker Push ARM 373-10170','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12039','P','COD BEARING','COD BEARING','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12040','P','Bearing Con. Rod 570-30011','Bearing Con. Rod 570-30011','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12042','P','Push Rod 354-10311','Push Rod 354-10311','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12048','P','In-Valve 201-30040','In-Valve 201-30040','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12050','P','In Valve 351-50420','In Valve 351-50420','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12052','P','Vr Lever 572-50391','Vr Lever 572-50391','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12053','P','Thrust Washer 351-50290','Thrust Washer 351-50290','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12054','P','Thrust Washer 570-31360','Thrust Washer 570-31360','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12055','P','Water Pump NO.1-2','Water Pump NO.1-2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12056','P','PISTON','PISTON','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12057','P','FUEL FILTER OIL 276.2175.36','FUEL FILTER OIL 276.2175.36','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12058','P','BELT LITER 751-17820','BELT LITER 751-17820','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12059','P','OIL SEAL P751-10430','OIL SEAL P751-10430','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12060','P','AIR CLEANER 962K','AIR CLEANER 962K','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12062','P','TEE PIPE','TEE PIPE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12063','P','R HOLE','R HOLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12064','P','RADIATOR CAP LISTER PETTER','RADIATOR CAP LISTER PETTER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12067','P','VALVE EXAUST 201-30051','VALVE EXAUST 201-30051','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12072','P','OIL SEAL SMALL SIZE 22x35x7','OIL SEAL SMALL SIZE 22x35x7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12074','P','FUEL FILTER 180-8984/522','FUEL FILTER 180-8984/522','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12154','P','TIMING COVER OIL SEAL','TIMING COVER OIL SEAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12156','P','CAN SHAFT BUSH','CAN SHAFT BUSH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12158','P','ALLIMINIUM OXIDE -KINOA','ALLIMINIUM OXIDE -KINOA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12160','H','PAD LOCK # 265','PAD LOCK # 265','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12161','H','PAD LOCK # NO/ 50 YALE','PAD LOCK # NO/ 50 YALE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12162','H','PAD LOCK NO/ 30 YALE','PAD LOCK NO/ 30 YALE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12164','H','PAD LOCK NO 264','PAD LOCK NO 264','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12335','P','ELEMENT 201-26020','ELEMENT 201-26020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W12337','I','STARTING HANDLE','STARTING HANDLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W1345','E','GLASS CUTTER','GLASS CUTTER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20003','M','Bearings Ball Fafnir (Harrow)','Bearings Ball Fafnir (Harrow)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20004','M','Bearing Front Axle Outer (Small)','Bearing Front Axle Outer (Small)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W2001','R','ENGINE OIL 3E9840 208 LTS','ENGINE OIL 3E9840 208 LTS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W2002','E','GARDEN TAP LOCK 3/4"','GARDEN TAP LOCK 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20026','M','Spring Adjuster ya Sungura','Spring Adjuster ya Sungura','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20036','N','Wheel Studs 3/4"','Wheel Studs 3/4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20042','N','Bush Pin Fulcrum','Bush Pin Fulcrum','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20043','T','Nipple Kwa Tractor','Nipple Kwa Tractor','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20044','T','FUEL FILTER 7111-296','FUEL FILTER 7111-296','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20045','T','Oil Filter','Oil Filter','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W200450','I','BOLT + NUT 12x25MM','BOLT + NUT 12x25MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W200451','N','TUBE 14.9 X28','TUBE 14.9 X28','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20046','T','BOLT YA SAHANI -TRACTOR','BOLT YA SAHANI -TRACTOR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20049','T','Bearing Rear Axele 3984/20','Bearing Rear Axele 3984/20','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W2005','I','BOLT + NUTS 16 X60mm','BOLT + NUTS 16 X60mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20050','T','REDUCTION SEAL','REDUCTION SEAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20053','T','BRAKE DISC MF265','BRAKE DISC MF265','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W200541','T','PLATE JEMBE KK075671','PLATE JEMBE KK075671','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W200542','T','KIT JOINT SEAL 3477804M1','KIT JOINT SEAL 3477804M1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W200543','I','BOLT NUT 20 x35mm','BOLT NUT 20 x35mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W200544','F','BULB 12V P21W 00245-069','BULB 12V P21W 00245-069','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W200545','T','BEARING CS 204 DD U','BEARING CS 204 DD U','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W200556','T','CAP SEAL 1823595 M1','CAP SEAL 1823595 M1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20056','T','BULB V.12 45','BULB V.12 45','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20057','I','Bolt +Nut 12 x 25mm','Bolt +Nut 12 x 25mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20059','I','RUBBER BOOT SEAL','RUBBER BOOT SEAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20060','T','FUEL FILTER FF167','FUEL FILTER FF167','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20061','T','PLATES YA JEMBE (ULIMI) KK073256R','PLATES YA JEMBE (ULIMI) KK073256R','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20062','T','MDOMO WA JEMBE KKO 73004','MDOMO WA JEMBE KKO 73004','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20063','T','SAHANI YA JEMBE K78333','SAHANI YA JEMBE K78333','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20064','T','PIN ZA PLOUGH (jembe)','PIN ZA PLOUGH (jembe)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20067','T','PLANTER BUSH GEAR 25095','PLANTER BUSH GEAR 25095','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20068','T','PLNTER BUSH GEAR 25156','PLNTER BUSH GEAR 25156','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20069','T','HYDROLC FILTER 1810694M92','HYDROLC FILTER 1810694M92','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W2007','T','BULB 12V\55W 720-112 1','BULB 12V\55W 720-112 1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20070','T','GREASE SHELL SRS 2000','GREASE SHELL SRS 2000','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20071','T','VISU VYA JEMBE BOLT,NUTS','VISU VYA JEMBE BOLT,NUTS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20076','I','GREASE GUN PUMP','GREASE GUN PUMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20078','T','oil filter 96341-112204','oil filter 96341-112204','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20079','T','FREM YA MKONO WA JEMBE 1660265M91','FREM YA MKONO WA JEMBE 1660265M91','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20087','T','BULB 12V/10W 37R-00280','BULB 12V/10W 37R-00280','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20088','T','OIL SEAL DM 102','OIL SEAL DM 102','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20091','T','Bolt for Plow kk010700/kk077020','Bolt for Plow kk010700/kk077020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20093','T','Bolt +Nuts 16 x 60mm','Bolt +Nuts 16 x 60mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20094','T','Plate Jembe KK07671','Plate Jembe KK07671','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20095','T','Kit Joint Seal 3477804M1','Kit Joint Seal 3477804M1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20096','I','Bolt Nut 20 x 35mm','Bolt Nut 20 x 35mm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20097','N','Bub 12v p21 w 00245-069','Bub 12v p21 w 00245-069','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20098','N','Bearing CS 204 DD U','Bearing CS 204 DD U','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20099','N','Bulb 12v/55w 720-112 1','Bulb 12v/55w 720-112 1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20105','N','Water Pump Ass','Water Pump Ass','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20106','I','UNC BOLT 1/2"X 2"','UNC BOLT 1/2"X 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20107','E','Choo-S-Type','Choo-S-Type','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W2018','I','BEARING 32213','BEARING 32213','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W2019','I','BEARING 30210','BEARING 30210','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W2020','H','TUPA(FILESMOOTH)30CM','TUPA(FILESMOOTH)30CM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20201','H','TUPA NUSU DUARA','TUPA NUSU DUARA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W20202','H','TUPA KUBWA (FILE SMOOTH)','TUPA KUBWA (FILE SMOOTH)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W2027','I','SPRING CAP','SPRING CAP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W235410','E','CHOO-S-TYPE','CHOO-S-TYPE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28000','N','FUEL -FILTER-203-32470','FUEL -FILTER-203-32470','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W280010','N','WIPER BLADES A 000 824 5026','WIPER BLADES A 000 824 5026','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28002','N','FAN BELT 13A 1375','FAN BELT 13A 1375','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28004','N','OIL SEAL 014-997 1647','OIL SEAL 014-997 1647','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28005','N','SELF STAR BRUSH A 000154 67 14','SELF STAR BRUSH A 000154 67 14','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28006','N','SEAL HUB FRONT A 016 997 75 47','SEAL HUB FRONT A 016 997 75 47','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28007','N','OIL FILTER 001-184 70 25','OIL FILTER 001-184 70 25','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28010','N','FAN BELT A-46','FAN BELT A-46','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28011','N','Wiper Blades A 000 824 5026','Wiper Blades A 000 824 5026','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28020','N','RADITOR FLUID 1232/2','RADITOR FLUID 1232/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28101','N','FRONT SPRING BREAK 22A 416 993 53 10','FRONT SPRING BREAK 22A 416 993 53 10','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28102','N','CLAMP FOR FITTINGS','CLAMP FOR FITTINGS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28103','N','FITTING FOR COMPRESSOR 7D','FITTING FOR COMPRESSOR 7D','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28104','N','BALL VALVE SKG 35','BALL VALVE SKG 35','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28105','N','RUBBER FOR FITTING','RUBBER FOR FITTING','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28107','N','LINING BREAK FRONT +REAR A 416-421-25 1','LINING BREAK FRONT +REAR A 416-421-25 1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28108','N','SPRING DRUM REAR 23A-416 993 5410','SPRING DRUM REAR 23A-416 993 5410','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28109','N','HOSE PIPE C 11575-003','HOSE PIPE C 11575-003','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28110','N','SIDE ROD DRILL FOR COMPRESSOR 4105J00730','SIDE ROD DRILL FOR COMPRESSOR 4105J00730','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28210','N','BOLT N 910107-012010','BOLT N 910107-012010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28213','N','BULB V.12 21W T3','BULB V.12 21W T3','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28214','N','TOOL FOR APLYING SILICON','TOOL FOR APLYING SILICON','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28216','N','BELT 12.5x1450','BELT 12.5x1450','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28217','N','MAIN CRANC SHAFT SEAL A 006 997.85 47','MAIN CRANC SHAFT SEAL A 006 997.85 47','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W282230','N','COIL SPRING REAR 404.324 0104','COIL SPRING REAR 404.324 0104','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28229','N','TRACK ROD END 884701M92','TRACK ROD END 884701M92','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28538','N','SHOCK ABSORBER','SHOCK ABSORBER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28539','N','HOSE CLIPS 1/2','HOSE CLIPS 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28542','N','DIFF PINS','DIFF PINS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28543','N','REAR-SECOND LEAF SPRING','REAR-SECOND LEAF SPRING','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28546','N','CUSHION 909848','CUSHION 909848','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W28547','N','STABILIZER BUSH','STABILIZER BUSH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W30002','N','Cylinder kit','Cylinder kit','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W30013','N','Parking light Bulbs','Parking light Bulbs','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W30016','N','Main Hole Cover 18 x 18 cm','Main Hole Cover 18 x 18 cm','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W302107','N','MAIN HOLE COVER 18 X 18CM','MAIN HOLE COVER 18 X 18CM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3045','N','V.BELT 105','V.BELT 105','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W304510','N','SHOCK AB BUSHES 90385-19007','SHOCK AB BUSHES 90385-19007','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W30456','N','SPEEDO METER CABLE 83710-90K06','SPEEDO METER CABLE 83710-90K06','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W30457','N','BUSH SUB ASSY 48706-60030','BUSH SUB ASSY 48706-60030','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W30458','N','BULB ASSY 90010-06003','BULB ASSY 90010-06003','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W30459','N','BULB 12V, 5W 99132-1250','BULB 12V, 5W 99132-1250','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3086','F','EARTH -WIRE 2.5','EARTH -WIRE 2.5','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3087','F','CABLE 6.0','CABLE 6.0','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3088','H','FLOSCHER','FLOSCHER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3089','F','BULB 15W HOOKS','BULB 15W HOOKS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W31043','N','Spider Kit 04371-36021','Spider Kit 04371-36021','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32000','N','LUCERN GRASS 041877','LUCERN GRASS 041877','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3200010','N','PRESSURE PLATE +CLUTCH','PRESSURE PLATE +CLUTCH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3200011','N','THREADED BAR 10MM X2MT','THREADED BAR 10MM X2MT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3200013','F','BATTERY 9V','BATTERY 9V','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320002','F','FUSE 3.5 AMP','FUSE 3.5 AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320003','F','FUSE 3AMP','FUSE 3AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320004','F','FUSE 5 AMP','FUSE 5 AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320005','F','FUSE 1.5 AMP','FUSE 1.5 AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320006','F','FUSE 5AMP','FUSE 5AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320007','F','FUSE 3AMP','FUSE 3AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320008','F','FUSE 2.5 AMP','FUSE 2.5 AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32001','N','Bearing-90365-47013','Bearing-90365-47013','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3200100','N','FUEL GARGE ASSY 83320- 69165','FUEL GARGE ASSY 83320- 69165','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320010013','N','NALI FUPI 7.50X16','NALI FUPI 7.50X16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320010014','I','NUT 10MM','NUT 10MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320010015','I','WASHERS 10 MM','WASHERS 10 MM','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320010018','I','HACKSAW BLADE 18','HACKSAW BLADE 18','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32001007','I','DOOR RUBER 62471-60320','DOOR RUBER 62471-60320','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32001008','I','DOOR RUBER 67862-60110','DOOR RUBER 67862-60110','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320012','N','CON ROD BEARING','CON ROD BEARING','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320016','N','ROTOR KIT 04162-34010','ROTOR KIT 04162-34010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320018','N','Stabilizer Link','Stabilizer Link','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32002','N','Bearing Assy Clutch -31230-60130','Bearing Assy Clutch -31230-60130','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320022','N','RADIATOR CAP','RADIATOR CAP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320023','I','TYRE PRESSURE GAUGE','TYRE PRESSURE GAUGE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320025','N','THERMOSTAT 90916-03036','THERMOSTAT 90916-03036','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320026','N','NOZZLE 093400-5060','NOZZLE 093400-5060','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3200262','N','SIDE MIRROR 87910-90K00 L','SIDE MIRROR 87910-90K00 L','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320028','N','GALVANIZED PIPE 2 1/2"','GALVANIZED PIPE 2 1/2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32003','N','Bearing Radial Ball','Bearing Radial Ball','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320031','N','WHEEL BEARING RPT 50,82 K','WHEEL BEARING RPT 50,82 K','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320032','N','HUB OIL SEAL AA 800E','HUB OIL SEAL AA 800E','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320042','N','FRONT SHOCKABSOBER 48511-69505','FRONT SHOCKABSOBER 48511-69505','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32006','N','Belt Set -90916-02330','Belt Set -90916-02330','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320061','N','Belt Timing 13568-19065','Belt Timing 13568-19065','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32008','N','Bulb 12v 21W 5W-99132-21210','Bulb 12v 21W 5W-99132-21210','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32010','N','Bulb 12v 21w-99132-11210','Bulb 12v 21w-99132-11210','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320100','N','BULB 12V 15CP 93-BA15S','BULB 12V 15CP 93-BA15S','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3201000','N','SHAKLE KIT 04481-35040','SHAKLE KIT 04481-35040','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3201001','N','HUB BOLT & NUTS(WHEEL STUDS & NUTS)','HUB BOLT & NUTS(WHEEL STUDS & NUTS)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3201002','N','BRAKE MASTER CY KIT 04493-35280','BRAKE MASTER CY KIT 04493-35280','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3201005','N','CUP KIT 04906-35130','CUP KIT 04906-35130','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32010051','N','cylinder kit 04479-30030','cylinder kit 04479-30030','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3201007','N','BULB 12V 5W 99132-12050-76','BULB 12V 5W 99132-12050-76','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3201008','N','BEARING SWIVAL','BEARING SWIVAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320101','N','Solution','Solution','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320103','N','VIRAKA 30/1','VIRAKA 30/1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320105','N','CUP KIT WK 527','CUP KIT WK 527','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3201052','N','CUP KIT 04905-36050','CUP KIT 04905-36050','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3201053','N','PEADAL BREAK 31321-14020','PEADAL BREAK 31321-14020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320106','N','ALTERNATOR BRUSH','ALTERNATOR BRUSH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32011','N','Bulb 12v,35w-99132-11350','Bulb 12v,35w-99132-11350','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320111','N','BULB 12V 32/3CP','BULB 12V 32/3CP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320112','N','Bulb 24V-24w','Bulb 24V-24w','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32012','N','Cap Radiator-16401-71010','Cap Radiator-16401-71010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320123','N','Valve Key','Valve Key','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32013','N','Tube ya Tyre','Tube ya Tyre','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320134','N','COIL SPRING FRONT HJ78','COIL SPRING FRONT HJ78','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32014','N','Canvize for Tube tyre','Canvize for Tube tyre','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320141','N','Centre Bolt','Centre Bolt','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320145','N','REAR SHOCK ABSORBER 48531-69645','REAR SHOCK ABSORBER 48531-69645','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32015','N','Cover-81276-90k02','Cover-81276-90k02','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32016','N','Cup-04475-36070','Cup-04475-36070','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32019','N','Clynder kit-04311-60100','Clynder kit-04311-60100','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32021','N','Cylinder kit Brake-04313-60081','Cylinder kit Brake-04313-60081','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320231','N','Bulb 12v-45/40w','Bulb 12v-45/40w','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32024','N','Element Air-17801-61030','Element Air-17801-61030','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320241','N','Element Kit 04234-68010','Element Kit 04234-68010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320245','N','ELEMENT AIR CLEANER','ELEMENT AIR CLEANER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32025','N','End Sub Assytie-45046-69145','End Sub Assytie-45046-69145','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32026','N','End Sub Assy Tie-45047-69085','End Sub Assy Tie-45047-69085','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320262','N','End Sub Assy Str Rel 45045-69046','End Sub Assy Str Rel 45045-69046','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320263','N','End Sub Assy Str Rel 45044-69076','End Sub Assy Str Rel 45044-69076','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32027','N','Flexble-Pipe-96940-34405','Flexble-Pipe-96940-34405','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32028','N','Filter Fuel-23303-64010','Filter Fuel-23303-64010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32031','N','Gasket Engine kit-04111-17010','Gasket Engine kit-04111-17010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32032','N','Gasket for Exhaust pipe','Gasket for Exhaust pipe','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32035','N','Hose Flexible-96940-39855','Hose Flexible-96940-39855','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32036','N','Hose Pipe Radiator-16571-17020','Hose Pipe Radiator-16571-17020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320365','N','SHIMS SWIVAL','SHIMS SWIVAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32037','N','Hose Radiator no.2-16572-17020','Hose Radiator no.2-16572-17020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320374','N','VIOO VYA MBELE YA MAGARI','VIOO VYA MBELE YA MAGARI','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320377','N','BULB LAMP MS820046','BULB LAMP MS820046','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32038','N','Lens-81271-87004','Lens-81271-87004','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32039','N','Lens-81511-90k02','Lens-81511-90k02','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32040','N','Lens -81211-90k01','Lens -81211-90k01','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32041','N','Lens Body-81551-90k00','Lens Body-81551-90k00','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32042','N','Lens Body-81561-90k00','Lens Body-81561-90k00','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320422','N','Lense 81731-14090','Lense 81731-14090','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320423','N','Lense 81621-89111','Lense 81621-89111','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320424','N','Lense 81271-89110','Lense 81271-89110','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320425','N','Lense 81511-60211','Lense 81511-60211','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320426','N','Lense 81521-90k02','Lense 81521-90k02','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32043','N','Oil Filter-90915-03006','Oil Filter-90915-03006','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320441','N','Plate 48046-35120','Plate 48046-35120','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320442','N','Plate 48471-35010','Plate 48471-35010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320443','N','Plate 48472-35020','Plate 48472-35020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32045','N','Rubber blade-85221-89103','Rubber blade-85221-89103','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32046','N','Sealed Beam-6014x1','Sealed Beam-6014x1','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32047','N','Shock-Absorber-FR-48511-69355','Shock-Absorber-FR-48511-69355','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32048','N','Shock absorber RR-48531-69385','Shock absorber RR-48531-69385','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32049','N','Shoe kit brake Front-04494-60030','Shoe kit brake Front-04494-60030','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320491','N','Shackel Pin Complete','Shackel Pin Complete','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32050','N','SPORTLIGHT 12v 1, 2-114-73902','SPORTLIGHT 12v 1, 2-114-73902','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320501','N','Stering Damper Rubber 23','Stering Damper Rubber 23','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32051','N','Spring Bush-90385-18009','Spring Bush-90385-18009','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320512','N','Spring Rear 2nd Leaf','Spring Rear 2nd Leaf','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320513','N','SPRING 3rd LEAF FRONT','SPRING 3rd LEAF FRONT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32053','N','Timing Belt-13568-19065','Timing Belt-13568-19065','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32055','N','Universal Joint-04371-35031','Universal Joint-04371-35031','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32056','N','Front Bumper 48305-60021','Front Bumper 48305-60021','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32057','N','Bumper Sub Assy FR','Bumper Sub Assy FR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320571','N','EXHAUST MOUNTING 17567-17010','EXHAUST MOUNTING 17567-17010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32058','N','U- Bolt of Toyota Hj 75','U- Bolt of Toyota Hj 75','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32059','N','Tyres 7.50 - 16','Tyres 7.50 - 16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320591','N','Cable ya brake lining(Handle brea 47616-','Cable ya brake lining(Handle brea 47616-','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32061','N','Wiper Blade 85221-12230','Wiper Blade 85221-12230','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32063','N','VIRAKA 30/7','VIRAKA 30/7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32064','N','VIRAKA 30/2','VIRAKA 30/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32065','N','HUB LOCK NUT','HUB LOCK NUT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320650','N','HOSE PIPE 16572-58040','HOSE PIPE 16572-58040','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320651','N','HOSE PIPE 16572-34061','HOSE PIPE 16572-34061','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320678','N','STANLEY STEEL SINCK','STANLEY STEEL SINCK','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32068','N','WHEEL CYL KIT (CUP KIT) 04906-35130','WHEEL CYL KIT (CUP KIT) 04906-35130','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32070','N','BRAKE SHOE KIT','BRAKE SHOE KIT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32071','N','Lens 81521-60080','Lens 81521-60080','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320712','N','CYLINDER- ASSY-WHEEL','CYLINDER- ASSY-WHEEL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32072','N','CAR RADIO ANTENNA UNIVERSAL RUBBER','CAR RADIO ANTENNA UNIVERSAL RUBBER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32073','N','GASKET EXHAUST PIPE 90917-06059','GASKET EXHAUST PIPE 90917-06059','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3207410','N','CAP SUB ASSY','CAP SUB ASSY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320745','N','BUMPER RUBBER','BUMPER RUBBER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320746','N','GREASE CAP','GREASE CAP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320748','N','BRAKE - ADJUSTER','BRAKE - ADJUSTER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320749','N','ENGINE OIL CUP','ENGINE OIL CUP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32075','N','NUT YA FRONT EXEL HUB','NUT YA FRONT EXEL HUB','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32076','N','Bearing Front Axel Inner (Big)25590-N','Bearing Front Axel Inner (Big)25590-N','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32079','N','Tyres set 18Ply','Tyres set 18Ply','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32080','N','Wheel Bearing 90368-45087','Wheel Bearing 90368-45087','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32081','N','DISTANCE LOCK WASHER','DISTANCE LOCK WASHER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32086','N','HABU','HABU','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32087','N','SHAFT PROPELER -35250','SHAFT PROPELER -35250','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32088','N','SPRING 4Th LEAF REAR','SPRING 4Th LEAF REAR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32089','N','Piston Ring','Piston Ring','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3209','N','LOCK WASHER FRONT HUB','LOCK WASHER FRONT HUB','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32091','N','HOSE FLEXIBLE 96910-34805','HOSE FLEXIBLE 96910-34805','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32094','N','ARM WIPER','ARM WIPER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32097','N','Over Head Gasket 04111-17010','Over Head Gasket 04111-17010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32098','N','Lens L 12V 5W','Lens L 12V 5W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320991','N','VEE BELT 12x1270A-50','VEE BELT 12x1270A-50','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320996','N','FUSE(AMP20)','FUSE(AMP20)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W320998','N','FUSES 7.5A','FUSES 7.5A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321004','N','FRONT SPRING 2ND LEAF','FRONT SPRING 2ND LEAF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321005','N','REAR SPRING 2ND LEAF','REAR SPRING 2ND LEAF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321008','N','Battery Acid','Battery Acid','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32102','N','Stabilizer Link','Stabilizer Link','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321055','N','CAPSUB ASSY 44305-22040','CAPSUB ASSY 44305-22040','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321057','N','MASTER BRAKE KIT 04493-25060','MASTER BRAKE KIT 04493-25060','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32110','N','Side Mirror 87910-90KOO L','Side Mirror 87910-90KOO L','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32111','N','SOLUTION 350G (TIP TOP)','SOLUTION 350G (TIP TOP)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321111','N','SEALED BEAM L/CRUISER 90981-01052','SEALED BEAM L/CRUISER 90981-01052','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321114','N','BULB 12V215W','BULB 12V215W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32113','N','Wheel Bearing RPT 50,82 K','Wheel Bearing RPT 50,82 K','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32114','N','Hub Oil Seal AA 800E','Hub Oil Seal AA 800E','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32119','N','Shakle kit 04481-35040','Shakle kit 04481-35040','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3212','N','WIS BACK DOOR RUBBER','WIS BACK DOOR RUBBER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32121','N','BEARING TOYOTA L/C 90366-17001','BEARING TOYOTA L/C 90366-17001','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32124','N','Seal Kit Suvivol 43204-60020','Seal Kit Suvivol 43204-60020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32125','N','Bulb 12v 5w 99132-12050-76','Bulb 12v 5w 99132-12050-76','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32131','N','Gasket Kit FR AX LE','Gasket Kit FR AX LE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32136','N','Cup Kit Wk 527','Cup Kit Wk 527','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32138','N','Cup Kit 04905-36050','Cup Kit 04905-36050','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32140','N','WATER PUMP 1H2 16100-19235','WATER PUMP 1H2 16100-19235','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32144','N','Centre Bolt','Centre Bolt','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32145','N','Element Kit 04234-68010','Element Kit 04234-68010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321450','E','VIOO VYA GIZA','VIOO VYA GIZA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321451','E','VIOO VYA MWANGA','VIOO VYA MWANGA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3214610','N','GLOW PLUGS RELAY 28610-64110','GLOW PLUGS RELAY 28610-64110','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W321468','N','LENS PARKING 53312 R 7','LENS PARKING 53312 R 7','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32148','N','End Sub Assy Str Rel 45044-69076','End Sub Assy Str Rel 45044-69076','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32150','N','Filter Fuel 23303-56031','Filter Fuel 23303-56031','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32156','N','Lense 81731-14090','Lense 81731-14090','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32157','N','Lense 81621-89111','Lense 81621-89111','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32159','N','Lense 81511-60211','Lense 81511-60211','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32160','N','Lense 81521-90K02','Lense 81521-90K02','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32162','N','Plate 48046-35120','Plate 48046-35120','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32163','N','Plate 4847-35010','Plate 4847-35010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32164','N','Plate 48472-35020','Plate 48472-35020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32167','N','Shackel Pin Complete','Shackel Pin Complete','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32168','N','Stering Damper Rubber 23','Stering Damper Rubber 23','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32169','N','Spring bush','Spring bush','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32174','N','Complete Spring Front','Complete Spring Front','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32175','N','Exhaust Mounting 17567-17010','Exhaust Mounting 17567-17010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32182','N','FUSE AMP 15','FUSE AMP 15','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32183','N','Fuse 10A','Fuse 10A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32184','N','FUSE (AMP20)','FUSE (AMP20)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32186','N','FUSE 10Amp','FUSE 10Amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32187','N','FUSE 15 Amp','FUSE 15 Amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32188','N','FUSE 25Amp','FUSE 25Amp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32189','N','FUSE 7.5A','FUSE 7.5A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32190','N','ELEMENT AIR 17801-31050','ELEMENT AIR 17801-31050','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32193','N','Side Mirror 87910-90k00 L','Side Mirror 87910-90k00 L','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32197','N','Winner safety seal','Winner safety seal','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32198','N','Cup 04475 - 35050','Cup 04475 - 35050','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32200','N','SHOCK ABSORBER 3375','SHOCK ABSORBER 3375','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32201','N','ABSORBER KIT SHOCK 48511-35270','ABSORBER KIT SHOCK 48511-35270','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W322016','N','SWIVAL BEARING 90366-17007 L/C HZJ 75','SWIVAL BEARING 90366-17007 L/C HZJ 75','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W322019','N','CUSHION BUSH LINK STABILIZER L/C HZJ','CUSHION BUSH LINK STABILIZER L/C HZJ','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32204','N','ABSORBER SHOCK KIT 48511-35090','ABSORBER SHOCK KIT 48511-35090','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32209','N','Glow plugs 19850-64031','Glow plugs 19850-64031','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32210','N','Dif oil seal 90311-38047','Dif oil seal 90311-38047','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32212','N','Acid battery gallon','Acid battery gallon','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32213','N','Shim adjust valve 13513-54010','Shim adjust valve 13513-54010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32214','N','Shim adj valve 13513-54110','Shim adj valve 13513-54110','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32215','N','Shim adjust valve 13513-54260','Shim adjust valve 13513-54260','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32216','N','Shim adjust valve 13513-54210','Shim adjust valve 13513-54210','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32217','N','Shim adj valve 13513-54410','Shim adj valve 13513-54410','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W322170','N','SHACKLE PLATE 04483-60060','SHACKLE PLATE 04483-60060','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32218','N','Plate Camshaft 13511-17010','Plate Camshaft 13511-17010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32219','N','Nozzle Pipe 23160-17010','Nozzle Pipe 23160-17010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32220','N','Valley za Magari','Valley za Magari','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32221','N','Bulb Holder','Bulb Holder','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32225','E','Binding Wire (Rolls)','Binding Wire (Rolls)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32226','N','SEAL TYPE OIL 90311-50019','SEAL TYPE OIL 90311-50019','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32228','N','FILTER FF149 MIXER MACHINE','FILTER FF149 MIXER MACHINE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32230','N','Wiper Blade 85212-60031','Wiper Blade 85212-60031','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W322340','N','CABLE A HOOT LOCK','CABLE A HOOT LOCK','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W322343','N','DOOR HANDLE','DOOR HANDLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3224','N','PIN DIFFERENTIAL','PIN DIFFERENTIAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32240','N','BEARING 001 981 7701','BEARING 001 981 7701','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32241','N','WHEEL SPANNER','WHEEL SPANNER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32243','N','WHEEL BOLT 401 0071','WHEEL BOLT 401 0071','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32244','N','INJECTION LINES','INJECTION LINES','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32245','N','BITI YA COMPRESSOR','BITI YA COMPRESSOR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32246','N','OIL SAE 90','OIL SAE 90','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32247','N','BOLT YA LOCK DIFFERENTIVE','BOLT YA LOCK DIFFERENTIVE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32248','N','Ball & Roller Bearing 32213','Ball & Roller Bearing 32213','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32249','N','BALL AND ROLLER BEARING 32210','BALL AND ROLLER BEARING 32210','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32250','N','REAR AXLE OUTER SEAL 40916 MO8-13-03','REAR AXLE OUTER SEAL 40916 MO8-13-03','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32251','N','REAR AXLE INNER SEAL 40918 M08-13-03','REAR AXLE INNER SEAL 40918 M08-13-03','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32253','N','HANGER','HANGER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32254','N','BEARING 6207','BEARING 6207','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32256','N','CABIN ROOF LIGHT','CABIN ROOF LIGHT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32257','N','KICHWA CHA NALI SCANIA','KICHWA CHA NALI SCANIA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32259','N','BULB 24V 21W','BULB 24V 21W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3226','N','SHROUD FAN','SHROUD FAN','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32260','N','VIRAKA 30/3','VIRAKA 30/3','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32261','N','viraka 30/7a','viraka 30/7a','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32264','N','TYRE APPOLO 7.50 X16X 14 PLY','TYRE APPOLO 7.50 X16X 14 PLY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32265','N','GASKET KIT STEERING','GASKET KIT STEERING','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3227','N','PINION OIL SEAL','PINION OIL SEAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32290','N','AXLE STUDY + CONE 90116-08325','AXLE STUDY + CONE 90116-08325','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32299','N','OIL FILTER UNIMOG 3641800109','OIL FILTER UNIMOG 3641800109','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32322','N','GASKET KIT FR 04434-60051','GASKET KIT FR 04434-60051','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32345','N','TARAKOTA-RED CEMENT','TARAKOTA-RED CEMENT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W323451','N','WHITE CEMENT','WHITE CEMENT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3245','N','TYRE LIVERS','TYRE LIVERS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W324510','N','TYRE LIVERS','TYRE LIVERS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32452','N','SWITCH DOOR','SWITCH DOOR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W324550','N','BUSH SUB ASSY','BUSH SUB ASSY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3245515','N','CAPACITORS 10 MF','CAPACITORS 10 MF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32457','N','DIFF OIL SEAL','DIFF OIL SEAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32458','N','HAND BRAKE CABLE','HAND BRAKE CABLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3246','N','STEERING DUMPER 90385-11021','STEERING DUMPER 90385-11021','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32461','N','PINION 41341-25010','PINION 41341-25010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32462','N','SPIDER GEAR DIFF','SPIDER GEAR DIFF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3247','N','STEERING DUMPER 25+31','STEERING DUMPER 25+31','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3248','N','POWER STEERING FLUID','POWER STEERING FLUID','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32510','N','RADIO CALL FTL-2011','RADIO CALL FTL-2011','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32511','N','VERTEX 4CH VX 3000V','VERTEX 4CH VX 3000V','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32531','N','TIMING BELT','TIMING BELT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32532','N','FAN BELT','FAN BELT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32534','N','ANTENA RADIO','ANTENA RADIO','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32535','N','MANN FILTER WK 7231','MANN FILTER WK 7231','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W325355','N','OIL FILTER LF 701','OIL FILTER LF 701','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32537','N','CONNECTING ROD','CONNECTING ROD','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32544','N','Lock assy 69320-90k00','Lock assy 69320-90k00','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W325454','N','BUSH SUB ASSY LWR','BUSH SUB ASSY LWR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32546','N','COMPLETE SPRING (Rear Spring Assy L\C','COMPLETE SPRING (Rear Spring Assy L\C','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32548','N','BEARING RTP 90368-50024','BEARING RTP 90368-50024','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32551','N','BEARING 903366-30038','BEARING 903366-30038','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32552','N','BEARING BALL 90099-10192','BEARING BALL 90099-10192','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32554','N','BEARING KIT 04371-35051','BEARING KIT 04371-35051','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32555','N','BUSH SUB ASSY 48702-60050','BUSH SUB ASSY 48702-60050','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32556','N','Bulb 12v 21w','Bulb 12v 21w','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W325560','N','Bush assy lwb 48061-60010','Bush assy lwb 48061-60010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32557','N','Element assy fuel filter 23390-64480','Element assy fuel filter 23390-64480','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32558','N','End sub assy steering realay rod 45045-','End sub assy steering realay rod 45045-','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32562','N','HANDLE DOOR 69206-10040-33','HANDLE DOOR 69206-10040-33','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32563','N','HANDLE LOCK 69220-90K00','HANDLE LOCK 69220-90K00','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32566','N','SIDE MIRROR R','SIDE MIRROR R','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32567','N','U-BOLT 90117-14052','U-BOLT 90117-14052','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32576','N','CABLE 25M','CABLE 25M','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32577','N','CABLE 35M','CABLE 35M','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32578','N','CABLE 30M','CABLE 30M','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32579','N','CABLE 95M','CABLE 95M','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32580','N','BULB 32W','BULB 32W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32581','N','BULB 15W','BULB 15W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W325810','N','PISTON KIT BRAKE 04493-35150','PISTON KIT BRAKE 04493-35150','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W325811','N','MASTER BRAKE CYLINDER ASSY','MASTER BRAKE CYLINDER ASSY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32582','N','END SUB ASSY STR','END SUB ASSY STR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32587','N','BULB 12V 21/5W','BULB 12V 21/5W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32588','N','BULB NO.67','BULB NO.67','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W326401','N','PAD KIT DISK BRAKE 04465-YZZ57','PAD KIT DISK BRAKE 04465-YZZ57','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32641','N','WHEEL STUD BOLT 90942-02053','WHEEL STUD BOLT 90942-02053','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32642','N','WHEEL STUDY+NUT YA NYUMA 90942-01101','WHEEL STUDY+NUT YA NYUMA 90942-01101','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32655','N','HEATER SHOWER REU 58 E','HEATER SHOWER REU 58 E','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3287','N','THERMOSTAT 90916-03089','THERMOSTAT 90916-03089','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32883','N','STEERING DAMPER RUBBER(STABILIZER)','STEERING DAMPER RUBBER(STABILIZER)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32887','N','BELT 99332-11260-83','BELT 99332-11260-83','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32891','N','HORN 86510-22091','HORN 86510-22091','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32892','N','COVER SUB-ASSY 43509-60051','COVER SUB-ASSY 43509-60051','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32989','N','BULB-24V','BULB-24V','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32991','N','C0N-SPRING-BUSH','C0N-SPRING-BUSH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32992','N','SPRING-BUSHES','SPRING-BUSHES','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W32999','N','LOCK WASHER FR HUB','LOCK WASHER FR HUB','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W329991','N','DOOR REGULA 698220-6009','DOOR REGULA 698220-6009','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W329993','N','COIL SPRING BUMPER 48302-60010','COIL SPRING BUMPER 48302-60010','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W329994','N','WAIPER ARM 85211-60080','WAIPER ARM 85211-60080','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W329996','N','SHAFT ASSY 32140-60170','SHAFT ASSY 32140-60170','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W329997','N','FUSES 15 AMP','FUSES 15 AMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3300','N','MEMO (RADIO CALL)','MEMO (RADIO CALL)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W330001','N','HOSE CLAMP','HOSE CLAMP','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W330002','N','FUEL FILTER','FUEL FILTER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3300066','N','Seal Type Oil','Seal Type Oil','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3300067','N','Oil Seal 90311-3804','Oil Seal 90311-3804','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W330008','N','LINNING BREAK FRONT','LINNING BREAK FRONT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33001','N','Battery N 50','Battery N 50','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W330010','N','FUEL FILERT 1372444','FUEL FILERT 1372444','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W330013','N','FUEL FILERT 364 624','FUEL FILERT 364 624','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33004','N','Battery Terminal','Battery Terminal','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W330042','N','JACK 1TNS','JACK 1TNS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33005','E','WRITO LAMI','WRITO LAMI','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33006','N','GASKET PAPER','GASKET PAPER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33007','N','Hose Clamp','Hose Clamp','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33008','N','Battery N120','Battery N120','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33009','N','BATTERY CHAGER ALP16','BATTERY CHAGER ALP16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33011','N','OIL FILTER 117285','OIL FILTER 117285','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33015','N','TYRE 825-10 14 PLY','TYRE 825-10 14 PLY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33019','N','Bearing 30307JR','Bearing 30307JR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33020','N','Pinion 028371-1410','Pinion 028371-1410','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33021','N','Brake Repair Kit 04493-60140','Brake Repair Kit 04493-60140','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33022','N','Fuel Tank cap','Fuel Tank cap','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33023','N','Seal Type Oil','Seal Type Oil','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33040','N','V -Belt 90916-024452','V -Belt 90916-024452','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W330411','N','COMPRESSOR REPAIR KIT +RING','COMPRESSOR REPAIR KIT +RING','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33043','Q','Spring Bush Front Scania','Spring Bush Front Scania','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33044','F','Main Switch 30 Amps','Main Switch 30 Amps','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33045','R','Power Steering Fluid Cap','Power Steering Fluid Cap','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33051','Q','AIR FILTER 3326728','AIR FILTER 3326728','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33054','Q','Rear Main Leav For Scania 112E','Rear Main Leav For Scania 112E','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33058','Q','SPRING 90506-26011','SPRING 90506-26011','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33059','Q','VALVE GUIDE','VALVE GUIDE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33061','Q','Valug Steam tr48 (Nali ya tube)','Valug Steam tr48 (Nali ya tube)','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33062','F','Fuse 16A','Fuse 16A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33063','F','Fuse 8A','Fuse 8A','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33064','R','Grease L 21 M','Grease L 21 M','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33065','N','WHEEL CYLINDER ASS 47550-60120','WHEEL CYLINDER ASS 47550-60120','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33067','N','BULB 99132-12100','BULB 99132-12100','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33068','N','OIL SEAL 90311-48009','OIL SEAL 90311-48009','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33069','N','IDLER SUB ASS 13505-17011','IDLER SUB ASS 13505-17011','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33070','N','REGULATOR HANDLE WINDING MACHINE 69820-9','REGULATOR HANDLE WINDING MACHINE 69820-9','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33071','N','REGULATOR HANDLE WINDING MACHINE 69810-9','REGULATOR HANDLE WINDING MACHINE 69810-9','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33072','N','SPRING 47449-30020','SPRING 47449-30020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33074','N','CUP FOR LINING BRAKE LOCK 90501-20012','CUP FOR LINING BRAKE LOCK 90501-20012','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33075','N','PIN FOR LINING BRAKE 47449-30020','PIN FOR LINING BRAKE 47449-30020','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33077','N','BOGGIE CON FOR SCANIA 112E','BOGGIE CON FOR SCANIA 112E','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33082','N','HUB ASS FREE WHEEL 43530-60042','HUB ASS FREE WHEEL 43530-60042','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33085','N','VALV ADJUSTING SHIMS 13753-54420','VALV ADJUSTING SHIMS 13753-54420','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33086','N','VALVE ADJUSTING SHIMS 13753-54430','VALVE ADJUSTING SHIMS 13753-54430','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33087','N','BOGGIE SEAL FOR SCANIA 112E','BOGGIE SEAL FOR SCANIA 112E','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33089','N','HYDROULICK OIL NO 32','HYDROULICK OIL NO 32','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33090','N','HYDROULICK OIL HLP NO 68','HYDROULICK OIL HLP NO 68','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33091','N','STEERING DAMPER ASS 45700-60022','STEERING DAMPER ASS 45700-60022','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33092','N','BATTERY N 120','BATTERY N 120','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33094','N','BATTERY CHARGER ALP 16','BATTERY CHARGER ALP 16','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33096','I','BOLT + NUT','BOLT + NUT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33100','N','CON ROD BUSH','CON ROD BUSH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33102','N','FRONT MAIN LEAF','FRONT MAIN LEAF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W332211','N','SHOCK ABSORBER FR -1420474','SHOCK ABSORBER FR -1420474','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W332212','N','NUT -TANDEM BALANCE 1387576','NUT -TANDEM BALANCE 1387576','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W332213','N','STUD- 1408338','STUD- 1408338','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33230','N','PINION OIL SEAL','PINION OIL SEAL','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33239','R','COMET GREASE','COMET GREASE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3330010','N','BEARING 31230-60130','BEARING 31230-60130','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33334','N','TYRES 7.50 X16 12 PLY','TYRES 7.50 X16 12 PLY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W3334','N','REMS FRONT','REMS FRONT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33451','N','Pad kit disk brake 04465-60170','Pad kit disk brake 04465-60170','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33452','U','FIRE EXTINGUISHER','FIRE EXTINGUISHER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33453','U','FIRE EXTINGUISHER','FIRE EXTINGUISHER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33454','U','FIRE EXTINGUISHER','FIRE EXTINGUISHER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33455','N','REPAIR -KIT GOVERNOR','REPAIR -KIT GOVERNOR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W334551','N','BALL JOINT','BALL JOINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W334552','N','BALL JOINT','BALL JOINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33547','N','FOOT PUMP E 35','FOOT PUMP E 35','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33550','N','BULB 12V 7.5W','BULB 12V 7.5W','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33551','N','BUSH 90385-13009','BUSH 90385-13009','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33552','H','PLANE BLADE','PLANE BLADE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33554','N','WHEEL TYRES','WHEEL TYRES','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33557','F','HOSE CLIPS','HOSE CLIPS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33558','F','HOSE CLIPS 5/8 -7/8 -16-22','HOSE CLIPS 5/8 -7/8 -16-22','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33559','H','WALL PUNCH','WALL PUNCH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33988','N','WASHER DIFF 41361-40021','WASHER DIFF 41361-40021','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33990','N','SIDE BEARING 17887','SIDE BEARING 17887','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33991','N','BEARING 90396','BEARING 90396','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W339912','N','CROWN WHEEL+PINION 41201-69356-90','CROWN WHEEL+PINION 41201-69356-90','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33992','G','BRUSHES','BRUSHES','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33994','N','SHAFT PINION','SHAFT PINION','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33996','N','HAND BRAKE CABLE','HAND BRAKE CABLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W33998','N','WASHER DIFF','WASHER DIFF','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W34001','N','Wall Roofing Fell','Wall Roofing Fell','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W34003','N','CHANGE OVER SWITCH','CHANGE OVER SWITCH','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W34004','N','BRAKE BOASTER HJ 75','BRAKE BOASTER HJ 75','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W34990','N','DIFF PIN BOLT','DIFF PIN BOLT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W34991','N','SLIDING WINDOW MIRROR','SLIDING WINDOW MIRROR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W34996','N','SHAFT ASSY','SHAFT ASSY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40001','N','KENRICK BRAND NO 54','KENRICK BRAND NO 54','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40002','L','CASTER BRAND 50MM 2"','CASTER BRAND 50MM 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40003','L','GURUDUMU NDOGO P/N 21.788','GURUDUMU NDOGO P/N 21.788','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40005','L','TRIANGLE BRAND 200/50-100','TRIANGLE BRAND 200/50-100','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40009','H','Serafric Pattex','Serafric Pattex','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40010','L','TWIN WHEEL CASTROS','TWIN WHEEL CASTROS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40011','L','WAGNER 231122 02','WAGNER 231122 02','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40012','L','GLASS FOR WELDING','GLASS FOR WELDING','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40013','I','HALMENT FOR WELDING','HALMENT FOR WELDING','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40014','H','HAMMER','HAMMER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40015','H','THOOR HAMMER','THOOR HAMMER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40016','H','SCREW DRIVER','SCREW DRIVER','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40017','H','CHIESEL (PATASI) 1/2','CHIESEL (PATASI) 1/2','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40018','I','UK PATENT 242802','UK PATENT 242802','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40019','I','LOCTITE','LOCTITE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40022','H','Simba Patex','Simba Patex','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40025','L','WHEEL RUBBER 125-37-50','WHEEL RUBBER 125-37-50','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40028','L','Twin Wheel Castros','Twin Wheel Castros','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40029','L','WHEELS 75mm (3")','WHEELS 75mm (3")','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40045','L','CHISEL (PATASI)1"','CHISEL (PATASI)1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W40063','L','WHEEL 100X32','WHEEL 100X32','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W410001','I','SERAFRIC PATTEX','SERAFRIC PATTEX','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W410004','I','SIMBA PATEX 4LT','SIMBA PATEX 4LT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W4433','N','HOSE PIPE','HOSE PIPE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50001','G','BRUSH 1"','BRUSH 1"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50002','G','BRUSH 2"','BRUSH 2"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50004','G','BRUSH 4"','BRUSH 4"','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W500056','G','BLACK OIL PAINT','BLACK OIL PAINT','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50009','G','SMALL HANDLE','SMALL HANDLE','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50010','G','BRUSH ROLLAR','BRUSH ROLLAR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50011','G','BRUSH ROLLAR','BRUSH ROLLAR','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50012','G','TRAY','TRAY','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50014','M','ACTELIC SUPER MAJI','ACTELIC SUPER MAJI','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W50054','H','FOMAICA','FOMAICA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W52251','H','STEEL CONCRETE NAILS','STEEL CONCRETE NAILS','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);
INSERT INTO stockmaster VALUES('W54545','I','STIKI YA SHABA','STIKI YA SHABA','each','F','1800-01-01',0.0,0.0,0.0,0.0,0.0,0,0,0,0,0.0,0.0,'','',1,0,'none',0,0);

--
-- Dumping data for table `locstock`
--

INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R214410' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F752100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F752101' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D431000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F711201' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B241000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721500' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721510' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721520' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721530' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R213100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'V251320' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'V251321' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'V241111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731220' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731221' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731211' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M156200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M156100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'Q202220' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721600' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721610' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B211000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'X271300' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K133110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R215100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A131100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F735200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'V242211' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731121' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L142710' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R212100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M154210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R221110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A121000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A121100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'X272310' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K133610' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'E610000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'P182100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F732310' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F732330' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F732331' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'P196212' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M151210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D412101' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F738100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F738110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R211100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R211110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R211111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F738111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D412100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D412110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'V242110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'V242112' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'N162110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F737100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R211170' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F737110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L143200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L143210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731232' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731230' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731231' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F736100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F736110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'W252220' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R215200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'G811300' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R212212' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R212210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R212211' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R212200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D421000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D421100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A133100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A133110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B231200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K132210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721120' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R222210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'W251130' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R222211' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'U231100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'C313100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F735100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F735110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731120' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'H101100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'H101110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'H101111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F742000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F742001' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'V242120' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'H102100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K134220' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K134422' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R211130' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F734200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'N162120' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F744000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'V242210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A112300' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'J111110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K133420' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K133421' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K134120' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R212300' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D422000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L142700' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M152400' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M152410' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B231300' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B231400' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'P182200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'N161100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'N161210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K131130' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A111200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A122000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A122100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A122101' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M155210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'U232300' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M151110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M151111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F711200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'N162210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R214111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K133310' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M153500' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F722200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F722210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F722220' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'X271700' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A143100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F711300' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K131320' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K131321' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F739200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'P196211' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F747000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F747001' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M155100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M151310' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'U231200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A142400' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B212000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B212100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B224000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'E660000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'E661000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'E670000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R212213' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R214110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R223150' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F711400' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D423000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D412200' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'D412210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K131220' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F721111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'M151240' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731160' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731161' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731162' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'W251110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'W251111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L144320' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L141140' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R212500' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'X272311' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'K135320' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F731180' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A141100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'Q202221' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F733100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R211160' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A111400' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L141110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'P181100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R214210' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'F722400' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B225001' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'B225000' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'P196213' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L141151' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'X271100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'X271250' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'X271251' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'H102300' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'J112100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'S140001' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'L143100' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A122110' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'A122111' FROM locations;
INSERT INTO locstock (loccode,stockid) SELECT locations.loccode,'R222220' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'B00002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'B00003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'B00004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'B0001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BG0001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BG0002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BG0003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BG0004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BG0005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BG0006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN00010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN00011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BN0009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00017' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS00021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'BS0009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'D00001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'D00002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DDP011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DIS001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DIS002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DIS003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DIS004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'DIS005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'E00009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'IV0011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00017' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00027' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00030' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00033' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00038' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00039' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00041' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00044' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00046' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00047' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00048' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'L00049' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'SC0017' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00017' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00024' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00027' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00030' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00033' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'T00038' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'X00001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'X00002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'X00003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'X00004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'X00005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'X00006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'X00007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0017' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0024' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0027' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0030' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0033' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0038' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0039' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0041' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0057' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0044' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0046' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0047' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0048' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0049' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0050' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0052' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0053' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0054' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0055' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'ST0056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'F00001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'F00002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'F00003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'F00004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'F00005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00124' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00125' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00126' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00127' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00128' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00129' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00200' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00201' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00202' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00206' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00209' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00223' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00225' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0027' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W003099' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W00500' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01203' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01212' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01213' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01230' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01231' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01235' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01236' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01237' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01244' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01245' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01249' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W01250' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020044' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020046' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020087' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020088' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020124' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020141' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020143' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020144' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02017' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020231' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02024' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0202401' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020241' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02030' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020314' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02033' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020351' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020352' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02038' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020381' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020391' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020392' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020393' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020401' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020402' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02041' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02044' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020441' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020442' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020443' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020456' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02046' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02047' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02048' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02049' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02050' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02052' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020522' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02053' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020530' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020531' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020532' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02054' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02055' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020551' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020561' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02057' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02058' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02060' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020611' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02062' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020631' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020633' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02064' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02065' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020651' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02067' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020670' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020672' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0206721' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02069' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02070' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02071' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W020731' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02074' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02080' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02081' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02082' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02083' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02084' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02088' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02089' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02091' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02094' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02095' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02096' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W021010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W021011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W021012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W021013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02103' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02104' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02105' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02106' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02107' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02108' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02111' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02112' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02113' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02115' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02118' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02120' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02121' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02122' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02123' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02124' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02126' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02127' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02128' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02130' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02131' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02132' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02133' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02134' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02137' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02138' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02139' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02144' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02145' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02147' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02148' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02149' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02151' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02152' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02153' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02154' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02156' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02158' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02161' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02162' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02163' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02165' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02166' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02167' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02169' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02171' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02173' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02176' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02179' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02180' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02181' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02182' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02183' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02185' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02188' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02189' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02190' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02191' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02192' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02255' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02294' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02296' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02303' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02304' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02305' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02310' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02331' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0251' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0252' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02548' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0255' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02558' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02559' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02560' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02570' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02573' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02574' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02583' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02584' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02586' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02587' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02588' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02589' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W025890' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W025893' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02590' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02592' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02596' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02597' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0266' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0267' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02670' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02671' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02672' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02673' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02674' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02676' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02677' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02678' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02679' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0268' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02681' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02682' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02683' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02684' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02685' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02686' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02687' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02689' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0269' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0275' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02755' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02757' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02894' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02895' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02896' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02897' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02958' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02984' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02988' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W02992' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030000' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030050' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030052' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030054' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030055' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030060' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030071' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030132' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030142' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030201' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030212' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030213' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030221' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030225' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030226' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030271' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030376' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03039' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03041' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030411' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030412' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030415' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030421' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030424' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0304241' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0304242' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0304243' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0304244' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030425' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030426' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030443' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03047' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03048' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03049' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03050' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03053' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03055' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03058' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03062' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03065' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03066' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03067' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03071' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03072' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03074' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03075' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03076' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03077' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03082' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03083' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03084' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03085' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03086' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03087' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03088' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03089' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03090' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03092' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03093' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03094' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03095' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03096' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030968' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W030969' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03099' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0309911' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03101' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03102' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03103' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03106' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03107' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03108' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03109' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03112' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03113' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03116' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03118' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03124' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03131' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0315' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03188' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03189' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03190' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03191' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03192' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03193' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03194' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03195' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03196' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0320' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03200' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03201' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03203' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03204' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03205' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03208' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03209' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0321' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0322' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03250' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03251' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03252' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03253' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03255' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03258' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03259' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0326' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03260' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0327' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0328' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03294' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03295' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03296' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0330' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0331' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03318' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0332' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03334' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03335' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03336' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03337' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03354' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03421' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03427' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03429' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03435' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03437' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03462' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03464' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03465' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03885' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03886' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03887' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03888' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03889' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03890' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03893' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03896' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W03897' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04030' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04033' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04038' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04039' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04041' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04099' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W041000' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W041001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W041002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04115' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04651' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W04652' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050010,' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0501008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050111' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0501120' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050114' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050119' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050170' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W050231' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05024' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05050' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05053' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05057' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05058' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05079' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05082' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05098' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05099' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05124' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05147' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05148' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05149' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05150' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05151' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05152' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05330' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05331' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05332' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05333' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05334' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05335' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05555' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05556' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05898' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W05899' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W06007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W060071' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W06008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W06009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W06010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W060101' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W060102' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W06011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W06014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W06015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W070011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W070101' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07024' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07030' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07033' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07038' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07039' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07041' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07044' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07046' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07047' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07048' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07049' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07052' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07054' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07057' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07058' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07060' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07062' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07064' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07065' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07066' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07067' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07070' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07071' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W07099' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W0801' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W100011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W100051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W100223' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10030' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10039' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W102012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W10202' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110041' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110076' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110081' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11024' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11027' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110360' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110361' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110504' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110506' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11068' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11072' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11073' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110740' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110741' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W110742' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11076' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11077' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11078' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11080' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11081' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11084' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11088' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11089' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11090' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11093' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11094' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11096' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W11097' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W120101' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W120334' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12034' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12039' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12048' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12050' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12052' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12053' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12054' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12055' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12057' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12058' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12060' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12062' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12064' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12067' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12072' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12074' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12154' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12156' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12158' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12160' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12161' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12162' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12164' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12335' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W12337' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W1345' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W2001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W2002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20044' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W200450' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W200451' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20046' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20049' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W2005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20050' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20053' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W200541' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W200542' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W200543' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W200544' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W200545' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W200556' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20057' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20060' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20062' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20064' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20067' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20068' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20069' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W2007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20070' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20071' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20076' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20078' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20079' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20087' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20088' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20091' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20093' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20094' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20095' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20096' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20097' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20098' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20099' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20105' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20106' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20107' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W2018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W2019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W2020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20201' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W20202' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W2027' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W235410' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28000' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W280010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28101' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28102' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28103' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28104' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28105' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28107' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28108' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28109' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28110' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28210' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28213' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28214' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28216' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28217' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W282230' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28229' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28538' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28539' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28542' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28543' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28546' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W28547' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W30002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W30013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W30016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W302107' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W304510' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W30456' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W30457' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W30458' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W30459' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3086' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3087' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3088' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3089' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W31043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32000' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3200010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3200011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3200013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3200100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320010013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320010014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320010015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320010018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32001007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32001008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3200262' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3201000' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3201001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3201002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3201005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32010051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3201007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3201008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320101' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320103' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320105' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3201052' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3201053' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320106' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320111' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320112' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320123' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320134' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320141' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320145' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320231' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32024' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320241' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320245' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32026' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320262' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320263' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32027' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32031' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32032' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32035' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32036' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320365' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32037' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320374' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320377' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32038' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32039' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32041' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320422' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320423' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320424' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320425' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320426' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320441' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320442' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320443' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32046' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32047' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32048' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32049' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320491' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32050' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320501' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320512' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320513' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32053' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32055' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32057' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320571' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32058' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320591' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32064' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32065' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320650' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320651' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320678' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32068' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32070' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32071' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320712' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32072' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32073' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3207410' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320745' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320746' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320748' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320749' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32075' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32076' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32079' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32080' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32081' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32086' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32087' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32088' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32089' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3209' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32091' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32094' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32097' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32098' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320991' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320996' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W320998' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32102' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321055' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321057' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32110' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32111' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321111' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321114' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32113' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32114' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32119' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3212' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32121' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32124' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32125' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32131' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32136' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32138' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32140' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32144' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32145' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321450' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321451' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3214610' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W321468' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32148' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32150' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32156' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32157' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32159' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32160' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32162' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32163' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32164' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32167' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32168' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32169' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32174' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32175' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32182' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32183' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32184' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32186' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32187' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32188' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32189' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32190' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32193' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32197' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32198' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32200' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32201' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W322016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W322019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32204' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32209' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32210' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32212' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32213' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32214' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32215' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32216' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32217' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W322170' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32218' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32219' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32220' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32221' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32225' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32226' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32228' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32230' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W322340' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W322343' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3224' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32240' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32241' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32243' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32244' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32245' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32246' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32247' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32248' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32249' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32250' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32251' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32253' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32254' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32256' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32257' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32259' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3226' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32260' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32261' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32264' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32265' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3227' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32290' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32299' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32322' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32345' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W323451' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3245' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W324510' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32452' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W324550' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3245515' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32457' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32458' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3246' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32461' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32462' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3247' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3248' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32510' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32511' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32531' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32532' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32534' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32535' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W325355' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32537' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32544' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W325454' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32546' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32548' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32551' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32552' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32554' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32555' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32556' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W325560' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32557' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32558' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32562' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32563' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32566' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32567' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32576' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32577' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32578' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32579' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32580' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32581' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W325810' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W325811' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32582' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32587' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32588' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W326401' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32641' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32642' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32655' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3287' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32883' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32887' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32891' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32892' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32989' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32991' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32992' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W32999' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W329991' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W329993' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W329994' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W329996' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W329997' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3300' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W330001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W330002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3300066' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3300067' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W330008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W330010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W330013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W330042' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33006' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33007' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33008' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33020' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33021' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33023' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33040' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W330411' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33043' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33044' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33051' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33054' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33058' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33059' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33061' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33062' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33064' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33065' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33067' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33068' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33069' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33070' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33071' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33072' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33074' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33075' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33077' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33082' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33085' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33086' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33087' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33089' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33090' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33091' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33092' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33094' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33096' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33100' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33102' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W332211' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W332212' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W332213' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33230' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33239' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3330010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33334' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W3334' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33451' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33452' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33453' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33454' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33455' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W334551' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W334552' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33547' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33550' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33551' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33552' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33554' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33557' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33558' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33559' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33988' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33990' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33991' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W339912' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33992' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33994' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33996' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W33998' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W34001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W34003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W34004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W34990' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W34991' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W34996' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40003' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40005' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40013' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40015' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40016' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40017' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40018' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40019' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40022' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40025' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40028' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40029' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40045' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W40063' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W410001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W410004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W4433' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50001' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50002' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50004' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W500056' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50009' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50010' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50011' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50012' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50014' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W50054' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W52251' FROM locations;
INSERT INTO locstock (loccode,stockid)   SELECT locations.loccode,'W54545' FROM locations;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` VALUES (NULL,'ADMIN' );
INSERT INTO `tags` VALUES (NULL,'CASUALTY' );
INSERT INTO `tags` VALUES (NULL,'FACILITIES' );
INSERT INTO `tags` VALUES (NULL,'FOOD SVC' );
INSERT INTO `tags` VALUES (NULL,'HOUSEKEEPING' );
INSERT INTO `tags` VALUES (NULL,'HR' );
INSERT INTO `tags` VALUES (NULL,'INTERNS' );
INSERT INTO `tags` VALUES (NULL,'IT' );
INSERT INTO `tags` VALUES (NULL,'LAB' );
INSERT INTO `tags` VALUES (NULL,'LINEN' );
INSERT INTO `tags` VALUES (NULL,'MAT MNGT' );
INSERT INTO `tags` VALUES (NULL,'MED STAFF' );
INSERT INTO `tags` VALUES (NULL,'MEDICAL RECORDS' );
INSERT INTO `tags` VALUES (NULL,'NURSING SCVC' );
INSERT INTO `tags` VALUES (NULL,'PATIENT FINANCIAL SERVICES ' );
INSERT INTO `tags` VALUES (NULL,'PHARMACY' );
INSERT INTO `tags` VALUES (NULL,'PROJECT' );
INSERT INTO `tags` VALUES (NULL,'USAID  PROJECT' );

--
-- Dumping data for table `paymentmethods`
--

INSERT INTO `paymentmethods` VALUES (1,'Cheque',1,1);
INSERT INTO `paymentmethods` VALUES (2,'Cash',1,1);
INSERT INTO `paymentmethods` VALUES (3,'Direct Credit',1,1);

--
-- Dumping data for table `securitygroups`
--

INSERT INTO `securitygroups` VALUES (1,1);
INSERT INTO `securitygroups` VALUES (1,2);
INSERT INTO `securitygroups` VALUES (2,1);
INSERT INTO `securitygroups` VALUES (2,2);
INSERT INTO `securitygroups` VALUES (2,11);
INSERT INTO `securitygroups` VALUES (3,1);
INSERT INTO `securitygroups` VALUES (3,2);
INSERT INTO `securitygroups` VALUES (3,3);
INSERT INTO `securitygroups` VALUES (3,4);
INSERT INTO `securitygroups` VALUES (3,5);
INSERT INTO `securitygroups` VALUES (3,11);
INSERT INTO `securitygroups` VALUES (4,1);
INSERT INTO `securitygroups` VALUES (4,2);
INSERT INTO `securitygroups` VALUES (4,5);
INSERT INTO `securitygroups` VALUES (5,1);
INSERT INTO `securitygroups` VALUES (5,2);
INSERT INTO `securitygroups` VALUES (5,3);
INSERT INTO `securitygroups` VALUES (5,11);
INSERT INTO `securitygroups` VALUES (6,1);
INSERT INTO `securitygroups` VALUES (6,2);
INSERT INTO `securitygroups` VALUES (6,3);
INSERT INTO `securitygroups` VALUES (6,4);
INSERT INTO `securitygroups` VALUES (6,5);
INSERT INTO `securitygroups` VALUES (6,6);
INSERT INTO `securitygroups` VALUES (6,7);
INSERT INTO `securitygroups` VALUES (6,8);
INSERT INTO `securitygroups` VALUES (6,9);
INSERT INTO `securitygroups` VALUES (6,10);
INSERT INTO `securitygroups` VALUES (6,11);
INSERT INTO `securitygroups` VALUES (7,1);
INSERT INTO `securitygroups` VALUES (8,1);
INSERT INTO `securitygroups` VALUES (8,2);
INSERT INTO `securitygroups` VALUES (8,3);
INSERT INTO `securitygroups` VALUES (8,4);
INSERT INTO `securitygroups` VALUES (8,5);
INSERT INTO `securitygroups` VALUES (8,6);
INSERT INTO `securitygroups` VALUES (8,7);
INSERT INTO `securitygroups` VALUES (8,8);
INSERT INTO `securitygroups` VALUES (8,9);
INSERT INTO `securitygroups` VALUES (8,10);
INSERT INTO `securitygroups` VALUES (8,11);
INSERT INTO `securitygroups` VALUES (8,12);
INSERT INTO `securitygroups` VALUES (8,13);
INSERT INTO `securitygroups` VALUES (8,14);
INSERT INTO `securitygroups` VALUES (8,15);

--
-- Dumping data for table `securitytokens`
--

INSERT INTO `securitytokens` VALUES (1,'Order Entry/Inquiries customer access only');
INSERT INTO `securitytokens` VALUES (2,'Basic Reports and Inquiries with selection options');
INSERT INTO `securitytokens` VALUES (3,'Credit notes and AR management');
INSERT INTO `securitytokens` VALUES (4,'Purchasing data/PO Entry/Reorder Levels');
INSERT INTO `securitytokens` VALUES (5,'Accounts Payable');
INSERT INTO `securitytokens` VALUES (6,'Not Used');
INSERT INTO `securitytokens` VALUES (7,'Bank Reconciliations');
INSERT INTO `securitytokens` VALUES (8,'General ledger reports/inquiries');
INSERT INTO `securitytokens` VALUES (9,'Not Used');
INSERT INTO `securitytokens` VALUES (10,'General Ledger Maintenance, stock valuation & Configuration');
INSERT INTO `securitytokens` VALUES (11,'Inventory Management and Pricing');
INSERT INTO `securitytokens` VALUES (12,'Unknown');
INSERT INTO `securitytokens` VALUES (13,'Unknown');
INSERT INTO `securitytokens` VALUES (14,'Unknown');
INSERT INTO `securitytokens` VALUES (15,'User Management and System Administration');

--
-- Dumping data for table `securityroles`
--

INSERT INTO `securityroles` VALUES (1,'Inquiries/Order Entry');
INSERT INTO `securityroles` VALUES (2,'Manufac/Stock Admin');
INSERT INTO `securityroles` VALUES (3,'Purchasing Officer');
INSERT INTO `securityroles` VALUES (4,'AP Clerk');
INSERT INTO `securityroles` VALUES (5,'AR Clerk');
INSERT INTO `securityroles` VALUES (6,'Accountant');
INSERT INTO `securityroles` VALUES (7,'Customer Log On Only');
INSERT INTO `securityroles` VALUES (8,'System Administrator');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

SET FOREIGN_KEY_CHECKS = 1;
UPDATE systypes SET typeno=0;
INSERT INTO shippers VALUES (1,'Default Shipper',0);
UPDATE config SET confvalue='1' WHERE confname='Default_Shipper';
