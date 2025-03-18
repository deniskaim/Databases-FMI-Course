-- I. PC

-- 1.
SELECT CONVERT(DECIMAL(9, 2), AVG(speed)) AS AvgSpeed
FROM pc

-- 2.
SELECT maker, AVG(screen) as AvgScreen
FROM product JOIN laptop ON product.model = laptop.model
GROUP BY maker

-- 3.
SELECT CONVERT(DECIMAL(9, 2), AVG(speed)) AS AvgSpeed
FROM laptop
WHERE price > 1000

-- 4.
SELECT maker, CONVERT(DECIMAL(9, 2), AVG(price)) AS AvgPrice
FROM product JOIN pc ON product.model = pc.model
WHERE maker = 'A'
GROUP BY maker

-- 5.
SELECT maker, AVG(lp.price) AS AvgPrice
FROM product JOIN (SELECT model, price FROM laptop UNION ALL SELECT model, price FROM pc) as LP ON product.model = LP.model
WHERE maker = 'B'
GROUP BY maker

-- 6.
SELECT speed, AVG(price) AS AvgPrice
FROM pc
GROUP BY speed

-- 7.
SELECT maker, COUNT(pc.code) AS number_of_pc
FROM product JOIN pc ON product.model = pc.model
GROUP BY maker
HAVING COUNT(pc.code) >= 3

-- 8.
SELECT maker, MAX(pc.price) AS price
FROM product JOIN pc ON product.model = pc.model
GROUP BY maker
HAVING MAX(price) = (SELECT MAX(price) FROM pc);

-- 9.
SELECT speed, AVG(price) AS AvgPrice
FROM pc
GROUP BY speed
HAVING speed > 800

-- 10.
SELECT maker, CONVERT(DECIMAL(9, 2), AVG(hd)) as AvgHD
FROM product JOIN pc ON product.model = pc.model
GROUP BY maker
HAVING maker IN (SELECT maker FROM product JOIN printer ON product.model = printer.model);






-- II. Ships

-- 1.
SELECT COUNT(type) AS NO_Classes
FROM CLASSES
WHERE type = 'bb'

-- 2.
SELECT class, AVG(numguns) AS avgGuns
FROM CLASSES
WHERE type = 'bb'
GROUP BY class

-- 3.
SELECT AVG(numguns) AS avgGuns
FROM CLASSES
WHERE type = 'bb'

-- 4.
SELECT CLASSES.class, MIN(launched) AS FirstYear, MAX(launched) AS LastYear
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY CLASSES.CLASS

-- 5.
SELECT CLASSES.CLASS, COUNT(RESULT) AS No_Sunk
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE RESULT = 'sunk'
GROUP BY CLASSES.CLASS

-- 6.
SELECT CLASSES.CLASS, COUNT(RESULT) AS No_Sunk
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE RESULT = 'sunk'
GROUP BY CLASSES.CLASS
HAVING CLASSES.CLASS IN (SELECT CLASS FROM SHIPS
						 GROUP BY CLASS HAVING COUNT(*) > 2);

-- 7.
SELECT country, CONVERT(DECIMAL(9, 2), AVG(bore)) AS avg_bore
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY COUNTRY