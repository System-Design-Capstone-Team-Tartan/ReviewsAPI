DROP TABLE IF EXISTS review, review_characteristics, characteristic, review_photos;

/* Table 'review' */
CREATE TABLE review(
  id integer NOT NULL,
  product_id integer,
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

/* Table 'review_characteristics' */
CREATE TABLE review_characteristics(
  id integer NOT NULL,
  characteristic_id integer NOT NULL,
  review_id integer NOT NULL,
  "value" integer,
  PRIMARY KEY(id)
);

/* Table 'characteristic' */
CREATE TABLE characteristic(
  id integer NOT NULL,
  product_id integer,
  "name" varchar,
  PRIMARY KEY(id)
);

/* Table 'review_photos' */
CREATE TABLE review_photos(
  id integer NOT NULL,
  review_id integer NOT NULL,
  url varchar,
  PRIMARY KEY(id)
);

/* Relation 'review_review_photos' */
ALTER TABLE review_photos
  ADD CONSTRAINT review_review_photos
    FOREIGN KEY (review_id) REFERENCES review (id);

/* Relation 'characteristic_review_characteristics' */
ALTER TABLE review_characteristics
  ADD CONSTRAINT characteristic_review_characteristics
    FOREIGN KEY (characteristic_id) REFERENCES characteristic (id);

/* Relation 'review_review_characteristics' */
ALTER TABLE review_characteristics
  ADD CONSTRAINT review_review_characteristics
    FOREIGN KEY (review_id) REFERENCES review (id);

COPY review FROM '/home/dareitus/hackreactor/live/SDC/reviews/ReviewsAPI/data/reviews.csv' DELIMITER ',' CSV HEADER;

COPY characteristic FROM '/home/dareitus/hackreactor/live/SDC/reviews/ReviewsAPI/data/characteristics.csv' DELIMITER ',' CSV HEADER;

COPY review_characteristics FROM '/home/dareitus/hackreactor/live/SDC/reviews/ReviewsAPI/data/characteristic_reviews.csv' DELIMITER ',' CSV HEADER;

COPY review_photos FROM '/home/dareitus/hackreactor/live/SDC/reviews/ReviewsAPI/data/reviews_photos.csv' DELIMITER ',' CSV HEADER;

-- sudo service postgresql start
-- sudo service postgresql status
-- sudo -u postgres psql -d reviews -f server/db/schema.sql
-- sudo -u postgres psql reviews