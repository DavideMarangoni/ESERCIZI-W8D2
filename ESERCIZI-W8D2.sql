# Esercizio W8D2 

# Creo il database Esericizi_W8D2
CREATE DATABASE Esercizi_W8D2;

# Creo le tabelle che popoleranno il database
CREATE TABLE Region (
RegionID INT AUTO_INCREMENT PRIMARY KEY,
citta VARCHAR(25) NOT NULL,
regione VARCHAR(25) NOT NULL,
area_geografica VARCHAR(25) NOT NULL
);

CREATE TABLE Category (
categoryID INT PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(25) NOT NULL,
Tipologia VARCHAR(25) NULL
);

CREATE TABLE Store (
SstoreID INT AUTO_INCREMENT PRIMARY KEY, 
Nome VARCHAR(25) NOT NULL,
CategoryID INT,
Data_Apertura DATE NULL,
Region_ID INT,
FOREIGN KEY (CategoryID) REFERENCES Category(categoryID),
FOREIGN KEY (Region_ID) REFERENCES Region(RegionID)
);

# Uso i comandi "ALTER TABLE" per modificare la tabella store appena creata
ALTER TABLE Store
CHANGE COLUMN StoreID StoreID INT AUTO_INCREMENT;

ALTER TABLE Store
CHANGE COLUMN Region_ID RegionID INT;

# Inserisco i dati all'interno delle tabelle
# I seguenti dati sono stati generati casualmente dall'AI, quindi nulla è reale
INSERT INTO Region (citta, regione, area_geografica) VALUES
('Milano', 'Lombardia', 'Nord'),
('Torino', 'Piemonte', 'Nord'),
('Napoli', 'Campania', 'Sud'),
('Firenze', 'Toscana', 'Centro'),
('Bari', 'Puglia', 'Sud');

INSERT INTO Category (Nome, Tipologia) VALUES
('Abbigliamento', 'Retail'),
('Elettronica', 'Retail'),
('Supermercato', 'Food'),
('Ristorante', 'Food'),
('Cartoleria', 'Servizi');

INSERT INTO Store (Nome, CategoryID, Data_Apertura, RegionID) VALUES 
('Sorbino Latina', 1, '2012-03-04,1', 1),
('MediaWorld Torino', 2, '2018-07-01', 2),
('Conad Napoli', 3, '2020-11-23', 3),
('Trattoria Toscana', 4, '2012-04-10', 4),
('Cartolibreria Bari', 5, '2023-01-05', 5);

# Modifico di nuovo la tabella Store
ALTER TABLE Store
CHANGE COLUMN RegionID regionID INT;

ALTER TABLE Store
CHANGE COLUMN StoreID storeID INT AUTO_INCREMENT,
CHANGE COLUMN CategoryID categoryID INT;

# Modifico la tabella Region
ALTER TABLE Region
CHANGE COLUMN RegionID regionID INT AUTO_INCREMENT;

# Siccome avevo eseguito due volte l'inserimento dei dati nella tabella store ho usato il comando DELETE FROM per eliminare i doppioni
# Sottolineo che possono esserci doppioni in quanto la chiave primaria storeID si auto incrementa
# di conseguenza non possono esserci righe identiche in tutto e per tutto
DELETE FROM Store
WHERE StoreID > 5;

UPDATE Store 
SET Data_Apertura = NULL
WHERE StoreID = 1;

# Creo la vista tabella_completa
CREATE VIEW tabella_completa AS (
SELECT S.Nome As StoreName, Data_Apertura AS OpenData, citta AS City, regione AS Region, area_geografica AS Area, C.Nome AS CategoryName, Tipologia, S.dress_typeID
FROM Store S
LEFT JOIN Region R ON S.regionID = R.regionID
LEFT JOIN Category C ON S.categoryID = C.categoryID
);

# Creo un ulteriore tabella "dress_type" per metterla in relazione per la vista creata
CREATE TABLE dress_type (
dress_typeID INT AUTO_INCREMENT PRIMARY KEY,
dress_name VARCHAR(25),
dress_color VARCHAR(16)
);

# Aggiungo la colonna dress_typeID nella tabella store
ALTER TABLE Store
ADD COLUMN dress_typeID INT;

# Aggiungo il vincolo sulla chiave primaria dress_typeID 
ALTER TABLE Store
ADD CONSTRAINT fk_dress_type
FOREIGN KEY (dress_typeID) REFERENCES dress_type(dress_typeID);

# Popolo la tabella dress_type
INSERT INTO dress_type (dress_name, dress_color) VALUES
('Casual Shirt', 'Blue'),
('Formal Suit', 'Black'),
('Polo', 'White'),
('Apron', 'Red'),
('Jacket', 'Green');

# Aggiungo i valori in dress_typeID nella tabella store
UPDATE Store SET dress_typeID = 1 WHERE StoreID = 1;
UPDATE Store SET dress_typeID = 2 WHERE StoreID = 2;
UPDATE Store SET dress_typeID = 3 WHERE StoreID = 3;
UPDATE Store SET dress_typeID = 4 WHERE StoreID = 4;
UPDATE Store SET dress_typeID = 5 WHERE StoreID = 5;

# faccio la join tra la vista e la nuova tabella
SELECT StoreName, DATE_FORMAT(OpenData,'%d/%m/%y') AS OpenData, City, Region, Area AS GeographyArea, CategoryName, Tipologia, dress_name AS DressName, dress_color AS DressColor
FROM tabella_completa T
JOIN dress_type D ON T.dress_typeID = D.dress_typeID;





