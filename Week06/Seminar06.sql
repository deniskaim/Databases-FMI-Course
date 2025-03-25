
-- I. Movies

-- 1.
SELECT title, year, length
FROM MOVIE
WHERE (length > 120 or length IS NULL) AND year < 2000;

-- 2.
SELECT name, gender
FROM MOVIESTAR
WHERE name LIKE 'J%' AND BIRTHDATE > 1948
ORDER BY name DESC;

-- 3.
SELECT studioname, COUNT(DISTINCT STARNAME) as num_actors
FROM MOVIE JOIN STARSIN ON title = movietitle AND year = movieyear
GROUP BY studioname

-- 4.
SELECT name, COUNT(movietitle) as num_movies
FROM MOVIESTAR LEFT JOIN STARSIN ON name = starname
GROUP BY name

-- 5.
SELECT studioname, title, year
FROM MOVIE mov
WHERE year >= ALL (SELECT year FROM MOVIE WHERE studioname = mov.studioname)

-- 6.
SELECT name
FROM MOVIESTAR
WHERE gender = 'M' AND BIRTHDATE >= ALL (SELECT BIRTHDATE FROM MOVIESTAR WHERE gender = 'M');

-- 7.
SELECT studioname, starname, COUNT(starname) as num_movies
FROM MOVIE m JOIN STARSIN ON title = movietitle AND year = movieyear
GROUP BY studioname, starname
HAVING COUNT(starname) >= ALL (SELECT COUNT(starname) FROM MOVIE JOIN STARSIN ON title = movietitle AND year = movieyear
GROUP BY studioname, starname HAVING studioname = m.studioname);



-- 8.
SELECT movietitle, movieyear, COUNT(starname) as num_actors
FROM MOVIE JOIN STARSIN ON title = movietitle AND year = movieyear
GROUP BY movietitle, movieyear
HAVING COUNT(starname) > 2






-- II. Ships

-- 1.
SELECT DISTINCT ship
FROM OUTCOMES
WHERE ship LIKE 'K%' OR ship LIKE 'C%'

-- 2.

SELECT DISTINCT name, country
FROM SHIPS JOIN CLASSES ON ships.class = classes.class
LEFT JOIN OUTCOMES ON ships.name = outcomes.ship
WHERE RESULT IS NULL OR RESULT != 'sunk'

-- 3.

SELECT country, COUNT(RESULT) as num_sunk_ships
FROM CLASSES LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
LEFT JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE result = 'sunk' OR result IS NULL
GROUP BY country

-- 4.
SELECT battle
FROM OUTCOMES
GROUP BY battle
HAVING COUNT(SHIP) > (SELECT COUNT(SHIP) FROM OUTCOMES WHERE battle = 'Guadalcanal');

-- 5.
SELECT battle
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
GROUP BY battle
HAVING COUNT(COUNTRY) > (SELECT COUNT(COUNTRY)FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP WHERE battle = 'Surigao Strait');

-- 6.
SELECT name, displacement, numGuns
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
WHERE displacement <= ALL (SELECT DISPLACEMENT FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS)
	AND numguns >= ALL (SELECT NUMGUNS FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS 
	WHERE displacement <= ALL (SELECT DISPLACEMENT FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS));

-- 7.
SELECT COUNT(ship) as num_ships
FROM OUTCOMES t JOIN BATTLES ON t.BATTLE = BATTLES.NAME
WHERE t.RESULT = 'damaged' and date < ANY (SELECT DATE FROM OUTCOMES JOIN BATTLES ON OUTCOMES.BATTLE = BATTLES.NAME 
		WHERE ship = t.ship);

-- 8.
SELECT ship
FROM OUTCOMES t1 JOIN BATTLES ON t1.BATTLE = BATTLES.NAME
WHERE t1.RESULT = 'damaged' AND 
		date < ANY (SELECT DATE 
					FROM OUTCOMES t2 JOIN BATTLES ON t2.BATTLE = BATTLES.NAME
					WHERE t1.ship = t2.ship AND t2.result = 'ok' AND 
						(SELECT COUNT(SHIP)
						FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
						JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
						WHERE battle = t1.battle) < 
						(SELECT COUNT(SHIP)
						FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
						JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
						WHERE battle = t2.battle));






-- III. PC

-- 1.
SELECT model, code, screen
FROM laptop
WHERE screen = 15 OR screen = 11

-- 2.
SELECT DISTINCT pc.model
FROM pc JOIN product p ON pc.model = p.model
WHERE price < (SELECT price FROM laptop JOIN product ON laptop.model = product.model WHERE maker = p.maker 
				AND price <= ALL (SELECT price FROM laptop JOIN product ON laptop.model = product.model WHERE maker = p.maker));

-- 3.
SELECT pc.model, AVG(price) as avg_price
FROM pc JOIN product p ON pc.model = p.model
GROUP BY pc.model, maker
HAVING AVG(price) < (SELECT price FROM laptop JOIN product ON laptop.model = product.model WHERE maker = p.maker 
				AND price <= ALL (SELECT price FROM laptop JOIN product ON laptop.model = product.model WHERE maker = p.maker))

-- 4.
SELECT code, maker, (SELECT COUNT(code) FROM pc t1 WHERE t1.price >= t2.price) as num_pc_higher_price
FROM pc t2 JOIN product ON t2.model = product.model
