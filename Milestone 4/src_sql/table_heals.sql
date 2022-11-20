CREATE TABLE Heals
	(Cname        CHARACTER(20),
	instanceNum   INTEGER,
    ID            INTEGER,
    EpisodeNumber INTEGER,
	PRIMARY KEY (Cname, instanceNum, EpisodeNumber),
	FOREIGN KEY (Cname)
        REFERENCES ShowCharacter
        ON DELETE CASCADE,
    FOREIGN KEY (ID)
        REFERENCES Pokemon
        ON DELETE CASCADE,
    FOREIGN KEY (instanceNum)
        REFERENCES PokemonIsOfInstance (instanceNum)
        ON DELETE CASCADE,
    FOREIGN KEY (EpisodeNumber)
        REFERENCES Episode
        ON DELETE CASCADE);