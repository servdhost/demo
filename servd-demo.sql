-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: database    Database: project
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-1:10.3.22+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `trackChanges` tinyint(1) NOT NULL DEFAULT 0,
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-15 10:41:54
-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: database    Database: project
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-1:10.3.22+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2019-12-12 16:33:48','2019-12-12 16:33:48','b38dbc26-f5a7-477e-b8dd-6c8d7bdee102'),(2,2,1,'Home','2019-12-12 16:34:11','2020-06-15 10:41:39','f6b1d7f2-c815-456b-82bc-9098456e3ec0');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-12-12 16:33:48','2019-12-12 16:33:48',NULL,'fcd5df6f-233c-47c7-9843-c62649cc18d5'),(2,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-12-12 16:34:11','2020-06-15 10:41:39',NULL,'1e457b34-c376-4779-8074-954dbe74ebd7');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-12-12 16:33:48','2019-12-12 16:33:48','2819b0aa-8cc8-4a70-96a8-5750f464529b'),(2,2,1,'home','__home__',1,'2019-12-12 16:34:11','2019-12-12 16:34:11','3a2fb5ec-0dda-465a-ab62-9bfbb65492b1');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,1,NULL,1,NULL,'2019-12-12 16:34:00',NULL,NULL,'2019-12-12 16:34:11','2019-12-12 16:34:11','da7a5cb2-f182-4718-92cb-f652988545ab');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,NULL,'Home','home',0,NULL,'{section.name|raw}',1,'2019-12-12 16:34:11','2019-12-12 16:34:11',NULL,'eff33001-900c-4d66-8603-109687a40252');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2019-12-12 16:33:48','2019-12-12 16:33:48','41f0085a-91c4-4de0-8a54-a5d6419bb7a8');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.4.23','3.4.10',0,'{\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\",\"sections\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"volumes\":\"@config/project.yaml\",\"graphql\":\"@config/project.yaml\"}','wNTz3Fy4snZ6','2019-12-12 16:33:48','2020-06-15 10:41:41','7b9bad88-4b94-4983-80f2-bbc38517dde4');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','b0787bdd-e1a0-4b64-9195-67abf1e81717'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','5087af47-8040-482c-a165-a5aff96d42e6'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','646b9877-55ec-4d31-bc21-2be7a827a858'),(4,NULL,'app','m150403_184533_field_version','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','5060a644-8f0f-449e-b801-3891e09e793c'),(5,NULL,'app','m150403_184729_type_columns','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','546b9a5c-fa91-46fc-ad35-539ee2622500'),(6,NULL,'app','m150403_185142_volumes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','3b4692a8-9ffc-4bdf-8fe9-d376d95b3997'),(7,NULL,'app','m150428_231346_userpreferences','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','0471e1ba-d19e-4ea5-884c-af9b1cbd23b7'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','80a19ff8-dabd-4e9d-93e5-d50cf65d5fb6'),(9,NULL,'app','m150617_213829_update_email_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','5882beb0-9c21-41ec-91fd-17a6699845bc'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','5127cfd0-dcb6-4c71-ba27-8b1d8530c823'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','b4460468-837d-41c5-a047-3e02abbf202e'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','713a75ae-9871-4e67-b8e2-126e5af8b68a'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','c76dc993-f9ad-4553-9344-cce734ba593f'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','baca633a-8e67-4955-8d3b-e78f90ffb44c'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','3fe3bbb7-8829-4d8f-9955-04f4da944885'),(16,NULL,'app','m151209_000000_move_logo','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','a8f45131-dd52-43fc-a70d-26dd198a2e0a'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','fc0a1de3-3a44-4d09-b34b-3d7b1ec0674a'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','62b13b90-a677-4f56-9e6f-4a23555566f4'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e15fc4eb-c6f4-4de3-b7aa-ef24dd72c682'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','93ca17bf-377d-4b3c-9aa1-5228e6051b37'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','06b8c27c-315e-4a73-a805-c687de404340'),(22,NULL,'app','m160727_194637_column_cleanup','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','bb53fe9a-c4c1-4288-a05a-0f15d957c592'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','6ef9190a-1c14-499a-b08c-518cae0cf85d'),(24,NULL,'app','m160807_144858_sites','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','218f76cc-7675-4e37-935f-4474c5f97c82'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','c88f9dd8-9ed5-4d6e-8d19-b4bb0c54ad61'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','75fe0a20-e1fa-4744-96fb-316ed15c1d66'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','0e1b6fa4-9e09-44eb-85d8-3a16a83cdd44'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','727e59e3-c814-4cb0-b32e-96424e3621c7'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','81d207e1-8593-41a1-80b6-08c4d4862956'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','8c73f216-3a21-4f8e-9905-0edc33579a52'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','c9c23e91-1c8d-4db3-ba2a-d33624c2ba9c'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','7e7073e5-8c99-4a96-87f2-6d3b056bfc32'),(33,NULL,'app','m161007_130653_update_email_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','7b72a226-eda1-4469-93ff-860e45411898'),(34,NULL,'app','m161013_175052_newParentId','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','060acd0b-9a87-4652-aa9e-5cc900d95630'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','930f4a75-9c26-487a-9a40-21cde7afc4f2'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','24fb7646-f39a-42fd-9e5e-13ecbc1c7893'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','3174dd80-fc18-4102-8a62-9a32426acc80'),(38,NULL,'app','m161029_124145_email_message_languages','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','689382c7-87a9-4714-855b-9b322a54f588'),(39,NULL,'app','m161108_000000_new_version_format','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e31dc6e9-9fad-4698-93ed-ab34b683dca7'),(40,NULL,'app','m161109_000000_index_shuffle','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','8bb57510-1b42-43bf-b537-24074b0086ee'),(41,NULL,'app','m161122_185500_no_craft_app','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','fefb3bda-37f5-4fa3-ae63-333efc0bc2c3'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','bf513d5a-44cd-4f3f-9237-a93c089d803d'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','a912f91e-5f41-4ac7-ac0e-d7e236dad93f'),(44,NULL,'app','m170114_161144_udates_permission','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e4c7af62-315b-4267-a8f7-2280b20986e3'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','88f46d4f-e8bf-44e4-b7f4-ee188e4bd55a'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','3f4951af-77f5-4e02-a9df-879f8c81bf7a'),(47,NULL,'app','m170206_142126_system_name','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','d89a56a1-2fe9-47d6-a474-4b863a686534'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','3d546a76-523a-47ce-a734-6732159f56e9'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','1e8b463e-bab9-48ee-89d4-67fc8f4d8bfd'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','152144e4-7014-4170-8f87-8ff14ee0c1e9'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','458a531c-4ccb-4509-9145-32d30e1596b5'),(52,NULL,'app','m170228_171113_system_messages','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','c0a5fd86-0079-42f1-ba1b-251fee6b9fb1'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','5ddb343c-d665-453a-b948-8fba8741d8b2'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','fa55b8da-c8c5-4188-843f-2ca5c27d586a'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','14ef4ceb-87e1-4c28-ba10-574b6e9cff07'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','9a5b9238-b7f6-44c5-a650-08b0018154e7'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','0f824d62-d530-4f1f-b747-be47d626e942'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','0535cb99-3d5e-4402-984b-6ad45bda6d41'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','c22f4104-6e34-46a3-80e2-51009a818bab'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','16958440-ce5b-41c2-be0f-3056fea441ef'),(61,NULL,'app','m170704_134916_sites_tables','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','adc4d823-e693-4a1f-9918-20f4d49271ef'),(62,NULL,'app','m170706_183216_rename_sequences','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','f23aa349-a2c3-4287-ae2b-f2350ae68dc0'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','6cbef750-5307-40b1-b87a-5a3afa8cfb68'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','d3af805c-742a-4670-9e73-9af4d3a7a999'),(65,NULL,'app','m170810_201318_create_queue_table','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e65eee22-8ac6-4c0f-93ae-d6191ea95016'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','cbd4b6de-613b-4ba7-bd0c-59e7d51de183'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','57f63498-4f0f-42a4-9bb4-1c2e12940d89'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','09cbf144-2137-4fe0-a03d-77dde2d15278'),(69,NULL,'app','m171011_214115_site_groups','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','6aa3636e-b167-4260-91cb-052affe7c5d5'),(70,NULL,'app','m171012_151440_primary_site','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','3014cfd9-dce1-4b46-8449-27d7bdb7a3f4'),(71,NULL,'app','m171013_142500_transform_interlace','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','df447eee-728e-4f4b-9060-6fab20192f7f'),(72,NULL,'app','m171016_092553_drop_position_select','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','2137598b-a8c3-45b3-a218-2bee5bf238f5'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','89dc409d-cfd4-4c72-9cad-489953325a54'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','9201e348-eb52-4512-afd8-6d8d72ba7a31'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e5aef525-6a7b-4cf3-a68d-ec0167b27789'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e917509e-edf4-4563-8a46-d2c674f09913'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','be949fae-bb3c-4936-b504-c22a484a43fe'),(78,NULL,'app','m171202_004225_update_email_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','61113a9e-f6ae-462d-9d71-2ce5e7023595'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','1f0b43d2-ad24-40be-95f5-1a5860bbd365'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','da16c909-b301-44f8-8555-1ff2484aba54'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','438b8888-896a-42a1-b052-42c091d58646'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','0d96b180-8f3c-451c-b02d-235ba4918eb3'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','5d1bc49c-2cf6-437f-bbae-35790683543f'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','d2b2aba8-3335-45cc-b2da-4f48bf884eef'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','21e17069-ea83-45a7-ab53-3976ef1eb832'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','383254f7-558c-4b53-9295-1cb5cdd05de7'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','550a6b88-0eb5-48c2-b154-01ec057c35d9'),(88,NULL,'app','m180217_172123_tiny_ints','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','7eee1c3e-dba0-44c9-bffc-4bf8d13897f0'),(89,NULL,'app','m180321_233505_small_ints','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','009d6bae-0aa5-4a93-a0f7-34d9444870e4'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','a078af5a-f773-447f-b958-5e906e6d8564'),(91,NULL,'app','m180404_182320_edition_changes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','0195f93d-d005-4bbe-9ce7-2fc8cc1c77ac'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','2109877a-b52f-4d3e-9aa3-e31c1a2060e0'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','7c653327-6f99-4af2-9a3f-424724bb23d7'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','30fc5a27-31f2-4701-a778-29011a325be3'),(95,NULL,'app','m180425_203349_searchable_fields','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','1a26c93d-f9a4-48e8-80dc-ca852ca9ff0f'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','ef81c303-f2cf-4562-a0d1-31c7722f2e93'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','abe547e3-adda-40c0-a0bd-6eca7a440807'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','720053b1-56d2-4933-a90c-61edfa0aeb54'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','a0384eec-9b4f-4c92-8d9a-7312d7dc1919'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','4e1acf1e-1b55-412d-9223-2e10e23cfbcd'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','296aab52-d423-498a-bee5-986a88b6a021'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','14940761-ecef-4f68-ad69-8160917bb73b'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','3f005a1a-fd94-4a9c-9288-d23cf6b3fbed'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','49d86587-6795-4448-8a8c-17bad0a03cde'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','b3e2ed6c-76af-4417-89a4-c028bf6064dd'),(106,NULL,'app','m180904_112109_permission_changes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','14ea42cf-ae65-4150-b90d-f3b3e41f975c'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','5e2cffc2-69a5-4c16-8343-faed7b4ada16'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','2e87b22e-6ba0-4610-a695-6adda73d6a7b'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','a83ccd64-cdff-4728-b1dc-7a33f5bba8c7'),(110,NULL,'app','m181017_225222_system_config_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','df0abf7a-59b0-4c57-b91b-584b424cd471'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','c26cf0e5-bd0b-4e66-afee-8a8a33aa4e47'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','7d3afff6-88cd-4c6c-b48e-15c72eecb371'),(113,NULL,'app','m181112_203955_sequences_table','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','f71a233f-d972-40b7-8a39-0d5e718d4a38'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','ab7f1bf0-6d94-40c1-a20d-5d018fb245a6'),(115,NULL,'app','m181128_193942_fix_project_config','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','a0cc22e4-2273-424d-85f8-18ccae97990a'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','0da75a4c-27b9-4afd-8dce-43d6bfe8b35f'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','b6276eaf-52d0-4b8f-9b91-61d2944d4cf9'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','95591037-6797-4c58-989b-c837657c02a5'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','118c9346-c528-449e-b942-30b0bababb38'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','f7b431bf-d237-40de-9886-d45ea9d0680c'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e09233e7-ff61-41e2-923c-53f26f24c180'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','5dc5dcda-e363-4989-bb0f-e180534401e3'),(123,NULL,'app','m190109_172845_fix_colspan','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','9e0e17c0-590a-4912-9847-e09385979005'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','46faff66-e76e-4dbd-861f-27b8ff8e7515'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','105f9b68-d057-443e-ad72-021831c9a84a'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','adf9b67f-9322-46c6-b1f9-8071805e8dfb'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','d997c0db-88af-46f4-acef-8d7addd087ee'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','2e73c550-606e-4bc3-b009-0d9e3888d30f'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','fb3a68ee-5e59-4267-b071-2c8b466ce6cc'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','717b98ac-8057-4979-a58d-c307d85c3786'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','ea405249-4235-4772-840f-8b6d29c56137'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','17dc3f9a-b04d-4451-884d-5428663a0a72'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','6e4a6383-841f-4d83-8fdd-94a673adfd5f'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e41250b9-2fee-44e8-89c9-557f37440ca3'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','4afc9697-1663-4185-be15-e614b069cf17'),(136,NULL,'app','m190312_152740_element_revisions','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','bf56d98b-236d-4834-8062-efc7a62f0424'),(137,NULL,'app','m190327_235137_propagation_method','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e9e92276-0471-49fd-995d-1ccad10d826b'),(138,NULL,'app','m190401_223843_drop_old_indexes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','368087bd-cab7-47e5-8f0b-b068c3abe734'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','4277c2eb-876c-46f7-b671-f74423c66c12'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','6a4b6b9e-4027-4845-8e9e-02b8ae283816'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','8f27d8ab-6f0b-48c6-bca9-3654bcb70b45'),(142,NULL,'app','m190504_150349_preview_targets','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','f2ad2c46-5b5d-4cca-8015-2ff7f02d3df3'),(143,NULL,'app','m190516_184711_job_progress_label','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','c59e660a-d7f0-47c2-b6d8-02feaf55ba7e'),(144,NULL,'app','m190523_190303_optional_revision_creators','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','29310116-2157-4a8d-8be2-aa20083830fb'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','18f7d98b-20c6-407c-8fea-c686b8b77021'),(146,NULL,'app','m190605_223807_unsaved_drafts','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','0349871e-a59e-4442-9a83-3431af43019c'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','96893811-5e6a-4f78-9662-0e8bda739b28'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','39994a2f-8039-42f6-94fe-999f0665124c'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','84bb3a24-c9cb-4a56-9aa0-a862609ac8b7'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','4dce4ba7-5a54-47ff-919c-67f0f2a23093'),(151,NULL,'app','m190711_153020_drop_snapshots','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','83145f1d-6b7c-4dfc-bfdf-31b276b5fae6'),(152,NULL,'app','m190712_195914_no_draft_revisions','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','e1177c60-b8cd-4f12-a8be-1669aaaebdc1'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','ff0d4870-af6b-4e0c-aaac-3e2c3ccc355a'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','d8e401e9-0de4-45b0-8879-d6753e990ac8'),(155,NULL,'app','m190823_020339_optional_draft_creators','2019-12-12 16:33:49','2019-12-12 16:33:49','2019-12-12 16:33:49','ee0bf116-a955-46a5-9b1c-e705a8da314f'),(156,2,'plugin','m180430_204710_remove_old_plugins','2019-12-12 16:33:57','2019-12-12 16:33:57','2019-12-12 16:33:57','d2738b02-d1e6-417b-a6bd-61c705a49456'),(157,2,'plugin','Install','2019-12-12 16:33:57','2019-12-12 16:33:57','2019-12-12 16:33:57','e5136234-83c4-4ce4-9e8e-09ef581f0ce9'),(158,2,'plugin','m190225_003922_split_cleanup_html_settings','2019-12-12 16:33:57','2019-12-12 16:33:57','2019-12-12 16:33:57','248c598d-b67c-4b8f-ab9f-1459a6418509'),(159,NULL,'app','m180521_172900_project_config_table','2020-06-15 10:41:39','2020-06-15 10:41:39','2020-06-15 10:41:39','f41c92a2-8939-477f-89f5-37f2594e7ec1'),(160,NULL,'app','m190913_152146_update_preview_targets','2020-06-15 10:41:39','2020-06-15 10:41:39','2020-06-15 10:41:39','39c7c7d3-f200-48d7-9c64-395e49efbf56'),(161,NULL,'app','m191107_122000_add_gql_project_config_support','2020-06-15 10:41:40','2020-06-15 10:41:40','2020-06-15 10:41:40','ddd52b56-9c42-4ca8-b92d-e5deb7aa306d'),(162,NULL,'app','m191204_085100_pack_savable_component_settings','2020-06-15 10:41:40','2020-06-15 10:41:40','2020-06-15 10:41:40','cd6fc503-a260-41fa-bd12-ee0dced15250'),(163,NULL,'app','m191206_001148_change_tracking','2020-06-15 10:41:40','2020-06-15 10:41:40','2020-06-15 10:41:40','5081727e-642f-4396-89d7-b84abe07271f'),(164,NULL,'app','m191216_191635_asset_upload_tracking','2020-06-15 10:41:41','2020-06-15 10:41:41','2020-06-15 10:41:41','53854c82-1529-4ea2-9ee3-eab0295173e6'),(165,NULL,'app','m191222_002848_peer_asset_permissions','2020-06-15 10:41:41','2020-06-15 10:41:41','2020-06-15 10:41:41','534cb701-a859-48bd-b0e3-d51135bfeefa'),(166,NULL,'app','m200127_172522_queue_channels','2020-06-15 10:41:41','2020-06-15 10:41:41','2020-06-15 10:41:41','2a612e85-440e-4d63-ba46-0ec875635eaf'),(167,NULL,'app','m200211_175048_truncate_element_query_cache','2020-06-15 10:41:41','2020-06-15 10:41:41','2020-06-15 10:41:41','c5a1bceb-245c-4d99-9fe6-fcc313b95b00'),(168,NULL,'app','m200213_172522_new_elements_index','2020-06-15 10:41:41','2020-06-15 10:41:41','2020-06-15 10:41:41','a3d140e5-1fb0-433f-85f9-054c44be24f0'),(169,NULL,'app','m200228_195211_long_deprecation_messages','2020-06-15 10:41:41','2020-06-15 10:41:41','2020-06-15 10:41:41','d1e3e004-85f8-451b-8058-74d8d0914335');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'servd-asset-storage','1.3.0','1.0','unknown',NULL,'2019-12-12 16:33:56','2019-12-12 16:33:56','2020-06-15 10:41:45','62a793c2-8e2a-4f45-a3e9-a3730eacfac6'),(2,'redactor','2.3.3.2','2.3.0','unknown',NULL,'2019-12-12 16:33:57','2019-12-12 16:33:57','2020-06-15 10:41:45','2cff3e0e-583a-4173-8734-69de87b1fa39');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('dateModified','1592217699'),('email.fromEmail','\"fake@fake-email-address.com\"'),('email.fromName','\"Servd Demo\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.41f0085a-91c4-4de0-8a54-a5d6419bb7a8.name','\"Common\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('plugins.servd-asset-storage.edition','\"standard\"'),('plugins.servd-asset-storage.enabled','true'),('plugins.servd-asset-storage.schemaVersion','\"1.0\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.enableVersioning','false'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.handle','\"home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.hasTitleField','false'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.name','\"Home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.sortOrder','1'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.titleFormat','\"{section.name|raw}\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.titleLabel','null'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.handle','\"home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.name','\"Home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.previewTargets.0.label','\"Primary entry page\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.previewTargets.0.urlFormat','\"{url}\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.propagationMethod','\"all\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.siteSettings.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.enabledByDefault','true'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.siteSettings.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.hasUrls','true'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.siteSettings.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.template','\"singles/home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.siteSettings.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.uriFormat','\"__home__\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.type','\"single\"'),('siteGroups.30f1acc4-b407-4444-8edc-278ba32bf7c9.name','\"Servd Demo\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.baseUrl','\"http://localhost\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.handle','\"default\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.hasUrls','true'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.language','\"en\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.name','\"Servd Demo\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.primary','true'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.siteGroup','\"30f1acc4-b407-4444-8edc-278ba32bf7c9\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Servd Demo\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.handle','\"servdAssets\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.hasUrls','true'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.name','\"Servd Assets\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.settings.makeUploadsPublic','\"1\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.settings.projectSlug','\"\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.settings.securityKey','\"\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.settings.subfolder','\"\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.sortOrder','1'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.type','\"servd\\\\AssetStorage\\\\Volume\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.url','\"https://cdn2.assets-servd.host/\"');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('15867de4','@craft/web/assets/dbbackup/dist'),('1dee341a','@lib/fabric'),('1e9c6fdf','@app/web/assets/dashboard/dist'),('1f115ae8','@craft/web/assets/craftsupport/dist'),('200467ac','@craft/web/assets/feed/dist'),('21d4e0fc','@app/web/assets/dbbackup/dist'),('231e2de2','@lib/jquery-ui'),('29c96dab','@lib/axios'),('2d58d60d','@lib/fileupload'),('3092e1b8','@lib/prismjs'),('3214eb31','@lib/jquery-touch-events'),('35b0d7f3','@lib/picturefill'),('3b15f7a2','@lib/d3'),('3e3aaddf','@app/web/assets/editentry/dist'),('53a8eacf','@lib/element-resize-detector'),('5668e9f4','@app/web/assets/editsection/dist'),('59474167','@craft/web/assets/dashboard/dist'),('5c5722cc','@app/web/assets/plugins/dist'),('61cefa77','@lib/selectize'),('67e1df3e','@craft/web/assets/cp/dist'),('6ba2befd','@lib/xregexp'),('6db7b647','@lib/velocity'),('719019af','@lib/jquery.payment'),('786d5d6b','@lib/datepicker-i18n'),('7c38413a','@bower/jquery/dist'),('8607ee8f','@craft/web/assets/recententries/dist'),('8a8e024','@lib/garnishjs'),('8fc4a8d0','@craft/web/assets/updater/dist'),('968a4081','@lib/element-resize-detector'),('a2c37570','@craft/web/assets/cp/dist'),('a48a6a2d','@app/web/assets/feed/dist'),('a4ec5039','@lib/selectize'),('a8951c09','@lib/velocity'),('ae8014b3','@lib/xregexp'),('b4b2b3e1','@lib/jquery.payment'),('b8bdace1','@craft/web/assets/updateswidget/dist'),('b91aeb74','@bower/jquery/dist'),('bd4ff725','@lib/datepicker-i18n'),('bfea6302','@app/web/assets/utilities/dist'),('c0dc061e','@app/web/assets/recententries/dist'),('c1006490','@lib/vue'),('cd8a4a6a','@lib/garnishjs'),('d8cc9e54','@lib/fabric'),('d9af34ed','@app/web/assets/login/dist'),('dd912193','@app/web/assets/cp/dist'),('e63c87ac','@lib/jquery-ui'),('e87a7c43','@lib/fileupload'),('ecebc7e5','@lib/axios'),('f0927dbd','@lib/picturefill'),('f0f4e8b1','@app/web/assets/craftsupport/dist'),('f736417f','@lib/jquery-touch-events'),('f8314dba','@craft/web/assets/utilities/dist'),('f882361d','@craft/web/assets/plugins/dist'),('fe375dec','@lib/d3'),('fe664470','@app/web/assets/updateswidget/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' fake fake email address com '),(1,'slug',0,1,''),(2,'slug',0,1,' home '),(2,'title',0,1,' home ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'Home','home','single',0,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2019-12-12 16:34:11','2020-06-15 10:41:39',NULL,'7b9fa0a4-623a-43e2-83a8-3d013cc6902e');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'__home__','singles/home',1,'2019-12-12 16:34:11','2019-12-12 16:34:11','4c91733b-ef94-4e6b-a2d1-f230f019f1e9');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Servd Demo','2019-12-12 16:33:48','2019-12-12 16:33:48',NULL,'30f1acc4-b407-4444-8edc-278ba32bf7c9');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'Servd Demo','default','en',1,'http://localhost',1,'2019-12-12 16:33:48','2019-12-12 16:33:48',NULL,'4a08a421-ed5e-4eb5-8dbc-018aed34c7d3');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'admin',NULL,NULL,NULL,'fake@fake-email-address.com','$2y$13$TVJZZylBy3prlrZ/m.wwmO19HLiE31typ6xCOlH.mgB0HKlfetsrq',1,0,0,0,'2020-06-15 10:41:33',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-12-12 16:33:49','2019-12-12 16:33:49','2020-06-15 10:41:33','07960148-5411-4ebd-a889-fac718c19c61');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Servd Assets','','2019-12-12 16:34:36','2020-06-15 09:44:50','e4426612-ef36-4d2d-b06e-1e5f8adf07cf'),(2,NULL,NULL,'Temporary source',NULL,'2019-12-12 16:34:49','2019-12-12 16:34:49','9e3861bb-eacc-4b01-8b22-107521e87d43'),(3,2,NULL,'user_1','user_1/','2019-12-12 16:34:49','2019-12-12 16:34:49','66aeb47c-c1d3-4562-8b0c-762d8f767cac');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,NULL,'Servd Assets','servdAssets','servd\\AssetStorage\\Volume',1,'https://cdn2.assets-servd.host/','{\"subfolder\":\"\",\"projectSlug\":\"\",\"securityKey\":\"\",\"makeUploadsPublic\":\"1\"}',1,'2019-12-12 16:34:36','2020-06-15 09:44:50',NULL,'2f7839c9-4c87-4bf6-9d3c-2181918ec980');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-12-12 16:33:50','2019-12-12 16:33:50','fa2026ef-430b-49fc-84ae-cde37560bba6'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-12-12 16:33:50','2019-12-12 16:33:50','1d06d878-44d0-400f-af7a-77e824e5352a'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-12-12 16:33:50','2019-12-12 16:33:50','41f90c24-6d5c-4827-8d35-a48354a5a8c8'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-12-12 16:33:50','2019-12-12 16:33:50','2a02bad7-e475-4be5-bf0c-8072b482dd66');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-15 10:41:54
