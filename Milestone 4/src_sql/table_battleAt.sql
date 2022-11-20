CREATE TABLE BattleAt
	(CnameT        CHARACTER(20),
    CnameB         CHARACTER(20),
    Gname         CHARACTER(20),
    EpisodeNumber INTEGER,
	PRIMARY KEY (CnameT, CnameB, Gname, EpisodeNumber),
	FOREIGN KEY (CnameT)
        REFERENCES Trainer (CName)
	    ON DELETE CASCADE,
    FOREIGN KEY (CNameB)
        REFERENCES BadGuy (CName)
        ON DELETE CASCADE,
    FOREIGN KEY (Gname)
        REFERENCES Gym
        ON DELETE CASCADE, 
    FOREIGN KEY (EpisodeNumber)
        REFERENCES Episode
	    ON DELETE CASCADE
    );
