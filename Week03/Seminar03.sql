-- I. Movies

-- 1.
SELECT name
FROM MOVIESTAR
WHERE gender = 'F' AND name IN (SELECT name FROM MOVIEEXEC WHERE NETWORTH > 10000000);

-- 2.
SELECT name
FROM MOVIESTAR
WHERE name NOT IN (SELECT name FROM MOVIEEXEC);

-- 3.
SELECT title
FROM MOVIE
WHERE length > (SELECT length FROM MOVIE WHERE title = 'Star Wars');

-- 4.
SELECT title, name
FROM MOVIEEXEC INNER JOIN MOVIE
ON cert# = producerc#
WHERE networth > (SELECT networth FROM MOVIEEXEC WHERE name = 'Merv Griffin');






-- II. PC

-- 1.
SELECT maker
FROM product
WHERE product.type = 'pc'  AND product.model IN (SELECT model FROM pc WHERE speed > 500);

-- 2.
SELECT code, model, price
FROM printer
WHERE price >= ALL (SELECT price FROM printer);

-- 3.
SELECT *
FROM laptop
WHERE speed < ALL (SELECT speed FROM pc);

-- 4.
SELECT model, price
FROM (SELECT model, price FROM pc
	  UNION
	  SELECT model, price FROM laptop
	  UNION
	  SELECT model, price FROM printer) allProducts
WHERE allProducts.price >= ALL (SELECT price FROM pc
								UNION
								SELECT price FROM laptop
								UNION
								SELECT price FROM printer);

-- 5.
SELECT maker
FROM product
WHERE product.type = 'printer' AND product.model = (SELECT model
													FROM printer
													WHERE color = 'y' AND price <= ALL (SELECT price FROM printer WHERE color = 'y'));

-- 6.
SELECT maker
FROM product
WHERE product.type = 'pc' AND product.model IN (SELECT model FROM pc
											    WHERE ram <= ALL (SELECT ram FROM PC) 
													AND speed >= ALL (SELECT speed 
																	  FROM pc
																	  WHERE ram <= ALL (SELECT ram FROM pc)));


-- III. Ships

-- 1.
SELECT DISTINCT country
FROM CLASSES
WHERE numguns >= ALL (SELECT numguns FROM CLASSES);

-- 2.
SELECT DISTINCT class
FROM SHIPS
WHERE name IN (SELECT ship FROM OUTCOMES WHERE result = 'sunk');

-- 3.
SELECT name, class
FROM SHIPS
WHERE class IN (SELECT class FROM CLASSES WHERE bore = 16);

-- 4.
SELECT name as battle
FROM BATTLES
WHERE name IN (SELECT battle FROM OUTCOMES WHERE ship IN (SELECT name FROM SHIPS WHERE class = 'Kongo'));

-- 5.
SELECT class, name
FROM SHIPS
WHERE class IN (SELECT class FROM CLASSES t1
				WHERE numguns >= ALL (SELECT numguns FROM CLASSES WHERE bore = t1.bore))
ORDER BY class, name ASC;