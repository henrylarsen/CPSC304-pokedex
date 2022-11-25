CREATE TABLE Heals
	(Cname        CHARACTER(20),
	instanceNum   INTEGER,
    ID            INTEGER,
    EpisodeNumber INTEGER,
	PRIMARY KEY (Cname, instanceNum, ID, EpisodeNumber),
	FOREIGN KEY (Cname)
        REFERENCES Medic
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