-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema coches
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema coches
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `coches` DEFAULT CHARACTER SET utf8 ;
USE `coches` ;

-- -----------------------------------------------------
-- Table `coches`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`factura` (
  `idfactura` INT NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`idfactura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coches`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`clientes` (
  `idclientes` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `provincia` VARCHAR(45) NULL,
  `telefono` INT(9) NOT NULL,
  `factura_idfactura` INT NOT NULL,
  PRIMARY KEY (`idclientes`),
  INDEX `fk_clientes_factura_idx` (`factura_idfactura` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_factura`
    FOREIGN KEY (`factura_idfactura`)
    REFERENCES `coches`.`factura` (`idfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coches`.`fecha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`fecha` (
  `idfecha` INT NOT NULL,
  `fecha_` DATE NULL,
  `factura_idfactura` INT NOT NULL,
  PRIMARY KEY (`idfecha`),
  INDEX `fk_fecha_factura1_idx` (`factura_idfactura` ASC) VISIBLE,
  CONSTRAINT `fk_fecha_factura1`
    FOREIGN KEY (`factura_idfactura`)
    REFERENCES `coches`.`factura` (`idfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coches`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`vendedor` (
  `idvendedor` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `sucursal` VARCHAR(45) NOT NULL,
  `antiguedad` VARCHAR(45) NOT NULL,
  `factura_idfactura` INT NOT NULL,
  PRIMARY KEY (`idvendedor`),
  INDEX `fk_vendedor_factura1_idx` (`factura_idfactura` ASC) VISIBLE,
  CONSTRAINT `fk_vendedor_factura1`
    FOREIGN KEY (`factura_idfactura`)
    REFERENCES `coches`.`factura` (`idfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coches`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`producto` (
  `idproducto` INT NOT NULL,
  `tipo_vehiculo` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `factura_idfactura` INT NOT NULL,
  PRIMARY KEY (`idproducto`, `factura_idfactura`),
  INDEX `fk_producto_factura1_idx` (`factura_idfactura` ASC) VISIBLE,
  CONSTRAINT `fk_producto_factura1`
    FOREIGN KEY (`factura_idfactura`)
    REFERENCES `coches`.`factura` (`idfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
