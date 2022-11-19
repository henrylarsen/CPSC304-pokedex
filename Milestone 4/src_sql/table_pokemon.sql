CREATE TABLE Pokemon
	(id		INTEGER,
	height		INTEGER,
	weight		INTEGER,
	category	CHARACTER(20),
	PName		CHARACTER(20),
	Psize		CHARACTER(10),
	PRIMARY KEY (id),
    UNIQUE(PName));