-- Albums:
--   - album name
--   - artist
--   - release_date
--   - genre

-- Songs:
--   - track_number
--   - song name
--   - rating
--   - runtime

CREATE TABLE albums (
  id INT,
  name TEXT,
  artist_name TEXT,
  release_date DATE,
  genre VARCHAR(50),
);

CREATE TABLE songs (
  id INT,
  track_number INT,
  name VARCHAR(500),
  rating DECIMAL,
  run_time INT, -- track length in seconds
);
