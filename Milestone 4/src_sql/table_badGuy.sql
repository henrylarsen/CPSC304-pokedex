CREATE TABLE BadGuy
	(Cname      CHARACTER(20),
	Affiliation INTEGER,
	PRIMARY KEY (Cname),
	FOREIGN KEY (Cname)
    REFERENCES ShowCharacter
    ON DELETE CASCADE);