SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`site` ;

CREATE TABLE IF NOT EXISTS `mydb`.`site` (
  `siteId` INT NOT NULL AUTO_INCREMENT,
  `siteName` VARCHAR(255) NOT NULL,
  `siteUrl` TEXT NOT NULL,
  PRIMARY KEY (`siteId`),
  UNIQUE INDEX `siteId_UNIQUE` (`siteId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Characteristic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Characteristic` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Characteristic` (
  `characteristicId` INT NOT NULL AUTO_INCREMENT,
  `Characteristic` TEXT NULL,
  PRIMARY KEY (`characteristicId`),
  UNIQUE INDEX `characteristicId_UNIQUE` (`characteristicId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `categoryId` INT NOT NULL AUTO_INCREMENT,
  `site_siteId` INT NOT NULL,
  `categoryName` VARCHAR(50) NOT NULL,
  `subCategoryId` INT NULL,
  `CharacteristiсId` INT NOT NULL,
  UNIQUE INDEX `commodityID_UNIQUE` (`categoryId` ASC),
  INDEX `fk_category_site1_idx` (`site_siteId` ASC),
  PRIMARY KEY (`categoryId`, `CharacteristiсId`),
  INDEX `fk_category_Characteristic1_idx` (`CharacteristiсId` ASC),
  CONSTRAINT `fk_category_site1`
    FOREIGN KEY (`site_siteId`)
    REFERENCES `mydb`.`site` (`siteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_Characteristic1`
    FOREIGN KEY (`CharacteristiсId`)
    REFERENCES `mydb`.`Characteristic` (`characteristicId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`commodity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`commodity` ;

CREATE TABLE IF NOT EXISTS `mydb`.`commodity` (
  `commodityID` INT NOT NULL AUTO_INCREMENT,
  `commodityName` VARCHAR(255) NOT NULL,
  `simularCommudity` INT NOT NULL,
  `categoryId` INT NOT NULL,
  PRIMARY KEY (`commodityID`, `categoryId`),
  UNIQUE INDEX `commodityID_UNIQUE` (`commodityID` ASC),
  UNIQUE INDEX `commodityName_UNIQUE` (`commodityName` ASC),
  INDEX `fk_commodity_category1_idx` (`categoryId` ASC),
  CONSTRAINT `fk_commodity_category1`
    FOREIGN KEY (`categoryId`)
    REFERENCES `mydb`.`category` (`categoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`shop` ;

CREATE TABLE IF NOT EXISTS `mydb`.`shop` (
  `shopId` INT NOT NULL AUTO_INCREMENT,
  `shopName` VARCHAR(255) NOT NULL,
  `shopTelefone` DECIMAL(12) NULL,
  `ShopEmaill` VARCHAR(255) NOT NULL,
  `shopAddres` TEXT NULL,
  `ShopAdditionalInfo` TEXT NULL,
  `shopAdditionalTelefone` VARCHAR(150) NULL,
  PRIMARY KEY (`shopId`),
  UNIQUE INDEX `shopId_UNIQUE` (`shopId` ASC),
  UNIQUE INDEX `shopName_UNIQUE` (`shopName` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `role` VARCHAR(45) NULL,
  `userid` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`userid`),
  UNIQUE INDEX `userid_UNIQUE` (`userid` ASC));


-- -----------------------------------------------------
-- Table `mydb`.`commodity_has_shop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`commodity_has_shop` ;

CREATE TABLE IF NOT EXISTS `mydb`.`commodity_has_shop` (
  `commodityID` INT NOT NULL,
  `shopId` INT NOT NULL,
  `Cena` INT NULL,
  `additionalInfo` TEXT NULL,
  `UpdateDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `TypeSale` VARCHAR(45) NOT NULL,
  `OnSclad` DECIMAL(1) NULL,
  `user_userid` INT NOT NULL,
  PRIMARY KEY (`commodityID`, `shopId`),
  INDEX `fk_commodity_has_shop_shop1_idx` (`shopId` ASC),
  INDEX `fk_commodity_has_shop_commodity_idx` (`commodityID` ASC),
  INDEX `fk_commodity_has_shop_user1_idx` (`user_userid` ASC),
  CONSTRAINT `fk_commodity_has_shop_commodity`
    FOREIGN KEY (`commodityID`)
    REFERENCES `mydb`.`commodity` (`commodityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commodity_has_shop_shop1`
    FOREIGN KEY (`shopId`)
    REFERENCES `mydb`.`shop` (`shopId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commodity_has_shop_user1`
    FOREIGN KEY (`user_userid`)
    REFERENCES `mydb`.`user` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`site_has_commodity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`site_has_commodity` ;

CREATE TABLE IF NOT EXISTS `mydb`.`site_has_commodity` (
  `site_siteId` INT NOT NULL,
  `commodity_commodityID` INT NOT NULL,
  PRIMARY KEY (`site_siteId`, `commodity_commodityID`),
  INDEX `fk_site_has_commodity_commodity1_idx` (`commodity_commodityID` ASC),
  INDEX `fk_site_has_commodity_site1_idx` (`site_siteId` ASC),
  CONSTRAINT `fk_site_has_commodity_site1`
    FOREIGN KEY (`site_siteId`)
    REFERENCES `mydb`.`site` (`siteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_site_has_commodity_commodity1`
    FOREIGN KEY (`commodity_commodityID`)
    REFERENCES `mydb`.`commodity` (`commodityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UserSiteAccess`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`UserSiteAccess` ;

CREATE TABLE IF NOT EXISTS `mydb`.`UserSiteAccess` (
  `siteId` INT NOT NULL,
  `userid` INT NOT NULL,
  PRIMARY KEY (`siteId`, `userid`),
  INDEX `fk_site_has_user_user1_idx` (`userid` ASC),
  INDEX `fk_site_has_user_site1_idx` (`siteId` ASC),
  CONSTRAINT `fk_site_has_user_site1`
    FOREIGN KEY (`siteId`)
    REFERENCES `mydb`.`site` (`siteId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_site_has_user_user1`
    FOREIGN KEY (`userid`)
    REFERENCES `mydb`.`user` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
