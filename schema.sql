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

CREATE TABLE vets
(
    id serial NOT NULL,
    name character varying(50) COLLATE pg_catalog."default",
    age integer,
    date_of_graduation date,
    CONSTRAINT vets_pkey PRIMARY KEY (id)
);

/* vists table join table */
CREATE TABLE visits
(
    id serial NOT NULL,
    animals_id integer,
    vets_id integer,
    visit_date date,
    CONSTRAINT visits_pkey PRIMARY KEY (id),
    CONSTRAINT animals_id_fkey FOREIGN KEY (animals_id)
        REFERENCES public.animals (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT vets_id_fkey FOREIGN KEY (vets_id)
        REFERENCES public.vets (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

/* specializations join table */
CREATE TABLE specializations
(
    id_specialities serial NOT NULL,
    species_id integer,
    vets_id integer,
    CONSTRAINT specializations_pkey PRIMARY KEY (id_specialities),
    CONSTRAINT species_id_fkey FOREIGN KEY (species_id)
        REFERENCES public.species (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT vets_id_fkey FOREIGN KEY (vets_id)
        REFERENCES public.vets (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);