/* Database schema to keep the structure of entire database. */
CREATE SCHEMA `vet_clinic` ;
CREATE TABLE `vet_clinic`.`animals` (
  `idAnimals` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATETIME NOT NULL,
  `escape_attempts` INT NOT NULL,
  `neutered` TINYINT(1) NOT NULL,
  `weight_kg` DECIMAL(3) NOT NULL,
  PRIMARY KEY (`idAnimals`));