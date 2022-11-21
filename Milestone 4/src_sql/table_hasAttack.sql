CREATE TABLE HasAttack
	(AttackName        CHARACTER(20),
    Id                 INTEGER,
	PRIMARY KEY (AttackName, Id),
	FOREIGN KEY (AttackName)
    REFERENCES Attack
    ON DELETE CASCADE,
    FOREIGN KEY (id)
    REFERENCES Pokemon
    ON DELETE CASCADE);