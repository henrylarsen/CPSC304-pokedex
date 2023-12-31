CREATE TABLE Buys
	(PType        CHARACTER(20),
    EpisodeNumber INTEGER,
    Cname         CHARACTER(20),
	PRIMARY KEY (Cname,PType, EpisodeNumber),
	FOREIGN KEY (Cname)
        REFERENCES ShowCharacter
        ON DELETE CASCADE,
    FOREIGN KEY (PType)
        REFERENCES Pokeball
        ON DELETE CASCADE,
    FOREIGN KEY (EpisodeNumber)
    REFERENCES Episode
    ON DELETE CASCADE);