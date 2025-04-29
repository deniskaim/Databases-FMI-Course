-- CREATE TABLES

CREATE TABLE Airlines (
	code CHAR(2) CONSTRAINT pk_airlines PRIMARY KEY,
	name VARCHAR(255) CONSTRAINT uk_airlines_name UNIQUE NOT NULL,
	country VARCHAR(30) NOT NULL
);

CREATE TABLE Airplanes (
	code CHAR(3) CONSTRAINT pk_airplanes PRIMARY KEY,
	type VARCHAR(50) NOT NULL,
	seats INT NOT NULL,
	year INT NOT NULL,
	CHECK (seats > 0 AND year >= 1950)
);

CREATE TABLE Agencies (
	name VARCHAR(50) CONSTRAINT pk_agencies PRIMARY KEY,
	country VARCHAR(30) NOT NULL,
	city VARCHAR(30) NOT NULL,
	phone VARCHAR(15) CONSTRAINT uk_agencies_phone UNIQUE
);

CREATE TABLE Customers (
	id INT CONSTRAINT pk_customers PRIMARY KEY,
	fname VARCHAR(30) NOT NULL,
	lname VARCHAR(30) NOT NULL,
	email VARCHAR(50) CONSTRAINT uk_customers_email UNIQUE NOT NULL,
	check (LEN(email) >= 6 AND email LIKE '%@%.%')
);

CREATE TABLE Airports (
	code CHAR(3) CONSTRAINT pk_airports PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	CONSTRAINT uk_airports_name_country UNIQUE (name, country)
);

CREATE TABLE Flights (
	fnumber VARCHAR(15) CONSTRAINT pk_flights PRIMARY KEY,
	airline_operator CHAR(2) NOT NULL,
	CONSTRAINT fk_flights_airline FOREIGN KEY (airline_operator) REFERENCES Airlines(code),
	dep_airport CHAR(3) NOT NULL,
	CONSTRAINT fk_flights_dep_airport FOREIGN KEY (dep_airport) REFERENCES Airports(code),
	arr_airport CHAR(3) NOT NULL, 
	CONSTRAINT fk_flights_arr_airport FOREIGN KEY (arr_airport) REFERENCES Airports(code),
	flight_time DATETIME NOT NULL,
	flight_duration INT NOT NULL,
	airplane CHAR(3) NOT NULL,
	CONSTRAINT fk_flights_airplane FOREIGN KEY (airplane) REFERENCES Airplanes(code)
);

CREATE TABLE Bookings (
	code CHAR(6) CONSTRAINT pk_bookings PRIMARY KEY,
	agency VARCHAR(50) NOT NULL,
	CONSTRAINT fk_bookings_agencies FOREIGN KEY (agency) REFERENCES Agencies(name),
	airline_code CHAR(2) NOT NULL,
	CONSTRAINT fk_bookings_airlines FOREIGN KEY (airline_code) REFERENCES Airlines(code),
	flight_number VARCHAR(15) NOT NULL,
	CONSTRAINT fk_bookings_flights FOREIGN KEY (flight_number) REFERENCES Flights(fnumber),
	customer_id INT NOT NULL,
	CONSTRAINT fk_bookings_customers FOREIGN KEY (customer_id) REFERENCES Customers(id),
	booking_date DATETIME NOT NULL,
	flight_date DATETIME NOT NULL,
	price INT NOT NULL,
	status BIT NOT NULL,
	CHECK (booking_date < flight_date)
);