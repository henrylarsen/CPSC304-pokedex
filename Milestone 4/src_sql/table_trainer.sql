CREATE TABLE Trainer
	(Cname    	CHARACTER(20),
	age     INTEGER,
	PRIMARY KEY (Cname),
	FOREIGN KEY (Cname)
    REFERENCES ShowCharacter
    ON DELETE CASCADE);