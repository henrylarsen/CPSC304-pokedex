CREATE TABLE hasWeakness
	(id		INTEGER,
	TName		CHARACTER(20),
	PRIMARY KEY (id, TName),
	FOREIGN KEY (id)
    REFERENCES Pokemon
    ON DELETE CASCADE,
    FOREIGN KEY (TName)
    REFERENCES Type
    ON DELETE CASCADE);