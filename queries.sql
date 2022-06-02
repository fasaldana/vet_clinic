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

/* What animals belong to Melody Pond? */
SELECT a.name, o.full_name
FROM animals a
INNER JOIN owners o
on a.owner_id=o.id
WHERE o.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT a.name, s.name
FROM animals a
INNER JOIN species s
ON a.species_id = s.id
WHERE s.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a
on a.owner_id=o.id;

/* How many animals are there per species? */
SELECT COUNT(a.name) as animals_quantity, s.name
FROM animals a
INNER JOIN species s
ON a.species_id = s.id
GROUP BY s.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT a.name, o.full_name as owner, s.name as species
FROM animals a
JOIN owners o
on a.owner_id = o.id
JOIN species s
on a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell'
AND s.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT a.name as animal, o.full_name as owner, a.escape_attempts
FROM animals a
INNER JOIN owners o
on a.owner_id=o.id
WHERE escape_attempts = 0
AND o.full_name = 'Dean Winchester';

/* Who owns the most animals? */
SELECT o.full_name as owner, COUNT(a.name) AS quantity
FROM animals a
INNER JOIN owners o
on a.owner_id=o.id
GROUP BY o.full_name
ORDER BY quantity DESC;

/*=====================================================*/
/* Who was the last animal seen by William Tatcher? */
SELECT a.name as animal, v.name as vet, vi.visit_date
FROM visits vi
INNER JOIN vets v
ON v.id = vi.vets_id
INNER JOIN animals a
ON a.id = vi.animals_id
WHERE v.name = 'William Tatcher'
AND vi.visit_date = (
	SELECT MAX(visit_date)
	FROM visits
	WHERE vets_id = 1);

/* How many different animals did Stephanie Mendez see? */
SELECT v.name as vet, COUNT(a.name) as animals_quantity
FROM visits vi
INNER JOIN vets v
ON v.id = vi.vets_id
INNER JOIN animals a
ON a.id = vi.animals_id
WHERE v.name = 'Stephanie Mendez'
GROUP BY v.name;

/* List all vets and their specialties, including vets with no specialties. */
SELECT v.name, s.name
FROM specializations spe
INNER JOIN species s
ON s.id = spe.species_id
FULL JOIN vets v
on v.id = spe.vets_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT a.name as animal, v.name as vet, vi.visit_date
FROM visits vi
INNER JOIN vets v
ON v.id = vi.vets_id
INNER JOIN animals a
ON a.id = vi.animals_id
WHERE v.name = 'Stephanie Mendez'
AND vi.visit_date between '2020-04-01' and '2020-08-30';

/* What animal has the most visits to vets? */
SELECT a.name AS animal, COUNT(a.name) AS total
FROM visits vi
INNER JOIN vets v
ON v.id = vi.vets_id
INNER JOIN animals a
ON a.id = vi.animals_id
GROUP BY a.name
ORDER BY total DESC
LIMIT 1;

/* Who was Maisy Smith's first visit? */
SELECT a.name as animal, v.name as vet, vi.visit_date
FROM visits vi
INNER JOIN vets v
ON v.id = vi.vets_id
INNER JOIN animals a
ON a.id = vi.animals_id
WHERE v.name = 'Maisy Smith'
AND vi.visit_date = (
	SELECT MIN(visit_date)
	FROM visits
	WHERE vets_id = 2);

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT a.name as animal_info, v.name as vet_info, vi.visit_date
FROM visits vi
INNER JOIN vets v
ON v.id = vi.vets_id
INNER JOIN animals a
ON a.id = vi.animals_id
AND vi.visit_date = (
	SELECT MAX(visit_date)
	FROM visits);

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(vi.animals_id)
FROM visits vi
JOIN animals a
ON a.id = vi.animals_id
JOIN vets v
ON v.id = vi.vets_id
JOIN specializations spe
ON spe.vets_id = vi.vets_id
WHERE a.species_id != spe.species_id;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT s.name as species, COUNT(*) as how_many
FROM visits vi
INNER JOIN vets v
ON v.id = vi.vets_id
INNER JOIN animals a
ON a.id = vi.animals_id
INNER JOIN species s
ON s.id = a.species_id
WHERE v.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY how_many DESC
LIMIT 1;