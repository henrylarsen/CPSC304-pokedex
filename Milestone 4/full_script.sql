-- DROP ALL TABLES

    DROP TABLE battleAt;
    DROP TABLE buys;
    DROP TABLE catches;
    DROP TABLE heals;
    DROP TABLE medic;
    DROP TABLE trainsAt;

    DROP TABLE badGuy;
    DROP TABLE hasAttack;
    DROP TABLE hasWeakness;
    DROP TABLE isType;
    DROP TABLE pokemonIsOfInstance;
    DROP TABLE trainer;

    DROP TABLE attack;
    DROP TABLE episode;
    DROP TABLE gym;
    DROP TABLE pokeball;
    DROP TABLE pokemon;
    DROP TABLE showCharacter;
    DROP TABLE type;


-- CREATE ALL TABLES

    -- START table_attack;
        CREATE TABLE Attack
        (AttackName        CHARACTER(20),
        Type               CHARACTER(20),
        Damage             INTEGER,
        PRIMARY KEY (AttackName));

    -- START table_type;
        CREATE TABLE Type
        (TName             CHARACTER(20),
        PRIMARY KEY (TName));

    -- START table_episode;
        CREATE TABLE Episode
        (title	CHARACTER(40),
        EpisodeNumber	INTEGER,
        PRIMARY KEY (EpisodeNumber));

    -- START table_gym;
        CREATE TABLE Gym
        (Gname		CHARACTER(20),
        location	CHARACTER(20),
        region 	CHARACTER(20),
        PRIMARY KEY (Gname));
    
    -- START table_pokeball;
        CREATE TABLE Pokeball
        (PType     CHARACTER(20),
        PRIMARY KEY (PType));

    -- START table_pokemon;
        CREATE TABLE Pokemon
        (id		INTEGER,
        height		NUMERIC,
        weight		NUMERIC,
        PName		CHARACTER(20),
        Psize		CHARACTER(10),
        PRIMARY KEY (id),
        UNIQUE(PName));

    -- START table_showCharacter;
        CREATE TABLE ShowCharacter
        (CName       CHARACTER(20),
        age        INTEGER,
        PRIMARY KEY (CName));

    -- START table_trainer;
        CREATE TABLE Trainer
        (Cname    	CHARACTER(20),
        age     INTEGER,
        PRIMARY KEY (Cname),
        FOREIGN KEY (Cname)
        REFERENCES ShowCharacter
        ON DELETE CASCADE);

    -- START table_badGuy;
        CREATE TABLE BadGuy
        (Cname      CHARACTER(20),
        Affiliation CHARACTER(20),
        PRIMARY KEY (Cname),
        FOREIGN KEY (Cname)
        REFERENCES ShowCharacter
        ON DELETE CASCADE);

    -- START table_hasAttack;
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

    -- START table_hasWeakness;
        CREATE TABLE hasWeakness
        (id		INTEGER,
        TName		CHARACTER(20),
        PRIMARY KEY (id, TName),
        FOREIGN KEY (id)
        REFERENCES Pokemon
        ON DELETE CASCADE,
        FOREIGN KEY (TName)
        REFERENCES Type
        ON DELETE CASCADE);

    -- START table_isType;
        CREATE TABLE isType
        (id		INTEGER,
        TName		CHARACTER(20),
        PRIMARY KEY (id, TName),
        FOREIGN KEY (id)
        REFERENCES Pokemon
        ON DELETE CASCADE,
        FOREIGN KEY (TName)
        REFERENCES Type
        ON DELETE CASCADE);

    -- START table_pokemonIsOfInstance;
        CREATE TABLE PokemonIsOfInstance
        (id		INTEGER,
        instanceNum	INTEGER,
        isKnockedOut	CHARACTER(5),
        PRIMARY KEY (ID, instanceNum),
        FOREIGN KEY (id)
        REFERENCES Pokemon
        ON DELETE CASCADE,
        UNIQUE(instanceNum));

    -- START table_battleAt;
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

    -- START table_trainsAt;
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

    -- START table_buys;
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

    -- START table_catches;
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

    -- START table_heals;
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

    -- START table_medic;
        CREATE TABLE Medic
        (Cname     CHARACTER(20),
        Hospital   CHARACTER(20),
        PRIMARY KEY (Cname),
        FOREIGN KEY (Cname)
        REFERENCES ShowCharacter
        ON DELETE CASCADE);






START insert_all;