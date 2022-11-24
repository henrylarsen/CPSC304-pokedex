-- Base for Pokemon insertion
INSERT INTO Pokemon(id,height,weight,Pname,PSize) VALUES (:id, :height, :weight, :PName, :PSize);
-- Note: Pzise can be calculated as follows:
--          weight*heigh < 15 : SMALL
--          15 >= weight*height < 80 : MEDIUM
--          weight*height >= 80 : LARGE


-- Delete Operation: Delete a pokemon
DELETE FROM pokemonIsOfInstance WHERE id = :id, instanceNum = :instanceNum;

-- Update a Pokemon instance isKnockedOut
UPDATE pokemonIsOfInstance SET isKnockedOut = :isKnockedOut WHERE instanceNum = :instanceNum;

-- Selection
SELECT :attribute
FROM :table
WHERE :table.id = :Var1;
-- Note: Not fully sure how you allow the user to chose the table when the Fields would be different
--       It might work if we only allow tables that share a specific attribute (pokemonIsOfInstance, Pokemon,
--       hasWeakness, isType all have 'id')


-- Projection
SELECT :attributes
FROM Pokemon;


-- Join  
SELECT CName
FROM showCharacter INNER JOIN buys
WHERE showCharacter.CName = buys.CName AND buys.PType = :attribute;
-- The idea of this query is that it should return the names of 
-- the showCharacters with the type of pokeball specified.


-- Aggregation using group-by
SELECT Pokemon.Psize, Pokemon.Pname, min(height)
FROM Pokemon
WHERE Pokemon.weight >= 10
GROUP BY Pokemon.Psize;
-- Select Pokemon of minimum height grouped by psize and all under weight specified by user


-- AGGREGATION USING HAVING
-- Select Type Names where > 10 pokemon have type. 
SELECT TName
FROM isType
GROUP BY TName
HAVING COUNT(TName) > 20;


-- Nested aggregation with group by
SELECT COUNT(P.id)
FROM Pokemon P
WHERE P.id IN (
    SELECT T1.id
    FROM isType T1, isType T2
    WHERE T1.id = T2.id and T1.TName != T2.TName)
GROUP BY P.Psize;
--produces the number of small, medium and large pokemon with multiple types


-- DIVISION






