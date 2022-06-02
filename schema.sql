/* Database schema to keep the structure of entire database. */
CREATE DATABASE vetclinic
CREATE TABLE owners
(
    id serial NOT NULL,
    full_name varchar(50),
    age integer,
    CONSTRAINT owners_pkey PRIMARY KEY (id)
);

CREATE TABLE species
(
    id serial NOT NULL,
    name varchar(50),
    CONSTRAINT species_pkey PRIMARY KEY (id)
);

CREATE TABLE animals(
    id serial NOT NULL,
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts integer NOT NULL,
    neutered boolean NOT NULL,
    weight_kg numeric NOT NULL,
    species_id integer,
    owner_id integer,
    CONSTRAINT animals_pkey PRIMARY KEY (id),
    CONSTRAINT owners_id_fkey FOREIGN KEY (owner_id)
        REFERENCES owners (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT species_id_fkey FOREIGN KEY (species_id)
        REFERENCES species (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);