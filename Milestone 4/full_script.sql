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
        PRIMARY KEY (id, instanceNum),
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

    -- START table_medic;
        CREATE TABLE Medic
        (Cname     CHARACTER(20),
        Hospital   CHARACTER(20),
        PRIMARY KEY (Cname),
        FOREIGN KEY (Cname)
        REFERENCES ShowCharacter
        ON DELETE CASCADE);

    -- START table_heals;
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
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Ninja-Poke Showdown', 32);
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
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Showdown at the Po-ke Corral', 67);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Evolution Solution', 68);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Pi-Kahuna', 69);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Make Room for Gloom', 70);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Lights, Camera, Quack-tion!', 71);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('Go West, Young Meowth', 72);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('To Master the Onixpected!', 73);
        INSERT INTO episode(title, EpisodeNumber) VALUES ('The Ancient Puzzle of Pokemopolis', 74);
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
        INSERT INTO pokeBall(PType) VALUES ('Poke Ball');
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
        INSERT INTO showCharacter(CName, age) VALUES ('Ella', 12); 
        INSERT INTO showCharacter(CName, age) VALUES ('Ash', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Jenna', 13);
        INSERT INTO showCharacter(CName, age) VALUES ('Gabriella', 14);
        INSERT INTO showCharacter(CName, age) VALUES ('Taylor', 15);
        INSERT INTO showCharacter(CName, age) VALUES ('Rihanna', 16);
        INSERT INTO showCharacter(CName, age) VALUES ('Chris', 22);
        INSERT INTO showCharacter(CName, age) VALUES ('Matt', 45);
        INSERT INTO showCharacter(CName, age) VALUES ('Jeffrey', 54);
        INSERT INTO showCharacter(CName, age) VALUES ('Alice', 12);
        INSERT INTO showCharacter(CName, age) VALUES ('Jenkins', 23);
        INSERT INTO showCharacter(CName, age) VALUES ('Katie', 74);
        INSERT INTO showCharacter(CName, age) VALUES ('Danae', 42);
        INSERT INTO showCharacter(CName, age) VALUES ('Holly', 32);
        INSERT INTO showCharacter(CName, age) VALUES ('Erin', 21);
        INSERT INTO showCharacter(CName, age) VALUES ('Amanda', 43);
        INSERT INTO showCharacter(CName, age) VALUES ('Tyrone', 12);
        INSERT INTO showCharacter(CName, age) VALUES ('Tyreese', 13);
        INSERT INTO showCharacter(CName, age) VALUES ('Daquan', 14);
        INSERT INTO showCharacter(CName, age) VALUES ('Charlise', 15);
        INSERT INTO showCharacter(CName, age) VALUES ('Abneet', 16);
        INSERT INTO showCharacter(CName, age) VALUES ('Misty', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Brock', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Officer Jenny', 20);
        INSERT INTO showCharacter(CName, age) VALUES ('Gary', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Ritchie', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Jessie', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('James', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Professor Oak', 40);
        INSERT INTO showCharacter(CName, age) VALUES ('Joy', 22);
        INSERT INTO showCharacter(CName, age) VALUES ('Lt. Surge', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Sabrina', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Erika', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Koga', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Blaine', 10);
        INSERT INTO showCharacter(CName, age) VALUES ('Bruno', 15);

    -- START insert_trainer;
        INSERT INTO trainer(CName, age) VALUES ('Tyrone', 12);
        INSERT INTO trainer(CName, age) VALUES ('Tyreese', 13);
        INSERT INTO trainer(CName, age) VALUES ('Daquan', 14);
        INSERT INTO trainer(CName, age) VALUES ('Charlise', 15);
        INSERT INTO trainer(CName, age) VALUES ('Abneet', 16);
        INSERT INTO trainer(CName, age) VALUES ('Ash', 10);
        INSERT INTO trainer(CName, age) VALUES ('Misty', 10);
        INSERT INTO trainer(CName, age) VALUES ('Ritchie', 10);
        INSERT INTO trainer(CName, age) VALUES ('Jessie', 10);
        INSERT INTO trainer(CName, age) VALUES ('James', 10);
        INSERT INTO trainer(CName, age) VALUES ('Professor Oak', 40);
        INSERT INTO trainer(CName, age) VALUES ('Bruno', 15);


    -- START insert_badGuy;
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Katie', 'Rocket');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Danae', 'Aqua');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Holly', 'Galactic');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Erin', 'Rocket');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Amanda', 'Plasma');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Brock', 'Pewter');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Gary', 'Viridian');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Lt. Surge', 'Vermilion');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Sabrina', 'Saffron');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Erika', 'Celadon');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Koga', 'Fuschia');
        INSERT INTO badGuy(CName, Affiliation) VALUES ('Blaine', 'Cinnabar');

    -- START insert_hasAttack;
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 12);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 16);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 17);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 18);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 41);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 42);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 49);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 144);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Gust', 146);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 16);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 17);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 18);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 27);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 28);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 50);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 51);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 74);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 75);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 76);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 83);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 111);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 112);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 133);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 134);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 136);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 138);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 139);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 140);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sand Attack', 141);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 32);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 33);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 34);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 111);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 112);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 118);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 119);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 128);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 138);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Horn Attack', 139);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 1);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 2);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 3);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 7);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 8);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 9);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 10);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 12);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 16);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 17);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 18);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 19);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 20);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 29);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 30);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 31);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 32);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 33);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 34);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 35);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 36);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 37);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 38);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 48);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 49);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 58);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 59);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 66);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 67);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 68);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 74);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 75);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 76);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 77);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 78);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 79);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 80);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 81);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 82);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 90);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 91);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 95);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 100);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 101);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 106);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 107);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 108);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 109);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 110);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 111);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 112);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 113);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 120);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 121);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 126);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 128);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 129);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 130);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 133);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 134);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 135);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 136);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 137);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Tackle', 143);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 15);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 21);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 22);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 32);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 33);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 34);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 83);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 84);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 85);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 118);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 119);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 144);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 145);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Peck', 146);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 25);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 26);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 74);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 75);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 76);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 81);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 82);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 100);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 101);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 125);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 135);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 137);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thunder Shock', 145);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 38);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 41);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 53);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 54);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 55);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 60);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 61);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 62);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 64);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 65);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 77);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 78);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 92);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 93);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 94);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 96);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 97);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 102);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 103);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 122);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Hypnosis', 144);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 4);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 5);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 6);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 37);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 38);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 58);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 59);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 126);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 136);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Flamethrower', 146);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bug Bite', 10);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bug Bite', 12);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bug Bite', 13);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bug Bite', 15);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bug Bite', 127);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Struggle', 11);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Struggle', 14);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 7);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 8);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 9);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 19);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 20);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 23);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 24);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 29);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 30);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 31);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 41);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 42);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 52);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 53);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 58);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 59);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 88);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 89);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 115);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 130);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 133);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 134);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 135);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 136);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 138);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 139);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 142);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bite', 143);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sing', 35);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sing', 36);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sing', 39);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sing', 40);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sing', 113);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sing', 124);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Sing', 131);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 1);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 2);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 3);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 43);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 44);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 45);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 52);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 53);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 102);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 103);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 114);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 143);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Seed Bomb', 151);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Spore', 46);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Spore', 47);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 34);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 52);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 56);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 57);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 84);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 85);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 104);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 105);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 108);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 124);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 127);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 128);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Thrash', 130);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Teleport', 63);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Teleport', 64);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Teleport', 65);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Teleport', 150);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 23);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 24);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 25);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 26);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 69);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 70);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 71);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 83);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 95);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 98);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 99);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 108);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 114);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 147);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 148);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Slam', 149);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 7);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 8);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 9);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 60);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 61);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 62);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 72);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 73);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 98);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 99);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 116);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 117);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 120);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Bubble Beam', 121);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Aurora Beam', 37);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Aurora Beam', 38);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Aurora Beam', 86);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Aurora Beam', 87);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Aurora Beam', 90);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Aurora Beam', 91);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Aurora Beam', 134);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 20);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 27);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 28);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 71);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 83);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 84);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 85);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 98);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 99);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 105);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 123);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 127);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Swords Dance', 141);

        INSERT INTO hasAttack(AttackName, ID) VALUES ('Transform', 132);
        INSERT INTO hasAttack(AttackName, ID) VALUES ('Transform', 151);

    -- START insert_hasWeakness;
            INSERT INTO hasWeakness(id,TName) VALUES (1,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (2,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (3,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (4,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (5,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (6,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (7,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (8,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (9,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (10,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (11,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (12,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (13,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (14,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (15,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (16,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (17,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (18,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (19,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (20,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (21,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (22,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (23,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (24,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (25,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (26,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (27,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (28,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (29,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (30,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (31,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (32,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (33,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (34,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (35,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (36,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (37,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (38,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (39,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (40,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (41,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (42,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (43,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (44,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (45,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (46,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (47,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (48,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (49,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (50,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (51,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (52,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (53,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (54,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (55,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (56,'Flying');
        INSERT INTO hasWeakness(id,TName) VALUES (57,'Flying');
        INSERT INTO hasWeakness(id,TName) VALUES (58,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (59,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (60,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (61,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (62,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (63,'Bug');
        INSERT INTO hasWeakness(id,TName) VALUES (64,'Bug');
        INSERT INTO hasWeakness(id,TName) VALUES (65,'Bug');
        INSERT INTO hasWeakness(id,TName) VALUES (66,'Flying');
        INSERT INTO hasWeakness(id,TName) VALUES (67,'Flying');
        INSERT INTO hasWeakness(id,TName) VALUES (68,'Flying');
        INSERT INTO hasWeakness(id,TName) VALUES (69,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (70,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (71,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (72,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (73,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (74,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (75,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (76,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (77,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (78,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (79,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (80,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (81,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (82,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (83,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (84,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (85,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (86,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (87,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (88,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (89,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (90,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (91,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (92,'Ghost');
        INSERT INTO hasWeakness(id,TName) VALUES (93,'Ghost');
        INSERT INTO hasWeakness(id,TName) VALUES (94,'Ghost');
        INSERT INTO hasWeakness(id,TName) VALUES (95,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (96,'Bug');
        INSERT INTO hasWeakness(id,TName) VALUES (97,'Bug');
        INSERT INTO hasWeakness(id,TName) VALUES (98,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (99,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (100,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (101,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (102,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (103,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (104,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (105,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (106,'Flying');
        INSERT INTO hasWeakness(id,TName) VALUES (107,'Flying');
        INSERT INTO hasWeakness(id,TName) VALUES (108,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (109,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (110,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (111,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (112,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (113,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (114,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (115,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (116,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (117,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (118,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (119,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (120,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (121,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (122,'Bug');
        INSERT INTO hasWeakness(id,TName) VALUES (123,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (124,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (125,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (126,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (127,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (128,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (129,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (130,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (131,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (132,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (133,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (134,'Electric');
        INSERT INTO hasWeakness(id,TName) VALUES (135,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (136,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (137,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (138,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (139,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (140,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (141,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (142,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (143,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (144,'Fire');
        INSERT INTO hasWeakness(id,TName) VALUES (145,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (146,'Water');
        INSERT INTO hasWeakness(id,TName) VALUES (147,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (148,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (149,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (150,'Bug');
        INSERT INTO hasWeakness(id,TName) VALUES (151,'Bug');

        INSERT INTO hasWeakness(id,TName) VALUES (1,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (2,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (3,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (4,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (5,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (6,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (7,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (8,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (9,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (10,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (11,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (12,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (13,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (14,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (15,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (23,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (24,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (27,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (28,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (29,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (30,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (31,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (32,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (33,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (34,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (37,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (38,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (41,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (42,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (43,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (44,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (45,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (46,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (47,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (48,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (49,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (50,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (51,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (54,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (55,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (56,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (57,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (58,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (59,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (60,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (61,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (62,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (66,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (67,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (68,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (69,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (70,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (71,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (72,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (73,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (74,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (75,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (76,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (77,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (78,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (79,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (80,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (86,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (87,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (88,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (89,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (90,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (91,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (95,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (98,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (99,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (102,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (103,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (104,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (105,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (106,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (107,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (109,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (110,'Psychic');
        INSERT INTO hasWeakness(id,TName) VALUES (111,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (112,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (114,'Ice');
        INSERT INTO hasWeakness(id,TName) VALUES (116,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (117,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (118,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (119,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (120,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (121,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (123,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (124,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (126,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (127,'Poison');
        INSERT INTO hasWeakness(id,TName) VALUES (129,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (130,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (131,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (134,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (136,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (138,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (139,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (140,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (141,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (142,'Grass');
        INSERT INTO hasWeakness(id,TName) VALUES (144,'Fighting');
        INSERT INTO hasWeakness(id,TName) VALUES (146,'Ground');
        INSERT INTO hasWeakness(id,TName) VALUES (147,'Dragon');
        INSERT INTO hasWeakness(id,TName) VALUES (148,'Dragon');
        INSERT INTO hasWeakness(id,TName) VALUES (149,'Dragon');

    -- START insert_isType;
            -- Pokemon's first type
        INSERT INTO isType(id,TName) VALUES (1,'Grass');
        INSERT INTO isType(id,TName) VALUES (2,'Grass');
        INSERT INTO isType(id,TName) VALUES (3,'Grass');
        INSERT INTO isType(id,TName) VALUES (4,'Fire');
        INSERT INTO isType(id,TName) VALUES (5,'Fire');
        INSERT INTO isType(id,TName) VALUES (6,'Fire');
        INSERT INTO isType(id,TName) VALUES (7,'Water');
        INSERT INTO isType(id,TName) VALUES (8,'Water');
        INSERT INTO isType(id,TName) VALUES (9,'Water');
        INSERT INTO isType(id,TName) VALUES (10,'Bug');
        INSERT INTO isType(id,TName) VALUES (11,'Bug');
        INSERT INTO isType(id,TName) VALUES (12,'Bug');
        INSERT INTO isType(id,TName) VALUES (13,'Bug');
        INSERT INTO isType(id,TName) VALUES (14,'Bug');
        INSERT INTO isType(id,TName) VALUES (15,'Bug');
        INSERT INTO isType(id,TName) VALUES (16,'Normal');
        INSERT INTO isType(id,TName) VALUES (17,'Normal');
        INSERT INTO isType(id,TName) VALUES (18,'Normal');
        INSERT INTO isType(id,TName) VALUES (19,'Normal');
        INSERT INTO isType(id,TName) VALUES (20,'Normal');
        INSERT INTO isType(id,TName) VALUES (21,'Normal');
        INSERT INTO isType(id,TName) VALUES (22,'Normal');
        INSERT INTO isType(id,TName) VALUES (23,'Poison');
        INSERT INTO isType(id,TName) VALUES (24,'Poison');
        INSERT INTO isType(id,TName) VALUES (25,'Electric');
        INSERT INTO isType(id,TName) VALUES (26,'Electric');
        INSERT INTO isType(id,TName) VALUES (27,'Ground');
        INSERT INTO isType(id,TName) VALUES (28,'Ground');
        INSERT INTO isType(id,TName) VALUES (29,'Poison');
        INSERT INTO isType(id,TName) VALUES (30,'Poison');
        INSERT INTO isType(id,TName) VALUES (31,'Poison');
        INSERT INTO isType(id,TName) VALUES (32,'Poison');
        INSERT INTO isType(id,TName) VALUES (33,'Poison');
        INSERT INTO isType(id,TName) VALUES (34,'Poison');
        INSERT INTO isType(id,TName) VALUES (35,'Fairy');
        INSERT INTO isType(id,TName) VALUES (36,'Fairy');
        INSERT INTO isType(id,TName) VALUES (37,'Fire');
        INSERT INTO isType(id,TName) VALUES (38,'Fire');
        INSERT INTO isType(id,TName) VALUES (39,'Normal');
        INSERT INTO isType(id,TName) VALUES (40,'Normal');
        INSERT INTO isType(id,TName) VALUES (41,'Poison');
        INSERT INTO isType(id,TName) VALUES (42,'Poison');
        INSERT INTO isType(id,TName) VALUES (43,'Grass');
        INSERT INTO isType(id,TName) VALUES (44,'Grass');
        INSERT INTO isType(id,TName) VALUES (45,'Grass');
        INSERT INTO isType(id,TName) VALUES (46,'Bug');
        INSERT INTO isType(id,TName) VALUES (47,'Bug');
        INSERT INTO isType(id,TName) VALUES (48,'Bug');
        INSERT INTO isType(id,TName) VALUES (49,'Bug');
        INSERT INTO isType(id,TName) VALUES (50,'Ground');
        INSERT INTO isType(id,TName) VALUES (51,'Ground');
        INSERT INTO isType(id,TName) VALUES (52,'Normal');
        INSERT INTO isType(id,TName) VALUES (53,'Normal');
        INSERT INTO isType(id,TName) VALUES (54,'Water');
        INSERT INTO isType(id,TName) VALUES (55,'Water');
        INSERT INTO isType(id,TName) VALUES (56,'Fighting');
        INSERT INTO isType(id,TName) VALUES (57,'Fighting');
        INSERT INTO isType(id,TName) VALUES (58,'Fire');
        INSERT INTO isType(id,TName) VALUES (59,'Fire');
        INSERT INTO isType(id,TName) VALUES (60,'Water');
        INSERT INTO isType(id,TName) VALUES (61,'Water');
        INSERT INTO isType(id,TName) VALUES (62,'Water');
        INSERT INTO isType(id,TName) VALUES (63,'Psychic');
        INSERT INTO isType(id,TName) VALUES (64,'Psychic');
        INSERT INTO isType(id,TName) VALUES (65,'Psychic');
        INSERT INTO isType(id,TName) VALUES (66,'Fighting');
        INSERT INTO isType(id,TName) VALUES (67,'Fighting');
        INSERT INTO isType(id,TName) VALUES (68,'Fighting');
        INSERT INTO isType(id,TName) VALUES (69,'Grass');
        INSERT INTO isType(id,TName) VALUES (70,'Grass');
        INSERT INTO isType(id,TName) VALUES (71,'Grass');
        INSERT INTO isType(id,TName) VALUES (72,'Water');
        INSERT INTO isType(id,TName) VALUES (73,'Water');
        INSERT INTO isType(id,TName) VALUES (74,'Rock');
        INSERT INTO isType(id,TName) VALUES (75,'Rock');
        INSERT INTO isType(id,TName) VALUES (76,'Rock');
        INSERT INTO isType(id,TName) VALUES (77,'Fire');
        INSERT INTO isType(id,TName) VALUES (78,'Fire');
        INSERT INTO isType(id,TName) VALUES (79,'Water');
        INSERT INTO isType(id,TName) VALUES (80,'Water');
        INSERT INTO isType(id,TName) VALUES (81,'Electric');
        INSERT INTO isType(id,TName) VALUES (82,'Electric');
        INSERT INTO isType(id,TName) VALUES (83,'Normal');
        INSERT INTO isType(id,TName) VALUES (84,'Normal');
        INSERT INTO isType(id,TName) VALUES (85,'Normal');
        INSERT INTO isType(id,TName) VALUES (86,'Water');
        INSERT INTO isType(id,TName) VALUES (87,'Water');
        INSERT INTO isType(id,TName) VALUES (88,'Poison');
        INSERT INTO isType(id,TName) VALUES (89,'Poison');
        INSERT INTO isType(id,TName) VALUES (90,'Water');
        INSERT INTO isType(id,TName) VALUES (91,'Water');
        INSERT INTO isType(id,TName) VALUES (92,'Ghost');
        INSERT INTO isType(id,TName) VALUES (93,'Ghost');
        INSERT INTO isType(id,TName) VALUES (94,'Ghost');
        INSERT INTO isType(id,TName) VALUES (95,'Rock');
        INSERT INTO isType(id,TName) VALUES (96,'Psychic');
        INSERT INTO isType(id,TName) VALUES (97,'Psychic');
        INSERT INTO isType(id,TName) VALUES (98,'Water');
        INSERT INTO isType(id,TName) VALUES (99,'Water');
        INSERT INTO isType(id,TName) VALUES (100,'Electric');
        INSERT INTO isType(id,TName) VALUES (101,'Electric');
        INSERT INTO isType(id,TName) VALUES (102,'Grass');
        INSERT INTO isType(id,TName) VALUES (103,'Grass');
        INSERT INTO isType(id,TName) VALUES (104,'Ground');
        INSERT INTO isType(id,TName) VALUES (105,'Ground');
        INSERT INTO isType(id,TName) VALUES (106,'Fighting');
        INSERT INTO isType(id,TName) VALUES (107,'Fighting');
        INSERT INTO isType(id,TName) VALUES (108,'Normal');
        INSERT INTO isType(id,TName) VALUES (109,'Poison');
        INSERT INTO isType(id,TName) VALUES (110,'Poison');
        INSERT INTO isType(id,TName) VALUES (111,'Ground');
        INSERT INTO isType(id,TName) VALUES (112,'Ground');
        INSERT INTO isType(id,TName) VALUES (113,'Normal');
        INSERT INTO isType(id,TName) VALUES (114,'Grass');
        INSERT INTO isType(id,TName) VALUES (115,'Normal');
        INSERT INTO isType(id,TName) VALUES (116,'Water');
        INSERT INTO isType(id,TName) VALUES (117,'Water');
        INSERT INTO isType(id,TName) VALUES (118,'Water');
        INSERT INTO isType(id,TName) VALUES (119,'Water');
        INSERT INTO isType(id,TName) VALUES (120,'Water');
        INSERT INTO isType(id,TName) VALUES (121,'Water');
        INSERT INTO isType(id,TName) VALUES (122,'Psychic');
        INSERT INTO isType(id,TName) VALUES (123,'Bug');
        INSERT INTO isType(id,TName) VALUES (124,'Ice');
        INSERT INTO isType(id,TName) VALUES (125,'Electric');
        INSERT INTO isType(id,TName) VALUES (126,'Fire');
        INSERT INTO isType(id,TName) VALUES (127,'Bug');
        INSERT INTO isType(id,TName) VALUES (128,'Normal');
        INSERT INTO isType(id,TName) VALUES (129,'Water');
        INSERT INTO isType(id,TName) VALUES (130,'Water');
        INSERT INTO isType(id,TName) VALUES (131,'Water');
        INSERT INTO isType(id,TName) VALUES (132,'Normal');
        INSERT INTO isType(id,TName) VALUES (133,'Normal');
        INSERT INTO isType(id,TName) VALUES (134,'Water');
        INSERT INTO isType(id,TName) VALUES (135,'Electric');
        INSERT INTO isType(id,TName) VALUES (136,'Fire');
        INSERT INTO isType(id,TName) VALUES (137,'Normal');
        INSERT INTO isType(id,TName) VALUES (138,'Rock');
        INSERT INTO isType(id,TName) VALUES (139,'Rock');
        INSERT INTO isType(id,TName) VALUES (140,'Rock');
        INSERT INTO isType(id,TName) VALUES (141,'Rock');
        INSERT INTO isType(id,TName) VALUES (142,'Rock');
        INSERT INTO isType(id,TName) VALUES (143,'Normal');
        INSERT INTO isType(id,TName) VALUES (144,'Ice');
        INSERT INTO isType(id,TName) VALUES (145,'Electric');
        INSERT INTO isType(id,TName) VALUES (146,'Fire');
        INSERT INTO isType(id,TName) VALUES (147,'Dragon');
        INSERT INTO isType(id,TName) VALUES (148,'Dragon');
        INSERT INTO isType(id,TName) VALUES (149,'Dragon');
        INSERT INTO isType(id,TName) VALUES (150,'Psychic');
        INSERT INTO isType(id,TName) VALUES (151,'Psychic');

        -- Pokemon's second Type
        INSERT INTO isType(id,TName) VALUES (1,'Poison');
        INSERT INTO isType(id,TName) VALUES (2,'Poison');
        INSERT INTO isType(id,TName) VALUES (3,'Poison');
        INSERT INTO isType(id,TName) VALUES (6,'Flying');
        INSERT INTO isType(id,TName) VALUES (12,'Flying');
        INSERT INTO isType(id,TName) VALUES (13,'Poison');
        INSERT INTO isType(id,TName) VALUES (14,'Poison');
        INSERT INTO isType(id,TName) VALUES (15,'Poison');
        INSERT INTO isType(id,TName) VALUES (16,'Flying');
        INSERT INTO isType(id,TName) VALUES (17,'Flying');
        INSERT INTO isType(id,TName) VALUES (18,'Flying');
        INSERT INTO isType(id,TName) VALUES (21,'Flying');
        INSERT INTO isType(id,TName) VALUES (22,'Flying');
        INSERT INTO isType(id,TName) VALUES (31,'Ground');
        INSERT INTO isType(id,TName) VALUES (34,'Ground');
        INSERT INTO isType(id,TName) VALUES (39,'Fairy');
        INSERT INTO isType(id,TName) VALUES (40,'Fairy');
        INSERT INTO isType(id,TName) VALUES (41,'Flying');
        INSERT INTO isType(id,TName) VALUES (42,'Flying');
        INSERT INTO isType(id,TName) VALUES (43,'Poison');
        INSERT INTO isType(id,TName) VALUES (44,'Poison');
        INSERT INTO isType(id,TName) VALUES (45,'Poison');
        INSERT INTO isType(id,TName) VALUES (46,'Grass');
        INSERT INTO isType(id,TName) VALUES (47,'Grass');
        INSERT INTO isType(id,TName) VALUES (48,'Poison');
        INSERT INTO isType(id,TName) VALUES (49,'Poison');
        INSERT INTO isType(id,TName) VALUES (62,'Fighting');
        INSERT INTO isType(id,TName) VALUES (69,'Poison');
        INSERT INTO isType(id,TName) VALUES (70,'Poison');
        INSERT INTO isType(id,TName) VALUES (71,'Poison');
        INSERT INTO isType(id,TName) VALUES (72,'Poison');
        INSERT INTO isType(id,TName) VALUES (73,'Poison');
        INSERT INTO isType(id,TName) VALUES (74,'Ground');
        INSERT INTO isType(id,TName) VALUES (75,'Ground');
        INSERT INTO isType(id,TName) VALUES (76,'Ground');
        INSERT INTO isType(id,TName) VALUES (79,'Psychic');
        INSERT INTO isType(id,TName) VALUES (80,'Psychic');
        INSERT INTO isType(id,TName) VALUES (81,'Steel');
        INSERT INTO isType(id,TName) VALUES (82,'Steel');
        INSERT INTO isType(id,TName) VALUES (83,'Flying');
        INSERT INTO isType(id,TName) VALUES (84,'Flying');
        INSERT INTO isType(id,TName) VALUES (85,'Flying');
        INSERT INTO isType(id,TName) VALUES (87,'Ice');
        INSERT INTO isType(id,TName) VALUES (91,'Ice');
        INSERT INTO isType(id,TName) VALUES (92,'Poison');
        INSERT INTO isType(id,TName) VALUES (93,'Poison');
        INSERT INTO isType(id,TName) VALUES (94,'Poison');
        INSERT INTO isType(id,TName) VALUES (95,'Ground');
        INSERT INTO isType(id,TName) VALUES (102,'Psychic');
        INSERT INTO isType(id,TName) VALUES (103,'Psychic');
        INSERT INTO isType(id,TName) VALUES (111,'Rock');
        INSERT INTO isType(id,TName) VALUES (112,'Rock');
        INSERT INTO isType(id,TName) VALUES (121,'Psychic');
        INSERT INTO isType(id,TName) VALUES (122,'Fairy');
        INSERT INTO isType(id,TName) VALUES (123,'Flying');
        INSERT INTO isType(id,TName) VALUES (124,'Psychic');
        INSERT INTO isType(id,TName) VALUES (127,'Flying');
        INSERT INTO isType(id,TName) VALUES (130,'Flying');
        INSERT INTO isType(id,TName) VALUES (131,'Ice');
        INSERT INTO isType(id,TName) VALUES (138,'Water');
        INSERT INTO isType(id,TName) VALUES (139,'Water');
        INSERT INTO isType(id,TName) VALUES (140,'Water');
        INSERT INTO isType(id,TName) VALUES (141,'Water');
        INSERT INTO isType(id,TName) VALUES (142,'Flying');
        INSERT INTO isType(id,TName) VALUES (144,'Flying');
        INSERT INTO isType(id,TName) VALUES (145,'Flying');
        INSERT INTO isType(id,TName) VALUES (146,'Flying');
        INSERT INTO isType(id,TName) VALUES (149,'Flying');

    -- START insert_pokemonIsOfInstance;
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (25, 39, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (10, 40, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (17, 41, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (41, 42, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (1, 43, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (4, 44, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (98, 45, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (116, 46, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (57, 47, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (54, 48, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (89, 49, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 1, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 2, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 3, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 4, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 5, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 6, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 7, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 8, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 9, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 10, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 11, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 12, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 13, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 14, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 15, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 16, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 17, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 18, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 19, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 20, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 21, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 22, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 23, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 24, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 25, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 26, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 27, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 28, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 29, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (128, 30, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (108, 31, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (90, 32, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (95, 33, 'no');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (147, 34, 'yes');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (148, 35, 'yes');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (149, 36, 'yes');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (150, 37, 'yes');
        INSERT INTO pokemonIsOfInstance(id,instanceNum,isKnockedOut) VALUES (151, 38, 'yes');

    -- START insert_battleAt;
        INSERT INTO battleAt(CnameT, CnameB, Gname, EpisodeNumber) VALUES ('Ash', 'Brock', 'Pewter City Gym', 5);
        INSERT INTO battleAt(CnameT, CnameB, Gname, EpisodeNumber) VALUES ('Ash', 'Lt. Surge', 'Vermilion City Gym', 14);
        INSERT INTO battleAt(CnameT, CnameB, Gname, EpisodeNumber) VALUES ('Ash', 'Sabrina', 'Saffron City Gym', 22);
        INSERT INTO battleAt(CnameT, CnameB, Gname, EpisodeNumber) VALUES ('Ash', 'Erika', 'Celadon City Gym', 26);
        INSERT INTO battleAt(CnameT, CnameB, Gname, EpisodeNumber) VALUES ('Ash', 'Koga', 'Fuchsia City Gym', 32);
        INSERT INTO battleAt(CnameT, CnameB, Gname, EpisodeNumber) VALUES ('Ash', 'Blaine', 'Cinnabar Island Gym', 67);

    -- START insert_trainsAt;
        INSERT INTO trainsAt(Cname, EpisodeNumber, Gname) VALUES ('Ash', 5, 'Pewter City Gym');
        INSERT INTO trainsAt(Cname, EpisodeNumber, Gname) VALUES ('Ash', 14, 'Vermilion City Gym');
        INSERT INTO trainsAt(Cname, EpisodeNumber, Gname) VALUES ('Ash', 22, 'Saffron City Gym');
        INSERT INTO trainsAt(Cname, EpisodeNumber, Gname) VALUES ('Ash', 59, 'Cinnabar Island Gym');
        INSERT INTO trainsAt(Cname, EpisodeNumber, Gname) VALUES ('Ash', 50, 'Cinnabar Island Gym');
        INSERT INTO trainsAt(Cname, EpisodeNumber, Gname) VALUES ('Brock', 50, 'Cinnabar Island Gym');
        INSERT INTO trainsAt(Cname, EpisodeNumber, Gname) VALUES ('Misty', 50, 'Cinnabar Island Gym');
    
    -- START insert_buys;
        INSERT INTO buys(PType, EpisodeNumber, Cname) VALUES ('Poke Ball', 1, 'Ash');
        INSERT INTO buys(PType, EpisodeNumber, Cname) VALUES ('Safari Ball', 35, 'Ash');
        INSERT INTO buys(PType, EpisodeNumber, Cname) VALUES ('Love Ball', 80, 'Tyreese');
        INSERT INTO buys(PType, EpisodeNumber, Cname) VALUES ('Fast Ball', 81, 'Abneet');
        INSERT INTO buys(PType, EpisodeNumber, Cname) VALUES ('Timer Ball', 82, 'Daquan');
        INSERT INTO buys(PType, EpisodeNumber, Cname) VALUES ('Luxury Ball', 79, 'Tyrone');

    -- START insert_catches;
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 3, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 4, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 5, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Brock', 6, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 10, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 11, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 13, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Misty', 19, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 25, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Misty', 27, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 30, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (2, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (3, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (4, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (5, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (6, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (7, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (8, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (9, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (10, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (11, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (12, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (13, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (14, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (15, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (16, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (17, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (18, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (19, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (20, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (21, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (22, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (23, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (24, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (25, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (26, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (27, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (28, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (29, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (30, 'Ash', 35, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Jessie', 52, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Jessie', 68, 'Poke Ball');
        INSERT INTO catches(instanceNum, CName, EpisodeNumber, PType) VALUES (1, 'Bruno', 71, 'Poke Ball');

    -- START insert_medic;
        INSERT INTO medic(CName, Hospital) VALUES ('Chris', 'Hospital6');
        INSERT INTO medic(CName, Hospital) VALUES ('Matt', 'Hospital2');
        INSERT INTO medic(CName, Hospital) VALUES ('Jeffrey', 'Hospital3');
        INSERT INTO medic(CName, Hospital) VALUES ('Alice', 'Hospital4');
        INSERT INTO medic(CName, Hospital) VALUES ('Jenkins', 'Hospital5');
        INSERT INTO medic(CName, Hospital) VALUES ('Joy', 'Hospital1');


    -- START insert_heals;
        INSERT INTO heals(CName,instanceNum,ID,EpisodeNumber) VALUES ('Joy', 1, 25, 82);
        INSERT INTO heals(CName,instanceNum,ID,EpisodeNumber) VALUES ('Joy', 34, 147, 82);
        INSERT INTO heals(CName,instanceNum,ID,EpisodeNumber) VALUES ('Joy', 35, 148, 82);
        INSERT INTO heals(CName,instanceNum,ID,EpisodeNumber) VALUES ('Joy', 36, 149, 82);
        INSERT INTO heals(CName,instanceNum,ID,EpisodeNumber) VALUES ('Joy', 37, 150, 82);
        INSERT INTO heals(CName,instanceNum,ID,EpisodeNumber) VALUES ('Joy', 38, 151, 82);
        
    