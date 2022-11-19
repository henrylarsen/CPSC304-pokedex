CREATE TABLE BattleAt
	(Cname        CHARACTER(20),
    Cname         CHARACTER(20),
    Gname         CHARACTER(20),
    EpisodeNumber INTEGER,
	PRIMARY KEY (Cname,Cname, Gname, EpisodeNumber),
	FOREIGN KEY (Cname)
        REFERENCES Trainer
	    ON DELETE CASCADE
	    ON UPDATE CASCADE,
    FOREIGN KEY (CName)
        REFERENCES BadGuy
        ON DELETE CASCADE
	    ON UPDATE CASCADE,
    FOREIGN KEY (Gname)
        REFERENCES Gym
        ON DELETE CASCADE
	    ON UPDATE CASCADE, 
    FOREIGN KEY (EpisodeNumber)
        REFERENCES Episode (EpisodeNumber)
	    ON DELETE CASCADE
	    ON UPDATE CASCADE
    );
