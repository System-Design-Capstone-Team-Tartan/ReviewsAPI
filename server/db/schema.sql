DROP TABLE IF EXISTS CHARACTERISTICS, REVIEW_CHARACTERISTICS, REVIEW_PHOTOS, REVIEWS, META;

/* Table 'CHARACTERISTICS' */
CREATE TABLE "CHARACTERISTICS"(
  id integer NOT NULL,
  "PRODUCTS_id" integer NOT NULL,
  "name" varchar,
  PRIMARY KEY(id)
);

/* Table 'REVIEW_CHARACTERISTICS' */
CREATE TABLE "REVIEW_CHARACTERISTICS"(
  id integer NOT NULL,
  "CHARACTERISTICS_id" integer NOT NULL,
  "REVIEWS_id" integer NOT NULL,
  "value" integer,
  PRIMARY KEY(id)
);

/* Table 'REVIEW_PHOTOS' */
CREATE TABLE "REVIEW_PHOTOS"(
  id integer NOT NULL,
  "REVIEWS_id" integer NOT NULL,
  url varchar,
  PRIMARY KEY(id)
);

/* Table 'REVIEWS' */
CREATE TABLE "REVIEWS"(
  id integer NOT NULL,
  "PRODUCTS_id" integer NOT NULL,
  rating integer,
  date date,
  summary varchar,
  body varchar,
  recommend boolean,
  reported boolean,
  reviewer_name varchar,
  reviewer_email varchar,
  response varchar,
  helpfullness integer,
  PRIMARY KEY(id)
);

/* Relation 'CHARACTERISTICS_REVIEW_CHARACTERISTICS' */
ALTER TABLE "REVIEW_CHARACTERISTICS"
  ADD CONSTRAINT "CHARACTERISTICS_REVIEW_CHARACTERISTICS"
    FOREIGN KEY ("CHARACTERISTICS_id") REFERENCES "CHARACTERISTICS" (id);

/* Relation 'REVIEWS_REVIEW_CHARACTERISTICS' */
ALTER TABLE "REVIEW_CHARACTERISTICS"
  ADD CONSTRAINT "REVIEWS_REVIEW_CHARACTERISTICS"
    FOREIGN KEY ("REVIEWS_id") REFERENCES "REVIEWS" (id);

/* Relation 'REVIEWS_REVIEWS_PHOTOS' */
ALTER TABLE "REVIEW_PHOTOS"
  ADD CONSTRAINT "REVIEWS_REVIEWS_PHOTOS"
    FOREIGN KEY ("REVIEWS_id") REFERENCES "REVIEWS" (id);


/*ETL PROCESS */

COPY CHARACTERISTICS FROM '.../data/characteristsics.csv' DELIMITER ',' CSV HEADER;

COPY REVIEW_CHARACTERISTICS FROM '.../data/characteristic_reviews.csv' DELIMITER ',' CSV HEADER;

COPY REVIEW_PHOTOS FROM '.../data/reviews_photos.csv' DELIMITER ',' CSV HEADER;

COPY REVIEWS FROM '.../data/reviews.csv' DELIMITER ',' CSV HEADER;


/* META TABLE AND COMPOSITES - TODO */

/* Table 'META' */
CREATE TABLE "META"(
  id integer NOT NULL,
  ratings "RATINGS",
  recommended "RECOMMENDED",
  "characteristics" "CHARACTERISTICS",
  PRIMARY KEY(id)
);

/* Relation 'META_REVIEWS' */
ALTER TABLE "REVIEWS"
  ADD CONSTRAINT "META_REVIEWS" FOREIGN KEY ("PRODUCTS_id") REFERENCES "META" (id)
  ;

/* Relation 'META_CHARACTERISTICS' */
ALTER TABLE "CHARACTERISTICS"
  ADD CONSTRAINT "META_CHARACTERISTICS"
    FOREIGN KEY ("PRODUCTS_id") REFERENCES "META" (id);

/* Composite 'CHARACTERISTIC' */
CREATE TYPE "CHARACTERISTIC" AS
  (
    0 integer,
    ".5" integer,
    1 integer,
    "1.5" integer,
    2 integer
  );

/* Composite 'CHARACTERISTICS' */
CREATE TYPE "CHARACTERISTICS" AS ("name" "CHARACTERISTIC");

/* Composite 'RATINGS' */
CREATE TYPE "RATINGS" AS
  (
    1 integer,
    2 integer,
    3 integer,
    4 integer,
    5 integer
  );

/* Composite 'RECOMMENDED' */
CREATE TYPE "RECOMMENDED" AS (0 integer, 1 integer);