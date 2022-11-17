CREATE TABLE HasAttack
	(AttackName        CHARACTER(20),
    Id                 INTEGER,
	PRIMARY KEY (AttackName, id),
	FOREIGN KEY (AttackName)
    REFERENCES Attack
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id)
    REFERENCES Pokemon
    ON DELETE CASCADE
    ON UPDATE CASCADE);