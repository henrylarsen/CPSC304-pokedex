CREATE TABLE Catches
	(instanceNum	 INTEGER,
	CName         CHARACTER(20),
	EpisodeNumber INTEGER,
	PType         CHARACTER(20),
	PRIMARY KEY (instanceNum, CName, EpisodeNumber, PType),
	FOREIGN KEY (instanceNum)
  		REFERENCES PokemonIsOfInstance (instanceNum)
    	ON DELETE CASCADE,
    FOREIGN KEY (CName)
  		REFERENCES ShowCharacter
    	ON DELETE CASCADE,
    FOREIGN KEY (EpisodeNumber)
  	REFERENCES Episode
    ON DELETE CASCADE,
    FOREIGN KEY (PType)
  	REFERENCES Pokeball
    ON DELETE CASCADE);