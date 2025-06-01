CREATE DATABASE FurnitureCompany;
USE FurnitureCompany;

-- 1.
CREATE TABLE CUSTOMER (
	Customer_ID INT IDENTITY(1, 1) PRIMARY KEY,
	Customer_Name VARCHAR(100) NOT NULL,
	Customer_Address VARCHAR(255),
	Customer_City VARCHAR(100),
	City_Code VARCHAR(10)
);

CREATE TABLE PRODUCT (
	Product_ID INT PRIMARY KEY,
	Product_Description VARCHAR(100) NOT NULL,
	Product_Finish VARCHAR(50),
	Standard_Price DECIMAL(10, 2),
	Product_Line_ID INT,
	CHECK (Product_Finish IN ('череша', 'естествен ясен', 'бял ясен', 
        'червен дъб', 'естествен дъб', 'орех'))
);

CREATE TABLE ORDER_T(
	Order_ID INT PRIMARY KEY,
	Order_Date DATETIME NOT NULL,
	Customer_ID INT,
	FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

CREATE TABLE ORDER_LINE(
	Order_ID INT,
	Product_ID INT,
	Ordered_Quantity INT,
	PRIMARY KEY (Order_ID, Product_ID),
	FOREIGN KEY (Order_ID) REFERENCES ORDER_T(Order_ID),
	FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID),
	CHECK (Ordered_Quantity > 0)
);

-- Given in the task
insert into CUSTOMER values 
('Иван Петров', 'ул. Лавеле 8', 'София', '1000'), 
('Камелия Янева', 'ул. Иван Шишман 3', 'Бургас', '8000'), 
('Васил Димитров', 'ул. Абаджийска 87', 'Пловдив', '4000'), 
('Ани Милева', 'бул. Владислав Варненчик 56', 'Варна','9000');

insert into PRODUCT values 
(1000, 'офис бюро', 'череша', 195, 10), 
(1001, 'директорско бюро', 'червен дъб', 250, 10), 
(2000, 'офис стол', 'череша', 75, 20), 
(2001, 'директорски стол', 'естествен дъб', 129, 20), 
(3000, 'етажерка за книги', 'естествен ясен', 85, 30), 
(4000, 'настолна лампа', 'естествен ясен', 35, 40); 

insert into ORDER_T values 
(100, '2013-01-05', 1), 
(101, '2013-12-07', 2), 
(102, '2014-10-03', 3), 
(103, '2014-10-08', 2), 
(104, '2015-10-05', 1), 
(105, '2015-10-05', 4), 
(106, '2015-10-06', 2), 
(107, '2016-01-06', 1); 

insert into ORDER_LINE values 
(100, 4000, 1), 
(101, 1000, 2), 
(101, 2000, 2), 
(102, 3000, 1), 
(102, 2000, 1), 
(106, 4000, 1), 
(103, 4000, 1), 
(104, 4000, 1), 
(105, 4000, 1), 
(107, 4000, 1);


-- 2.
CREATE VIEW v_Product_Times_Ordered(PRODUCT_ID, PRODUCT_DESCRIPTION, TIMES_ORDERED)
AS
	SELECT t.Product_ID, Product_Description, t.Times_Ordered
	FROM (
		SELECT Product_ID, COUNT(*) AS Times_Ordered
		FROM ORDER_LINE 
		GROUP BY Product_ID
		) as t JOIN PRODUCT ON t.Product_ID = PRODUCT.Product_ID;

SELECT * FROM v_Product_Times_Ordered

-- 3.
SELECT pr.Product_ID, Product_Description, ISNULL(t.Times_Ordered, 0)
FROM (
	SELECT Product_ID, SUM(Ordered_Quantity) AS Times_Ordered
	FROM ORDER_LINE 
	GROUP BY Product_ID
	) as t RIGHT JOIN PRODUCT pr ON t.Product_ID = pr.Product_ID;


-- 4.
CREATE VIEW v_Customer_Order_Amount(CUSTOMER_NAME, Order_Amount)
AS
	SELECT Customer_Name, SUM(Ordered_Quantity * Standard_Price) AS 'Order Amount'
	FROM ORDER_LINE 
	JOIN PRODUCT ON ORDER_LINE.Product_ID = PRODUCT.Product_ID 
	JOIN ORDER_T ON ORDER_LINE.Order_ID = ORDER_T.Order_ID
	JOIN CUSTOMER ON ORDER_T.Customer_ID = CUSTOMER.Customer_ID
	GROUP BY Customer_Name

