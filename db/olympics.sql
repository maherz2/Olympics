DROP TABLE athlete_results;
DROP TABLE team_results;
DROP TABLE team_members;
DROP TABLE events;
DROP TABLE athletes;
DROP TABLE teams;
DROP TABLE nations;
DROP TABLE sports;



CREATE TABLE nations (
  id SERIAL4 primary key,
  name VARCHAR(255),
  continent VARCHAR(255),
  flag_url VARCHAR(255),
  population INT8
);

CREATE TABLE sports (
  id SERIAL4 primary key,
  name VARCHAR(255),
  type VARCHAR(255)
);

CREATE TABLE teams (
  id SERIAL4 primary key,
  name VARCHAR(255),
  nation_id INT4 references nations(id)
);

CREATE TABLE athletes (
  id SERIAL4 primary key,
  name VARCHAR(255),
  dob DATE,
  sex VARCHAR(255),
  height INT4,
  weight INT4,
  nation_id INT4 references nations(id)
);

CREATE TABLE events (
  id SERIAL4 primary key,
  name VARCHAR(255),
  participation_type VARCHAR(255),
  max_capacity INT4,
  world_record VARCHAR(255),
  sport_id INT4 references sports(id)
);

CREATE TABLE team_members (
  id SERIAL4 primary key,
  athlete_id INT4 references athletes(id),
  team_id INT4 references teams(id)
);

CREATE TABLE team_results (
  id SERIAL4 primary key,
  event_id INT4 references events(id),
  team_id INT4 references teams(id),
  measure VARCHAR(255),
  position INT4
);

CREATE TABLE athlete_results (
  id SERIAL4 primary key,
  event_id INT4 references events(id),
  athlete_id INT4 references athletes(id),
  measure VARCHAR(255),
  position INT4
);


