CREATE TABLE BadGuy
	(Cname      CHARACTER(20),
	Affiliation CHARACTER(20),
	PRIMARY KEY (Cname),
	FOREIGN KEY (Cname)
    REFERENCES ShowCharacter
    ON DELETE CASCADE);