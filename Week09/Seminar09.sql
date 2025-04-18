
-- Task 1

-- а)

CREATE TABLE Product (
	maker CHAR(1),
	model CHAR(4),
	type VARCHAR(7)
);

CREATE TABLE Printer (
	code INTEGER,
	model CHAR(4),
	price DECIMAL(7, 2)
);

-- б)

INSERT INTO Product VALUES('A', '1000', 'phone'), ('B', '1100', 'headset')
INSERT INTO Printer VALUES(12, '1200', 100.50), (14, '1300', 120)

-- в)

ALTER TABLE Printer
ADD type VARCHAR(6) CHECK (type IN ('laser', 'matrix', 'jet')),
	color CHAR(1) DEFAULT 'n' CHECK (color IN ('y', 'n'))


-- г)

ALTER TABLE Printer
DROP COLUMN price

-- д)

DROP TABLE Product
DROP TABLE Printer



-- Task 2

-- а)

CREATE TABLE Users (
	id INTEGER PRIMARY KEY,
	email VARCHAR(30) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	registrationDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Friends (
	userID INTEGER,
	friendID INTEGER,
	PRIMARY KEY (userID, friendID),
	FOREIGN KEY (userID) REFERENCES Users(id),
	FOREIGN KEY (friendID) REFERENCES Users(id)
);

CREATE TABLE Walls (
	wallOwnerID INTEGER,
	authorID INTEGER,
	message VARCHAR(255) NOT NULL, 
	postDate DATETIME DEFAULT GETDATE(),

	FOREIGN KEY (wallOwnerID) REFERENCES Users(id),
	FOREIGN KEY (authorID) REFERENCES Users(id)
);

CREATE TABLE Groups (
	id INTEGER PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	description VARCHAR(255) DEFAULT ''
);

CREATE TABLE GroupMembers (
	groupID INTEGER,
	userID INTEGER,
	PRIMARY KEY (groupID, userID),
	FOREIGN KEY (groupID) REFERENCES Groups(id),
	FOREIGN KEY (userID) REFERENCES Users(id)
);


-- б)

INSERT INTO Users(id, email, password) VALUES(1, 'random@gmail.com', 'pass123'), (2, 'random2@gmail.com', 'pass456')
INSERT INTO Friends VALUES(1, 2)
INSERT INTO Walls(wallOwnerID, authorID, message) VALUES(1, 2, 'just a message')
INSERT INTO Groups VALUES(1, 'random group', 'the first group')
INSERT INTO GroupMembers VALUES(1, 1), (1, 2)
