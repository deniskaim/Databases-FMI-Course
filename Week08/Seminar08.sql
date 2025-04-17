
-- I. Movies

-- 1.
INSERT INTO MOVIESTAR(NAME, BIRTHDATE, GENDER) VALUES('Nicole Kidman', '1967-06-20', 'F')

-- 2.
DELETE FROM MOVIEEXEC 
WHERE NETWORTH <= 30000000

-- 3.
DELETE FROM MOVIESTAR
WHERE ADDRESS IS NULL


-- II. PC

-- 4.
INSERT INTO pc VALUES(12, '1100', 2400, 2048, 500, 52, 299)
INSERT INTO product VALUES('C', '1100', 'pc')

-- 5.
DELETE FROM pc WHERE model = '1100'

-- 6.
DELETE FROM laptop 
WHERE model IN 
(SELECT model FROM product WHERE type = 'laptop' AND maker NOT IN (SELECT DISTINCT maker FROM product WHERE type = 'printer'))

-- 7.
UPDATE product
SET maker = 'B'
WHERE maker = 'A'

-- 8.
UPDATE pc
SET price = price / 2, hd = hd + 20

-- 9.

UPDATE laptop
SET screen = screen + 1
WHERE model IN 
(SELECT DISTINCT laptop.model 
 FROM laptop INNER JOIN product on laptop.model = product.model
 WHERE maker = 'B' AND product.type = 'laptop')


 -- III. Ships

 -- 10.

 INSERT INTO CLASSES
 VALUES('Nelson', 'bb', 'Gt.Britain', 9, 16, 34000)

 INSERT INTO SHIPS
 VALUES ('Nelson', 'Nelson', 1927), ('Rodney', 'Nelson', 1927)

 -- 11.

 DELETE FROM SHIPS 
 WHERE NAME IN (SELECT DISTINCT SHIP FROM OUTCOMES WHERE result = 'sunk')

 -- 12.

 UPDATE CLASSES
 SET bore = bore * 2.5, displacement = displacement / 1.1



