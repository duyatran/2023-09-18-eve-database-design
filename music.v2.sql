-- Entity relation requirements:
--   - One album may contain many songs
--   - One song may belong to many albums
--   - One artist may have many albums
--   - One album may belong to only one artist

CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY, -- BIGSERIAL for production apps
  name TEXT NOT NULL -- NOT NULL is a good default check
  release_date DATE,
  genre VARCHAR(50),

  -- FKs
  artist_id INT REFERENCES artists(id),

  -- Auditing requirements
  created_at TIMESTAMP DEFAULT NOW() -- Give default values if possible
  updated_at TIMESTAMP DEFAULT NOW() -- Give default values if possible
);

CREATE TABLE songs (
  id SERIAL PRIMARY KEY,
  track_number INT,
  name VARCHAR(500) NOT NULL,
  rating DECIMAL,
  run_time INT
);

CREATE TABLE albums_songs (
  song_id INT REFERENCES albums(id),
  album_id INT REFERENCES albums(id)
)
