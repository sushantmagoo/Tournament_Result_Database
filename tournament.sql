-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- created database named 'tournament'
CREATE DATABASE tournament;

-- connected to database
\c tournament;

-- created a table named 'Player' having id and name
CREATE TABLE Player(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

-- created a table named 'Match' having id, win and loss
CREATE TABLE Match(
	id SERIAL PRIMARY KEY,
	win INT REFERENCES Player(id),
	loss INT REFERENCES Player(id)
);

-- created a view named 'Standing' having id, name, wins and losses
CREATE VIEW Standing AS
  SELECT Player.id AS id, Player.name AS name,
    (SELECT count(*) FROM Match AS num WHERE num.win = Player.id) AS wins,
    (SELECT count(*) FROM Match AS num WHERE num.loss = Player.id) AS losses
  FROM Player
  ORDER BY wins DESC;