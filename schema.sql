/* Database schema to keep the structure of entire database. */
CREATE DATABASE vetclinic
CREATE TABLE animals
(
    id integer NOT NULL,
    name varchar(50) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts integer NOT NULL,
    neutered boolean NOT NULL,
    weight_kg numeric NOT NULL,
    species varchar(50),
    CONSTRAINT animals_pkey PRIMARY KEY (id)
)