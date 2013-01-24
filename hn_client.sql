CREATE TABLE stories (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  -- MZ: Uploader should be a FK pointing @ a User
  -- `user_id`
  uploader VARCHAR(255),
  points INTEGER,
  url VARCHAR(255)
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY,
  -- MZ: A railsy convention is to name the FK `other_model_id` so in this case, `author` should
  -- be `user_id`
  -- MZ: the FK declaration is good but not absolutely necessary
  -- as this constraint will also be handled @ the application layer
  -- MZ: Maybe just incomplete but there's no TEXT field for storing the content
  -- of a comment
  FOREIGN KEY (author) REFERENCES user(id),
  FOREIGN KEY (story_id) REFERENCES stories(id)
);

# MZ: A good convention is to pluralize all table names
CREATE TABLE user (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  karma INTEGER
);