-- I. Movies

-- 1.
SELECT ADDRESS
FROM STUDIO
WHERE NAME = 'Disney'

-- 2.
SELECT BIRTHDATE
FROM MOVIESTAR
WHERE NAME = 'Jack Nicholson'

-- 3.
SELECT STARNAME
FROM STARSIN
WHERE MOVIEYEAR = 1980 OR (MOVIETITLE LIKE '%Knight%');

-- 4.
SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > 10000000

-- 5.
SELECT NAME
FROM MOVIESTAR
WHERE GENDER = 'M' OR ADDRESS = 'Prefect Rd.'






-- II. PC

-- 1.
SELECT MODEL, speed as MHZ, hd as GB
FROM pc
WHERE price < 1200

-- 2.
SELECT DISTINCT MAKER
FROM product
WHERE type = 'printer' 

-- 3.
SELECT MODEL, RAM, SCREEN
FROM laptop
WHERE price > 1000

-- 4.
SELECT *
FROM printer
WHERE color = 'y'

-- 5.
SELECT MODEL, SPEED, HD
FROM pc
WHERE cd IN('12x', '16x') AND price < 2000;






-- III. Ships

-- 1.
SELECT CLASS, COUNTRY
FROM CLASSES
WHERE NUMGUNS < 10

-- 2.
SELECT NAME
FROM SHIPS
WHERE LAUNCHED < 1918

-- 3.
SELECT SHIP, BATTLE
FROM OUTCOMES
WHERE RESULT = 'sunk'

-- 4.
SELECT NAME
FROM SHIPS
WHERE NAME = CLASS

-- 5.
SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%'

-- 6.
SELECT NAME
FROM SHIPS
WHERE NAME LIKE '% %';
