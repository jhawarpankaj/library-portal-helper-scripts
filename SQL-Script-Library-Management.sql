-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`BOOK`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BOOK` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BOOK` (
  `ISBN` VARCHAR(10) NOT NULL,
  `TITLE` VARCHAR(100) NULL,
  PRIMARY KEY (`ISBN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AUTHORS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AUTHORS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`AUTHORS` (
  `AUTHOR_ID` INT NOT NULL,
  `NAME` VARCHAR(50) NULL,
  PRIMARY KEY (`AUTHOR_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BOOK_AUTHORS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BOOK_AUTHORS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BOOK_AUTHORS` (
  `AUTHOR_ID` INT NOT NULL,
  `ISBN` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ISBN`),
  INDEX `fk_BOOK_AUTHORS_2_idx` (`AUTHOR_ID` ASC),
  CONSTRAINT `fk_BOOK_AUTHORS_1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`BOOK` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BOOK_AUTHORS_2`
    FOREIGN KEY (`AUTHOR_ID`)
    REFERENCES `mydb`.`AUTHORS` (`AUTHOR_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BORROWER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BORROWER` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BORROWER` (
  `CardID` INT NOT NULL,
  `SSN` VARCHAR(11) NOT NULL,
  `BNAME` VARCHAR(50) NOT NULL,
  `ADDRESS` VARCHAR(100) NULL,
  `PHONE` VARCHAR(14) NULL,
  PRIMARY KEY (`CardID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BOOK_LOANS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BOOK_LOANS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BOOK_LOANS` (
  `LOAN_ID` INT NOT NULL,
  `ISBN` VARCHAR(10) NOT NULL,
  `CARD_ID` INT(10) NOT NULL,
  `DATE_OUT` TIMESTAMP NOT NULL DEFAULT NOW(),
  `DUE_DATE` TIMESTAMP NOT NULL,
  `DATE_IN` DATE NOT NULL,
  PRIMARY KEY (`LOAN_ID`),
  INDEX `fk_BOOK_LOANS_1_idx` (`ISBN` ASC),
  INDEX `fk_BOOK_LOANS_2_idx` (`CARD_ID` ASC),
  CONSTRAINT `fk_BOOK_LOANS_1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`BOOK` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BOOK_LOANS_2`
    FOREIGN KEY (`CARD_ID`)
    REFERENCES `mydb`.`BORROWER` (`CardID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FINES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`FINES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`FINES` (
  `LOAN_ID` INT NOT NULL,
  `FINE_AMT` INT NULL,
  `PAID` INT NULL,
  PRIMARY KEY (`LOAN_ID`),
  CONSTRAINT `fk_FINES_1`
    FOREIGN KEY (`LOAN_ID`)
    REFERENCES `mydb`.`BOOK_LOANS` (`LOAN_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
