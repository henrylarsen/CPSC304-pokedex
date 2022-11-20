CREATE TABLE TrainsAt
	(Cname        CHARACTER(20),
    EpisodeNumber INTEGER,
    Gname         CHARACTER(20),
	PRIMARY KEY (Cname,EpisodeNumber, Gname),
	FOREIGN KEY (Cname)
    REFERENCES ShowCharacter
    ON DELETE CASCADE,
    FOREIGN KEY (EpisodeNumber)
    REFERENCES Episode
    ON DELETE CASCADE,
    FOREIGN KEY (Gname)
    REFERENCES Gym
    ON DELETE CASCADE);