SELECT * FROM v_Customer_Order_Amount



USE pc;
-- 5.
-- first solution

SELECT maker 
FROM PRODUCT
WHERE type = 'Printer'
INTERSECT
SELECT maker 
FROM PRODUCT
WHERE type = 'Laptop'

-- second solution
SELECT DISTINCT maker
FROM PRODUCT
WHERE type = 'Printer' AND maker IN (SELECT maker FROM PRODUCT WHERE type = 'Laptop')


-- 6.
UPDATE pc
SET price = 95 * price / 100
FROM product JOIN pc ON product.model = pc.model
WHERE maker IN (
	SELECT DISTINCT maker
	FROM PRODUCT JOIN printer ON product.model = printer.model
	GROUP BY maker
	HAVING SUM(price) >= 800);

-- 7.
CREATE VIEW v_hd_min_price(hd, min_price)
AS
	SELECT hd, MIN(price)
	FROM pc
	WHERE hd >= 10 AND hd <= 30
	GROUP BY hd

USE ships;
-- 8.
SELECT * FROM OUTCOMES

CREATE VIEW v_battles_more_ships(battle)
AS
	SELECT b.name
	FROM OUTCOMES o JOIN BATTLES b ON o.BATTLE = b.name
	GROUP BY b.name, b.DATE
	HAVING COUNT(*) > (SELECT COUNT(*) FROM OUTCOMES WHERE battle = 'Guadalcanal')

CREATE VIEW v_battles_more_countries(battle)
AS
	SELECT b.name
	FROM OUTCOMES o 
	JOIN BATTLES b ON o.BATTLE = b.NAME
	JOIN SHIPS s ON o.SHIP = s.NAME
	JOIN CLASSES c ON s.CLASS = c.CLASS
	GROUP BY b.name, b.date
	HAVING COUNT(COUNTRY) > (SELECT COUNT(COUNTRY) 
		FROM OUTCOMES o2
		JOIN SHIPS s2 ON o2.SHIP = s2.NAME
		JOIN CLASSES c2 ON s2.CLASS = c2.CLASS
		WHERE battle = 'Guadalcanal')

SELECT * FROM v_battles_more_countries

-- 9.
DELETE FROM OUTCOMES
WHERE BATTLE IN (
	SELECT BATTLE FROM OUTCOMES
	GROUP BY BATTLE
	HAVING COUNT(*) = 1)

-- 10.
INSERT INTO outcomes VALUES ('Missouri','Surigao Strait', 'sunk'), 
('Missouri','North Cape', 'sunk'), 
('Missouri','North Atlantic', 'ok');

DELETE FROM OUTCOMES
WHERE SHIP IN (
	SELECT SHIP 
	FROM OUTCOMES
	WHERE RESULT = 'sunk'
	GROUP BY SHIP
	HAVING COUNT(*) >= 2
	);

SELECT * FROM OUTCOMES

-- 11.
CREATE VIEW v_Countries_Guadalcanal(country)
AS
	SELECT DISTINCT COUNTRY
	FROM CLASSES cl
	JOIN SHIPS sh ON cl.CLASS = sh.CLASS
	JOIN OUTCOMES o ON sh.NAME = o.SHIP
	WHERE BATTLE = 'Guadalcanal'

CREATE VIEW v_Battle_Countries(battle, country)
AS
	SELECT BATTLE, COUNTRY
	FROM OUTCOMES o
	JOIN SHIPS sh ON o.SHIP = sh.NAME
	JOIN CLASSES cl ON cl.CLASS = sh.CLASS

SELECT DISTINCT battle
FROM v_Battle_Countries bc1
WHERE NOT EXISTS(
	SELECT *
	FROM v_Battle_Countries bc2
	WHERE bc1.battle = bc2.battle AND bc2.country NOT IN (SELECT country FROM v_Countries_Guadalcanal)
	)
	AND NOT EXISTS(
	SELECT *
	FROM v_Countries_Guadalcanal cg
	WHERE cg.country NOT IN (SELECT country FROM v_Battle_Countries bc3 WHERE bc3.battle = bc1.battle)
	)
	AND battle != 'Guadalcanal'

-- 12.
SELECT country, COUNT(DISTINCT BATTLE) AS battles_count
FROM OUTCOMES o
JOIN SHIPS sh ON o.SHIP = sh.NAME
RIGHT JOIN CLASSES cl ON cl.CLASS = sh.CLASS
GROUP BY country
