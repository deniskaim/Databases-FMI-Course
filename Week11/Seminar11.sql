
-- 1.
CREATE VIEW v_FlightPassengers(operator, flight_number, passengersCount)
AS
SELECT AIRLINE_OPERATOR, FNUMBER, COUNT(*)
FROM FLIGHTS JOIN BOOKINGS ON FNUMBER = FLIGHT_NUMBER
GROUP BY AIRLINE_OPERATOR, FNUMBER

-- 2.

CREATE VIEW v_TopClientPerAgency(agency_name, customer_firtName, customer_lastName)
AS
SELECT DISTINCT b.AGENCY, c.FNAME, c.LNAME
FROM BOOKINGS b JOIN CUSTOMERS c ON b.CUSTOMER_ID = c.ID
WHERE NOT EXISTS (
	SELECT up.CUSTOMER_ID
	FROM BOOKINGS up
	WHERE up.AGENCY = b.AGENCY AND up.CUSTOMER_ID = b.CUSTOMER_ID
	GROUP BY up.AGENCY, up.CUSTOMER_ID
	HAVING COUNT(*) < ANY ( SELECT COUNT(*)
							FROM BOOKINGS
							GROUP BY AGENCY, CUSTOMER_ID
							HAVING AGENCY = up.AGENCY));

-- 3.

CREATE VIEW v_AgenciesInSofia
AS
SELECT *
FROM AGENCIES
WHERE AGENCIES.CITY = 'Sofia'
WITH CHECK OPTION

-- 4.

CREATE VIEW v_AgenciesNullPhone
AS
SELECT *
FROM AGENCIES
WHERE AGENCIES.CITY = 'Sofia' AND AGENCIES.PHONE IS NULL
WITH CHECK OPTION

-- 7.
DROP VIEW v_FlightPassengers;
DROP VIEW v_TopClientPerAgency;
DROP VIEW v_AgenciesInSofia;
DROP VIEW v_AgenciesNullPhone;

-- 8.
CREATE INDEX idx_product_type ON PRODUCT(type);
CREATE INDEX idx_product_maker ON PRODUCT(maker);

-- 9.
CREATE INDEX idx_classes_numguns ON CLASSES(numguns)
CREATE INDEX idx_classes_country ON CLASSES(country)
CREATE INDEX idx_ships_class ON SHIPS(class)
CREATE INDEX idx_outcomes_ship ON OUTCOMES(ship)
CREATE INDEX idx_outcomes_battle ON OUTCOMES(battle)

-- 10.
DROP INDEX idx_product_type ON PRODUCT
DROP INDEX idx_product_maker ON PRODUCT

DROP INDEX idx_classes_numguns ON CLASSES
DROP INDEX idx_classes_country ON CLASSES
DROP INDEX idx_ships_class ON SHIPS
DROP INDEX idx_outcomes_ship ON OUTCOMES
DROP INDEX idx_outcomes_battle ON OUTCOMES