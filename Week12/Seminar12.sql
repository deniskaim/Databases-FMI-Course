-- 1.
ALTER TABLE Flights
ADD num_pass INTEGER DEFAULT 0 NOT NULL;

-- 2.
ALTER TABLE Agencies
ADD num_book INTEGER DEFAULT 0 NOT NULL;

-- 3.
CREATE TRIGGER BOOKINGS_ADD_RES
ON BOOKINGS
AFTER INSERT
AS
BEGIN
	UPDATE FLIGHTS
	SET num_pass = num_pass + 1
	WHERE FNUMBER IN (SELECT FLIGHT_NUMBER FROM inserted)
	UPDATE AGENCIES
	SET num_book = num_book + 1
	WHERE NAME IN (SELECT AGENCY FROM inserted)
END

-- 4.
CREATE TRIGGER BOOKINGS_DEL_RES
ON BOOKINGS
AFTER DELETE
AS
BEGIN
	UPDATE FLIGHTS
	SET num_pass = num_pass - 1
	WHERE FNUMBER IN (SELECT FLIGHT_NUMBER FROM deleted)
	UPDATE AGENCIES
	SET num_book = num_book - 1
	WHERE NAME IN (SELECT AGENCY FROM deleted)
END

-- 5.
CREATE TRIGGER BOOKINGS_UPDATE
ON BOOKINGS
AFTER UPDATE
AS
BEGIN
	UPDATE FLIGHTS
	SET num_pass = num_pass + 1	
	WHERE fnumber IN (SELECT i.flight_number FROM inserted i JOIN deleted d ON i.code = d.code WHERE i.status = 1 AND d.status = 0)

	UPDATE FLIGHTS
	SET num_pass = num_pass - 1
	WHERE fnumber IN (SELECT i.flight_number FROM inserted i JOIN deleted d ON i.code = d.code WHERE i.status = 0 AND d.status = 1)
	
	UPDATE AGENCIES
	SET num_book = num_book + 1
	WHERE NAME IN (SELECT i.AGENCY FROM inserted i JOIN deleted d ON i.code = d.code WHERE i.status = 1 AND d.status = 0)

	UPDATE AGENCIES
	SET num_book = num_book - 1
	WHERE NAME IN (SELECT i.AGENCY FROM inserted i JOIN deleted d ON i.code = d.code WHERE i.status = 0 AND d.status = 1)
END
