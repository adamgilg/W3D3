CREATE TABLE stories (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  uploader VARCHAR(255),
  points INTEGER,
  url VARCHAR(255)
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY,
  FOREIGN KEY (author) REFERENCES user(id),
  FOREIGN KEY (story_id) REFERENCES stories(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  karma INTEGER
);