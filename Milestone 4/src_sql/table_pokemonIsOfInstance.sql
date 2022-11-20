CREATE TABLE PokemonIsOfInstance
	(id		INTEGER,
	instanceNum	INTEGER,
	isKnockedOut	CHARACTER(5),
	PRIMARY KEY (ID, instanceNum),
    FOREIGN KEY (id)
    REFERENCES Pokemon
    ON DELETE CASCADE,
    UNIQUE(instanceNum));