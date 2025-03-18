-- I. Movies

-- 1
SELECT name
FROM MOVIESTAR INNER JOIN STARSIN
ON name = starname	
WHERE gender = 'M' AND movietitle = 'The Usual Suspects'

-- 2
SELECT DISTINCT starname
FROM STARSIN INNER JOIN MOVIE
ON movieyear = year
WHERE year = 1995 AND studioname = 'MGM'

-- 3
SELECT DISTINCT NAME
FROM MOVIEEXEC INNER JOIN MOVIE
ON cert# = producerc#
WHERE studioname = 'MGM'

-- 4
SELECT mv1.title
FROM MOVIE AS mv1, MOVIE AS mv2
WHERE mv2.title = 'Star Wars' AND mv1.length > mv2.length;

-- 5
SELECT mve1.name
FROM MOVIEEXEC AS mve1, MOVIEEXEC AS mve2
WHERE mve2.name = 'Stephen Spielberg' AND mve1.networth > mve2.networth;






-- II. PC

-- 1
SELECT maker, speed
FROM product INNER JOIN laptop
ON product.model = laptop.model
WHERE laptop.hd >= 9;

-- 2
SELECT laptop.model, price
FROM laptop
INNER JOIN product ON product.model = laptop.model
WHERE maker = 'B'

UNION

SELECT pc.model, price
FROM pc
INNER JOIN product ON product.model = pc.model
WHERE maker = 'B'

UNION

SELECT printer.model, price
FROM printer
INNER JOIN product ON product.model = printer.model
WHERE maker = 'B'

-- 3
SELECT maker
FROM product
INNER JOIN laptop
ON product.model = laptop.model

EXCEPT

SELECT maker
FROM product
INNER JOIN pc
ON product.model = pc.model

-- 4
SELECT DISTINCT pc1.hd
FROM pc AS pc1, pc AS pc2
WHERE pc1.code != pc2.code AND pc1.hd = pc2.hd

-- 5.
SELECT pc1.model, pc2.model
FROM pc AS pc1, pc AS pc2
WHERE pc1.model < pc2.model AND pc1.speed = pc2.speed AND pc1.ram = pc2.ram
ORDER BY pc1.model, pc2.model ASC

-- 6
SELECT DISTINCT pr1.maker
FROM product AS pr1
INNER JOIN pc AS pc1 ON pr1.model = pc1.model
INNER JOIN product AS pr2 ON pr1.maker = pr2.maker
INNER JOIN pc AS pc2 ON pr2.model = pc2.model
WHERE pc1.speed >= 400 
  AND pc2.speed >= 400 
  AND pc1.code != pc2.code;






-- III. Ships

-- 1
SELECT name
FROM SHIPS INNER JOIN CLASSES
ON ships.class = CLASSES.class
WHERE displacement > 50000

-- 2
SELECT ships.name, displacement, numguns
FROM BATTLES 
INNER JOIN OUTCOMES ON OUTCOMES.battle = BATTLES.name
INNER JOIN SHIPS ON SHIPS.name = OUTCOMES.ship
INNER JOIN CLASSES ON CLASSES.class = SHIPS.class
WHERE battle = 'Guadalcanal'

-- 3
SELECT DISTINCT c1.country
FROM CLASSES AS c1, CLASSES AS c2
WHERE c1.type = 'bb' AND c2.type = 'bc' AND c1.country = c2.country

-- 4
SELECT SHIPS.name
FROM OUTCOMES AS o1 
INNER JOIN OUTCOMES AS o2 ON o1.BATTLE != o2.BATTLE OR o1.SHIP != o2.SHIP
INNER JOIN SHIPS ON o1.ship = SHIPS.name AND o2.ship = SHIPS.name
INNER JOIN BATTLES AS b1 ON o1.BATTLE = b1.NAME
INNER JOIN BATTLES AS b2 ON o2.BATTLE = b2.NAME
WHERE o1.RESULT = 'damaged' AND b1.DATE < b2.DATE




