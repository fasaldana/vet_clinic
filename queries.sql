/*Queries that provide answers to the questions from all projects.*/
SELECT name FROM vet_clinic.animals where name like '%mon';
SELECT name FROM vet_clinic.animals where date_of_birth between '2016-01-01' and '2019-12-31';
SELECT name FROM vet_clinic.animals where neutered = 1 and escape_attempts < 3;
SELECT date_of_birth FROM vet_clinic.animals where name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts FROM vet_clinic.animals where weight_kg > 10.5;
SELECT * FROM vet_clinic.animals where neutered = 1;
SELECT * FROM vet_clinic.animals where name != 'Gabumon';
SELECT * FROM vet_clinic.animals where weight_kg between 10.4 and 17.3;
