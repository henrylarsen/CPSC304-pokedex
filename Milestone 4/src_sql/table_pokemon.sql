CREATE TABLE Pokemon
	(id		INTEGER,
	height		NUMERIC,
	weight		NUMERIC,
	PName		CHARACTER(20),
	Psize		CHARACTER(10),
	PRIMARY KEY (id),
    UNIQUE(PName));