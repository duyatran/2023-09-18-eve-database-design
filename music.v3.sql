-- Entity relation requirements:
--    - One album may contain many songs
--    - One song may belong to many albums
--    - One artist may have many albums
-- NEW: One album may belong to many artists

CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  release_date DATE,
  genre VARCHAR(50),

  -- Auditing requirements
  created_at TIMESTAMP DEFAULT NOW()
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE songs (
  id SERIAL PRIMARY KEY,
  track_number INT,
  song_name VARCHAR(500),
  rating DECIMAL,
  run_time INT
);

CREATE TABLE albums_songs (
  song_id INT REFERENCES albums(id),
  album_id INT REFERENCES albums(id)
)

CREATE TABLE artists_albums (
  artist_id INT REFERENCES artists(id),
  album_id INT REFERENCES albums(id)
)