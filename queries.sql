/*Queries that provide answers to the questions from all projects.*/
SELECT name FROM animals where name like '%mon';
SELECT name FROM animals where date_of_birth between '2016-01-01' and '2019-12-31';
SELECT name FROM animals where neutered = 1 and escape_attempts < 3;
SELECT date_of_birth FROM animals where name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts FROM animals where weight_kg > 10.5;
SELECT * FROM animals where neutered = 1;
SELECT * FROM animals where name != 'Gabumon';
SELECT * FROM animals where weight_kg between 10.4 and 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species='digimon' WHERE name like '%mon';
UPDATE animals SET species='pokemon' WHERE species is null;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01'::date;
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* how many animals are there? */
SELECT COUNT(*) FROM animals

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, SUM(escape_attempts) AS EscapeAttempts FROM animals GROUP BY neutered

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight FROM animals GROUP BY species

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) as average_scape_attempts FROM animals WHERE date_of_birth between '1990-01-01' and '2000-12-31' GROUP BY species