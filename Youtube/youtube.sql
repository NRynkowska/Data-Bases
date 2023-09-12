-- Table: video_stats

CREATE TABLE video_stats
(
  id integer,
  title text,
  video_id text,
  published_at date,
  keyword text,
  likes float,
  comments float,
  views float
);

-- Copy over data from CSV
\copy video_stats FROM 'C:/Users/Natalia/Desktop/data/YouTube/video_stats.csv' DELIMITER ',' CSV HEADER;

-- table: comments

CREATE TABLE comments
(
  id integer,
  video_id text,
  comment text,
  likes float,
  sentiment float
);

-- Copy over data from CSV
\copy comments FROM 'C:/Users/Natalia/Desktop/data/YouTube/comments.csv' DELIMITER ',' CSV HEADER;

