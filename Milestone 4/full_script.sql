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





-- INSERT all queries

    -- START insert_attack;
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Gust', 'Flying', 40);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Sand Attack', 'Ground', 0);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Horn Attack', 'Normal', 65);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Tackle', 'Normal', 40);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Peck', 'Flying', 35);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Thunder Shock', 'Electric', 40);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Hypnosis', 'Psychic', 0);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Flamethrower', 'Fire', 90);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Bug Bite', 'Bug', 60);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Struggle', 'Normal', 50);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Bite', 'Dark', 60);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Sing', 'Normal', 0);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Seed Bomb', 'Grass', 80);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Spore', 'Grass', 0);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Thrash', 'Normal', 120);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Teleport', 'Psychic', 0);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Slam', 'Normal', 80);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Bubble Beam', 'Water', 65);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Aurora Beam', 'Ice', 65);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Swords Dance', 'Normal', 0);
        INSERT INTO attack(AttackName, Type, Damage) VALUES ('Transform', 'Normal', 0);

    -- START insert_type;
        INSERT INTO type(TName) VALUES ('Normal');
        INSERT INTO type(TName) VALUES ('Fire');
        INSERT INTO type(TName) VALUES ('Water'); 
        INSERT INTO type(TName) VALUES ('Grass'); 
        INSERT INTO type(TName) VALUES ('Electric'); 
        INSERT INTO type(TName) VALUES ('Ice'); 
        INSERT INTO type(TName) VALUES ('Fighting'); 
        INSERT INTO type(TName) VALUES ('Poison'); 
        INSERT INTO type(TName) VALUES ('Ground'); 
        INSERT INTO type(TName) VALUES ('Flying'); 
        INSERT INTO type(TName) VALUES ('Psychic'); 
        INSERT INTO type(TName) VALUES ('Bug'); 
        INSERT INTO type(TName) VALUES ('Rock'); 
        INSERT INTO type(TName) VALUES ('Ghost'); 
        INSERT INTO type(TName) VALUES ('Dark'); 
        INSERT INTO type(TName) VALUES ('Dragon');
        INSERT INTO type(TName) VALUES ('Steel'); 
        INSERT INTO type(TName) VALUES ('Fairy'); 

    -- START insert_episode;
        set define off

        INSERT INTO episode(title, EpisodeNumber) VALUES ('Pokemon I Choose You!', 1);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Pokemon Emergency!', 2);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Ash Catches a Pokemon', 3);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Challenge of the Samurai', 4);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Showdown in Pewter City', 5);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Clefairy and the Moon Stone', 6);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Water Flowers of Cerulean City', 7);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Path to the Pokemon League', 8);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The School of Hard Knocks', 9);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Bulbasaur and the Hidden Village', 10);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Charmander - The Stray Pokemon', 11);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Here Comes the Squirtle Squad', 12);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Mystery at the Lighthouse', 13);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Electric Shock Showdown', 14);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Battle Aboard the St. Anne', 15);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Pokemon Shipwreck', 16);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Island of the Giant Pokemon', 17);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Beauty and the Beach', 18);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Tentacool & Tentacruel', 19);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Ghost of Maidens Peak', 20);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Bye Bye Butterfree', 21);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Abra and the Psychic Showdown (Part 1)', 22);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Tower of Terror (Part 2)', 23);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Haunter vs. Kadabra (Part 3)', 24);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Primeape Goes Bananas', 25);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Pokemon Scent-sation!', 26);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Hypnos Naptime', 27);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Pokemon Fashion Flas', 28);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Punchy Pokemon', 29);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Sparks Fly for Magnemite', 30);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Dig Those Diglett!', 31);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Ninja-Poké Showdown', 32);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Flame Pokemon-athon!', 33);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Kangaskhan Kid', 34);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Legend of Dratini', 35);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Bridge Bike Gang', 36);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Dittos Mysterious Mansion', 37);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Electric Soldier Porygon', 38);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Pikachus Goodbye', 39);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Battling Eevee Brothers', 40);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Wake Up Snorlax!', 41);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Showdown at Dark City', 42);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The March of the Exeggutor Squad', 43);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Problem with Paras', 44);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Song of Jigglypuff', 45);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Attack of the Prehistoric Pokemon', 46);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('A Chansey Operation', 47);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Holy Matrimony!', 48);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('So Near, Yet So Farfetchd', 49);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Who Gets to Keep Togepi?', 50);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Bulbasaurs Mysterious Garden', 51);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Princess vs. Princess', 52);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Purr-fect Hero', 53);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Case of the K-9 Caper!', 54);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Pokemon Paparazzi', 55);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Ultimate Test', 56);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Breeding Center Secret', 57);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Riddle Me This', 58);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Volcanic Panic', 59);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Beach Blank-Out Blastoise', 60);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Misty Mermaid', 61);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Clefairy Tales', 62);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Battle of the Badge', 63);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Its Mr. Mime Time!', 64);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Holiday Hi-Jynx', 65);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Snow Way Out', 66);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Showdown at the Po-ké Corral', 67);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Evolution Solution', 68);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Pi-Kahuna', 69);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Make Room for Gloom', 70);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Lights, Camera, Quack-tion!', 71);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Go West, Young Meowth', 72);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('To Master the Onixpected!', 73);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Ancient Puzzle of Pokémopolis', 74);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Bad to the Bone!', 75);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('All Fired Up!', 76);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Round One: Begin!', 77);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Fire and Ice', 78);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Fourth Round Rumble', 79);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('A Friend in Deed', 80);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Friend and Foe Alike', 81);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Friends to the End', 82);

    -- START insert_gym;
        INSERT INTO gym(Gname, location, region) VALUES ('Pewter City Gym', 'Pewter City', 'Kanto');
        INSERT INTO gym(Gname, location, region) VALUES ('Cerulean City Gym', 'Cerulean City', 'Kanto');
        INSERT INTO gym(Gname, location, region) VALUES ('Vermilion City Gym', 'Vermilion City', 'Kanto');
        INSERT INTO gym(Gname, location, region) VALUES ('Celadon City Gym', 'Celadon City', 'Kanto');
        INSERT INTO gym(Gname, location, region) VALUES ('Fuchsia City Gym', 'Fuchsia City', 'Kanto');
        INSERT INTO gym(Gname, location, region) VALUES ('Saffron City Gym', 'Saffron City', 'Kanto');
        INSERT INTO gym(Gname, location, region) VALUES ('Cinnabar Island Gym', 'Cinnabar Island', 'Kanto');
        INSERT INTO gym(Gname, location, region) VALUES ('Seafoam Islands Gym', 'Seafoam Islands', 'Kanto');
        INSERT INTO gym(Gname, location, region) VALUES ('Viridian City Gym', 'Viridian City', 'Kanto');

    -- START insert_pokeball;
        INSERT INTO pokeBall(PType) VALUES ('Poké Ball');
        INSERT INTO pokeBall(PType) VALUES ('Great Ball');
        INSERT INTO pokeBall(PType) VALUES ('Ultra Ball');
        INSERT INTO pokeBall(PType) VALUES ('Master Ball');
        INSERT INTO pokeBall(PType) VALUES ('Safari Ball');
        INSERT INTO pokeBall(PType) VALUES ('Level Ball');
        INSERT INTO pokeBall(PType) VALUES ('Lure Ball');
        INSERT INTO pokeBall(PType) VALUES ('Moon Ball');
        INSERT INTO pokeBall(PType) VALUES ('Friend Ball');
        INSERT INTO pokeBall(PType) VALUES ('Love Ball');
        INSERT INTO pokeBall(PType) VALUES ('Heavy Ball');
        INSERT INTO pokeBall(PType) VALUES ('Fast Ball');
        INSERT INTO pokeBall(PType) VALUES ('Sport Ball');
        INSERT INTO pokeBall(PType) VALUES ('Premier Ball');
        INSERT INTO pokeBall(PType) VALUES ('Repeat Ball');
        INSERT INTO pokeBall(PType) VALUES ('Timer Ball');
        INSERT INTO pokeBall(PType) VALUES ('Nest Ball');
        INSERT INTO pokeBall(PType) VALUES ('Net Ball');
        INSERT INTO pokeBall(PType) VALUES ('Dive Ball');
        INSERT INTO pokeBall(PType) VALUES ('Luxury Ball');
        INSERT INTO pokeBall(PType) VALUES ('Heal Ball');
        INSERT INTO pokeBall(PType) VALUES ('Quick Ball');
        INSERT INTO pokeBall(PType) VALUES ('Dusk Ball');
        INSERT INTO pokeBall(PType) VALUES ('Cherish Ball');
        INSERT INTO pokeBall(PType) VALUES ('Park Ball');
        INSERT INTO pokeBall(PType) VALUES ('Dream Ball');
        INSERT INTO pokeBall(PType) VALUES ('Beast Ball');

    -- START insert_pokemon;
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (1,0.7,6.9,'Bulbasaur','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (2,1,13,'Ivysaur','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (3,2,100,'Venusaur','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (4,0.6,8.5,'Charmander','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (5,1.1,19,'Charmeleon','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (6,1.7,90.5,'Charizard','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (7,0.5,9,'Squirtle','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (8,1,22.5,'Wartortle','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (9,1.6,85.5,'Blastoise','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (10,0.3,2.9,'Caterpie','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (11,0.7,9.9,'Metapod','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (12,1.1,32,'Butterfree','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (13,0.3,3.2,'Weedle','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (14,0.6,10,'Kakuna','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (15,1,29.5,'Beedrill','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (16,0.3,1.8,'Pidgey','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (17,1.1,30,'Pidgeotto','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (18,1.5,39.5,'Pidgeot','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (19,0.3,3.5,'Rattata','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (20,0.6,18.1,'Raticate','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (21,0.3,2,'Spearow','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (22,1.2,38,'Fearow','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (23,2,6.9,'Ekans','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (24,3.5,65,'Arbok','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (25,0.4,6,'Pikachu','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (26,0.7,30,'Raichu','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (27,0.7,12,'Sandshrew','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (28,1,29.5,'Sandslash','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (29,0.4,7,'Nidoran F','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (30,0.8,20,'Nidorina','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (31,1.3,60,'Nidoqueen','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (32,0.5,9,'Nidoran M','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (33,0.9,19.5,'Nidorino','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (34,1.4,62,'Nidoking','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (35,0.6,7.5,'Clefairy','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (36,1.3,40,'Clefable','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (37,0.3,9.9,'Vulpix','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (38,1,20,'Ninetales','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (39,0.5,5.5,'Jigglypuff','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (40,1,12,'Wigglytuff','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (41,0.8,7.5,'Zubat','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (42,1.6,55,'Golbat','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (43,0.5,5.4,'Oddish','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (44,0.8,8.6,'Gloom','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (45,1.2,18.6,'Vileplume','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (46,0.3,5.4,'Paras','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (47,1,29.5,'Parasect','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (48,1,30,'Venonat','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (49,1.5,12.5,'Venomoth','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (50,0.2,0.8,'Diglett','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (51,0.6,33.3,'Dugtrio','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (52,0.3,2.3,'Meowth','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (53,1,32,'Persian','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (54,0.8,19.6,'Psyduck','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (55,1.7,76.6,'Golduck','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (56,0.5,28,'Mankey','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (57,1,32,'Primeape','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (58,0.7,19,'Growlithe','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (59,1.9,155,'Arcanine','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (60,0.6,12.4,'Poliwag','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (61,1,20,'Poliwhirl','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (62,1.3,54,'Poliwrath','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (63,0.9,19.5,'Abra','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (64,1.3,56.5,'Kadabra','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (65,1.5,48,'Alakazam','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (66,0.8,19.5,'Machop','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (67,1.5,70.5,'Machoke','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (68,1.6,130,'Machamp','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (69,0.7,4,'Bellsprout','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (70,1,6.4,'Weepinbell','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (71,1.7,15.5,'Victreebel','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (72,0.9,45.5,'Tentacool','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (73,1.6,55,'Tentacruel','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (74,0.3,20,'Geodude','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (75,1,105,'Graveler','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (76,1.3,300,'Golem','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (77,1,30,'Ponyta','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (78,1.7,95,'Rapidash','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (79,1.2,36,'Slowpoke','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (80,1.6,78.5,'Slowbro','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (81,0.3,6,'Magnemite','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (82,1,60,'Magneton','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (83,0.8,15,'Farfetch''d','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (84,1.4,39.2,'Doduo','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (85,1.8,85.2,'Dodrio','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (86,1.1,90,'Seel','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (87,1.7,120,'Dewgong','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (88,0.9,30,'Grimer','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (89,1.2,30,'Muk','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (90,0.3,4,'Shellder','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (91,1.5,132.5,'Cloyster','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (92,1.3,0.1,'Gastly','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (93,1.6,0.1,'Haunter','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (94,1.5,40.5,'Gengar','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (95,8.8,210,'Onix','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (96,1,32.4,'Drowzee','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (97,1.6,75.6,'Hypno','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (98,0.4,6.5,'Krabby','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (99,1.3,60,'Kingler','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (100,0.5,10.4,'Voltorb','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (101,1.2,66.6,'Electrode','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (102,0.4,2.5,'Exeggcute','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (103,2,120,'Exeggutor','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (104,0.4,6.5,'Cubone','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (105,1,44.9,'Marowak','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (106,1.5,49.8,'Hitmonlee','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (107,1.4,50.2,'Hitmonchan','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (108,1.2,65.5,'Lickitung','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (109,0.6,1,'Koffing','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (110,1.2,9.5,'Weezing','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (111,1,115,'Rhyhorn','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (112,1.9,120,'Rhydon','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (113,1.1,34.6,'Chansey','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (114,1,35,'Tangela','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (115,2.2,80,'Kangaskhan','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (116,0.4,8,'Horsea','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (117,1.2,25,'Seadra','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (118,0.6,15,'Goldeen','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (119,1.3,39,'Seaking','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (120,0.8,34.5,'Staryu','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (121,1.1,80,'Starmie','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (122,1.3,54.5,'Mr. Mime','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (123,1.5,56,'Scyther','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (124,1.4,40.6,'Jynx','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (125,1.1,30,'Electabuzz','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (126,1.3,44.5,'Magmar','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (127,1.5,55,'Pinsir','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (128,1.4,88.4,'Tauros','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (129,0.9,10,'Magikarp','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (130,6.5,235,'Gyarados','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (131,2.5,220,'Lapras','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (132,0.3,4,'Ditto','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (133,0.3,6.5,'Eevee','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (134,1,29,'Vaporeon','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (135,0.8,24.5,'Jolteon','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (136,0.9,25,'Flareon','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (137,0.8,36.5,'Porygon','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (138,0.4,7.5,'Omanyte','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (139,1,35,'Omastar','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (140,0.5,11.5,'Kabuto','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (141,1.3,40.5,'Kabutops','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (142,1.8,59,'Aerodactyl','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (143,2.1,460,'Snorlax','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (144,1.7,55.4,'Articuno','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (145,1.6,52.6,'Zapdos','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (146,2,60,'Moltres','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (147,1.8,3.3,'Dratini','SMALL');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (148,4,16.5,'Dragonair','MEDIUM');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (149,2.2,210,'Dragonite','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (150,2,122,'Mewtwo','LARGE');
        INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (151,0.4,4,'Mew','SMALL');

    -- START insert_showCharacter;


    -- START insert_trainer;
    -- START insert_badGuy;
    -- START insert_hasAttack;
    -- START insert_hasWeakness;
    -- START insert_isType;
    -- START insert_pokemonIsOfInstance;

    -- START insert_battleAt;
    -- START insert_trainsAt;
    -- START insert_buys;
    -- START insert_catches;
    -- START insert_heals;
    -- START insert_medic;