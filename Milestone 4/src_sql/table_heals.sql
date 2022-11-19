CREATE TABLE Heals
	(Cname        CHARACTER(20),
	instanceNum   INTEGER,
    EpisodeNumber INTEGER,
	PRIMARY KEY (Cname,instanceNum, EpisodeNumber),
	FOREIGN KEY (Cname)
    REFERENCES ShowCharacter
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (ID)
    REFERENCES Pokemon
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (InstanceNum)
    REFERENCES PokemonIsOfInstance
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (EpisodeNumber)
    REFERENCES Episode
    ON DELETE CASCADE
    ON UPDATE CASCADE);