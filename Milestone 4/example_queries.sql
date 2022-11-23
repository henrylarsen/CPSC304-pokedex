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

-- AGGREGATION USING HAVING
-- Select Type Names where > 10 pokemon have type. 
SELECT TName
FROM isType
GROUP BY TName
HAVING COUNT(TName) > 20;

-- DIVISION






