SELECT id
FROM isType I
WHERE NOT EXISTS
        ((SELECT TName
        FROM Type T
        WHERE TName = 'Grass' OR TName = 'Poison') -- Types Grass and Poison
        EXCEPT
        (SELECT TName 
        FROM isType I2
        WHERE I.TName = I2.TName));

        -- SELECT TName
        -- FROM Type T
        -- WHERE TName = 'Grass' OR TName = 'Poison';

        -- SELECT TName
        -- FROM isType I2
        -- WHERE I2.id = I.id