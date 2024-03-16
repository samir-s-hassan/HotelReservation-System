DROP TABLE RateCalc; 
DROP TABLE Receipt;
DROP TABLE Reservation;
DROP TABLE Rates;
DROP TABLE Amenities;
DROP TABLE Room;
DROP TABLE RoomType;
DROP TABLE Customer;
DROP TABLE Hotel;

CREATE TABLE Hotel (
  hotelID NUMBER(5) NOT NULL,
  hotelName VARCHAR2(20) NOT NULL,
  hotelStreet VARCHAR2(30) NOT NULL,
  hotelCity VARCHAR2(20) NOT NULL,
  hotelZip NUMBER (6) NOT NULL,
  PRIMARY KEY (hotelID)
);

CREATE TABLE Customer (
	customerID NUMBER (5) NOT NULL,
	fullName VARCHAR2(50) NOT NULL,
	streetAddress VARCHAR2(50) NOT NULL,
	cityAddress VARCHAR2(50),
	zipAddress VARCHAR2(50),
	freqGuestID NUMBER (8),
	freqGuestPoints NUMBER (7),
	primaryPhone VARCHAR2(12) NOT NULL,
	creditCardNumber NUMBER(16) NOT NULL,
  PRIMARY KEY (customerID)
);

CREATE TABLE RoomType (
  roomTypeID VARCHAR2(3) NOT NULL,
  roomTypeName VARCHAR2(20) NOT NULL,
  totalBathroom NUMBER(1) NOT NULL,
  totalBedroom NUMBER(1) NOT NULL,
  dollarDaily NUMBER(3) NOT NULL,
  pointDaily NUMBER(3) NOT NULL,
  PRIMARY KEY (roomTypeID)
);

CREATE TABLE Room (
  hotelID NUMBER(5) NOT NULL,
  roomNumber NUMBER (2) NOT NULL,
  roomTypeID VARCHAR2 (3) NOT NULL,
  statusOccupation NUMBER(1) NOT NULL,
  statusCleaning NUMBER(1) NOT NULL,
  PRIMARY KEY (hotelID, roomNumber),
  FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID) on delete cascade,
  FOREIGN KEY (roomTypeID) REFERENCES RoomType(roomTypeID) on delete cascade
);

CREATE TABLE Amenities (
  hotelID NUMBER(5) NOT NULL,
	amenityName VARCHAR(20) NOT NULL,
  PRIMARY KEY (hotelID, amenityName),
  FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID) on delete cascade
);

CREATE TABLE Rates (
	rateID VARCHAR2(16),
  dateRateStart DATE,
  dateRateEnd DATE,
  rateMultiplier NUMBER(4,2) NOT NULL,
  PRIMARY KEY (rateID)
);

CREATE TABLE Reservation (
	reservationID NUMBER (5) NOT NULL,
  customerID NUMBER (5) NOT NULL,
  hotelID NUMBER(5) NOT NULL,
  roomNumber NUMBER (2) NOT NULL,
	dateCheckIn DATE,
	dateCheckOut DATE,
  PRIMARY KEY (reservationID),
  FOREIGN KEY (hotelID, roomNumber) REFERENCES Room (hotelID, roomNumber) on delete cascade,
  FOREIGN KEY (customerID) REFERENCES Customer(customerID) on delete cascade,
  CHECK (dateCheckIn < dateCheckOut)
);

CREATE TABLE Receipt (
  confirmationID NUMBER (7) NOT NULL,
  reservationID NUMBER (5) NOT NULL,
  dollarsPaid NUMBER (4) NOT NULL,
  pointsPaid NUMBER (4) NOT NULL,
  exactTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (confirmationID),
  FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID) on delete cascade
);

CREATE TABLE RateCalc (
  reservationID NUMBER (5) NOT NULL,
  roomTypeID VARCHAR2(3) NOT NULL,
  rateID VARCHAR2(16) NOT NULL,
  PRIMARY KEY(reservationID),
  FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID) on delete cascade,
  FOREIGN KEY (roomTypeID) REFERENCES RoomType(roomTypeID) on delete cascade,
  FOREIGN KEY (rateID) REFERENCES Rates(rateID) on delete cascade
);

INSERT INTO Hotel (hotelID, hotelName, hotelStreet, hotelCity, hotelZip) VALUES (12345, 'Grand', 'Main Street', 'New York', '10001');
INSERT INTO Hotel (hotelID, hotelName, hotelStreet, hotelCity, hotelZip) VALUES (45678, 'Carlton', 'Newbury Street', 'Boston', '02116');
INSERT INTO Hotel (hotelID, hotelName, hotelStreet, hotelCity, hotelZip) VALUES (67890, 'Plaza', 'Fifth Avenue', 'New York', '10022');
INSERT INTO Hotel (hotelID, hotelName, hotelStreet, hotelCity, hotelZip) VALUES (78901, 'Hilton', 'Broadway', 'New York', '10003');
INSERT INTO Hotel (hotelID, hotelName, hotelStreet, hotelCity, hotelZip) VALUES (23459, 'Ritz', 'Biscayne Boulevard', 'Miami', '33131');
INSERT INTO Hotel (hotelID, hotelName, hotelStreet, hotelCity, hotelZip) VALUES (34560, 'Fontainebleau', 'Collins Avenue', 'Miami', '33140');
INSERT INTO Hotel (hotelID, hotelName, hotelStreet, hotelCity, hotelZip) VALUES (45671, 'Beverly', 'Sunset Boulevard', 'Los Angeles', '90210');
INSERT INTO Hotel (hotelID, hotelName, hotelStreet, hotelCity, hotelZip) VALUES (56782, 'Standard', 'Sunset Boulevard', 'Los Angeles', '90069');

insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (42513, 'Ezequiel Lansdale', '32833 Farragut Plaza', 'Yongtai', null, 21460958, 38, '335-905-4732', '5048376102108948');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (82906, 'Jenilee Friedank', '5569 Mcbride Point', 'Szeged', '6748', null, null, '772-124-4320', '5048373800705018');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (67024, 'Malvina Kane', '79 Bunting Place', 'Soutelo', '4740-497', null, null, '875-124-8307', '5108750361618663');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (91378, 'Valentia Rosenstock', '42386 Kropf Avenue', 'Yanwang', null, 57519672, 103, '350-890-1525', '5108753342258252');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (24109, 'Tyrone Strapp', '4 Monica Place', 'Hongqi', null, 22916375, 41, '867-230-3807', '5048378412230446');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (50234, 'Ax Bithany', '82020 Duke Center', 'Kim Sơn', null, null, null, '317-606-6843', '5048379781394896');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (86179, 'Jakob Schiell', '6 Cherokee Park', 'Pidsandawan', '0921', null, null, '453-237-4274', '5048372452630375');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (14796, 'Ambrosi Learoyd', '887 Eggendart Court', 'Juan Adrián', '11506', 85853973, 154, '636-573-6169', '5108759717430780');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (50873, 'Jareb Playford', '09677 Lakewood Pass', 'Stara Kiszewa', '83-430', 26455840, 47, '375-902-7216', '5048375586155573');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (39524, 'Sunny Swanton', '41 Golf Course Circle', 'Sidi Qacem', null, 17463066, 31, '759-463-2880', '5048370633514427');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (71483, 'Hilton Cork', '446 Esker Pass', 'Villanueva', '9002', 57083108, 102, '513-256-9972', '5048373940136926');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (35691, 'Cleve Duchateau', '878 Briar Crest Road', 'Brzeźnica', '68-113', 34666636, 62, '244-297-5194', '5108755633542377');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (69251, 'Blondell Garmon', '773 Pond Center', 'General Luna', '6335', 12388249, 22, '938-980-2297', '5108756621145165');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (18347, 'Carley Chazerand', '88269 Maywood Crossing', 'Yushan', null, 76322481, 137, '174-342-7263', '5048372561884053');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (24039, 'Eldredge Creese', '464 Debra Court', 'Besançon', '25035 CEDEX', null, null, '123-317-5512', '5108755309873718');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (93608, 'Heloise Rontsch', '3139 Lotheville Trail', 'Luhyny', null, 99764322, 179, '884-378-6624', '5048373150336422');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (49230, 'Quincy Peyro', '16 Washington Street', 'Wotan', null, 78894888, 142, '462-381-9031', '5108756217743522');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (70153, 'Sara-ann Garrattley', '9 Forest Run Court', 'Santuario', '663008', 94044509, 169, '280-194-2891', '5108751110995212');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (63892, 'Klara Campkin', '241 Pleasure Plaza', 'Sundre', 'L9H', 32344852, 58, '439-760-0958', '5108756795391637');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (57263, 'Jeanna Ingleson', '72 Browning Street', 'Shagang', null, 82895676, 149, '689-319-8294', '5108756876072239');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (12485, 'Isacco Harvatt', '41424 Fremont Way', 'Ponte', '4610-475', 52637844, 94, '627-203-0644', '5048370025868928');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (96172, 'Butch Crat', '653 Lerdahl Terrace', 'Davyd-Haradok', null, 44416523, 79, '702-463-7596', '5108751277732267');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (14307, 'Edsel Reignolds', '4 Superior Road', 'Istres', '13802 CEDEX', 98405520, 177, '108-294-4535', '5048373214209870');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (75094, 'Sawyer Kermode', '31 Thompson Terrace', 'Khong Chai', '34260', 76250868, 137, '812-215-0858', '5108756464539771');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (69837, 'Claudine Josephsen', '0 Prairieview Parkway', 'San Julian', '6814', 36436545, 65, '339-814-0520', '5108750719406100');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (10475, 'Sayer Possek', '30328 Hermina Avenue', 'Kizhinga', '671450', 25668492, 46, '268-440-2462', '5048370337340723');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (87539, 'Emeline Barnewall', '63474 Drewry Center', 'San Fernando', '8711', null, null, '303-908-7566', '5048371427629033');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (32068, 'Raddie Birchwood', '99 Ridgeway Park', 'Galovac', '43000', 49418059, 88, '528-305-6371', '5048379831192910');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (91653, 'Carlin De la Yglesia', '15210 Knutson Park', 'Béziers', '34504 CEDEX', 70474867, 126, '443-779-2102', '5048373396154985');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (54793, 'Bebe Moorey', '59 6th Hill', 'Bianba', null, null, null, '984-779-6999', '5048376835616001');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (81956, 'Konstance Whorlton', '9 Longview Hill', 'San Pedro', '48744', 39000744, 70, '262-227-6602', '5108757376971698');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (61302, 'Agace Helin', '70244 Mallard Road', 'Kangar', '01578', 73635635, 132, '432-354-8356', '5048370046868063');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (24061, 'Esteban Gosnold', '90776 Ronald Regan Avenue', 'Holboo', null, 80035737, 144, '464-411-5874', '5108754100759507');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (48537, 'Paulita Breese', '9335 Bunting Terrace', 'Michałowo', '16-050', 54582538, 98, '416-219-8014', '5048374884423635');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (83529, 'Gusta Meekins', '16129 Melvin Way', 'Savyon', null, null, null, '435-109-2142', '5048370266881598');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (76421, 'Vincenz Muscott', '7 Ramsey Avenue', 'Jinchuan', null, 94352233, 169, '470-290-5892', '5048376324009411');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (53607, 'Zaria Farquharson', '63 Lunder Street', 'Longsha', null, 51650857, 92, '207-102-1447', '5048370501031140');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (97015, 'Effie Bloodworth', '5840 Union Road', 'Seattle', '98148', 31848972, 57, '253-247-9652', '5048375372477207');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (45108, 'Ralina Beddin', '703 Scott Alley', 'Castelsarrasin', '82104 CEDEX', null, null, '707-901-9665', '5048370590370367');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (51798, 'Fitz Corradengo', '8836 Forest Dale Pass', 'Babakanbungur', null, 88275632, 158, '207-393-9077', '5108751793917988');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (32057, 'Westleigh Fearnehough', '69 Forster Hill', 'Hrvatska Kostajnica', '44430', 14411094, 25, '574-836-9900', '5048378427521342');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (28475, 'Oliviero Corkish', '67019 Hollow Ridge Hill', 'Sidi Bouzid', null, null, null, '472-831-6961', '5108752590401382');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (64085, 'Lazar Sexon', '424 Colorado Drive', 'Aknoul', null, null, null, '810-989-4629', '5108758750483243');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (70935, 'Boigie Bruyns', '1104 Welch Center', 'Salam', null, null, null, '738-806-6787', '5048377859729795');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (59103, 'Javier Kitto', '7 Bonner Place', 'La Loma', '92148', 35362108, 63, '557-848-6576', '5048379326667210');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (86297, 'Dacie Janczewski', '52 Badeau Alley', 'Sigeng', null, 73106699, 131, '971-595-5686', '5108755045830667');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (43570, 'Rockwell Deveraux', '32445 Pearson Drive', 'Proletar', null, null, null, '361-555-4665', '5108752126282629');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (62397, 'Derk Seton', '49850 Heath Lane', 'Bailu', null, 61629928, 110, '896-185-3303', '5108752278173196');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (19857, 'Chloe Timmes', '62532 Dunning Plaza', 'Blokdesa Situgede', null, 51162318, 92, '947-480-5221', '5108755411141780');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (20793, 'Merwyn Rogers', '66237 Mcbride Hill', 'Messina', '98124', 40672073, 73, '655-807-2839', '5048377558482639');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (50841, 'Byrom Idiens', '73 Scofield Point', 'Pulau Tiga', null, null, null, '256-399-7544', '5048373169409541');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (70438, 'Liza Gilliat', '85 Jay Avenue', 'Tuanjie', null, null, null, '760-153-8816', '5108751461926063');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (56279, 'Bobbye Napoleone', '36013 Portage Pass', 'Mulyadadi', null, null, null, '679-698-7879', '5048377741573872');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (32090, 'Waylon Bucke', '4 Moose Way', 'Wotan', null, 65438658, 117, '220-151-0331', '5108750976219915');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (98264, 'Rowena Sommersett', '344 Dexter Road', 'Castelo de Vide', '7320-105', null, null, '938-519-2127', '5048375199160960');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (43956, 'Glori Minerdo', '1770 Kensington Hill', 'San Isidro', '4124', 84740106, 152, '107-263-4983', '5048372260978487');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (31867, 'Aigneis Codlin', '2 Granby Alley', 'Tulusmulyo', null, 58021591, 104, '947-631-2776', '5108757961809469');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (67845, 'Donaugh Shera', '54 Calypso Circle', 'Kwali', null, null, null, '670-938-8317', '5048377070092809');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (51247, 'Ines Andreacci', '40401 Donald Trail', 'Sumuranyar', null, 30530910, 54, '888-830-9126', '5108754097246864');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (98624, 'Pearline Gossington', '2050 Lotheville Center', 'Baicun', null, 57706003, 103, '241-518-9218', '5048375634633373');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (31875, 'Sigismundo Tinghill', '4 Kensington Court', 'Eṭ Ṭaiyiba', null, 20555174, 36, '626-604-6074', '5108758610212428');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (37096, 'Anna-diana Hounsham', '39472 Mcbride Court', 'Araçatuba', '16000-000', 69437515, 124, '345-451-7338', '5108757201252306');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (52901, 'Cobb Dollard', '01 Hagan Park', 'Qingyun', null, 73982008, 133, '523-227-7772', '5108759859930977');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (78692, 'Issi Lodeke', '4072 Fuller Crossing', 'Göteborg', '401 99', 81627156, 146, '142-589-2257', '5048371159174299');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (30475, 'Addison Spurway', '29 Memorial Hill', 'Dizhai', null, 92455449, 166, '237-405-4966', '5048370265033530');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (12960, 'Hedvige Eagers', '597 Melody Point', 'Paris 12', '75567 CEDEX 12', 80309044, 144, '892-386-5241', '5108752646141016');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (73504, 'Zorah Haspineall', '698 Forest Way', 'Íquira', '412068', null, null, '410-734-5995', '5048378633748176');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (46581, 'Teodorico McGrann', '17752 Parkside Junction', 'Tijucas', '88200-000', null, null, '766-655-4735', '5108758260192870');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (86701, 'Cornell McLauchlin', '7709 Carberry Plaza', 'Dukla', '38-450', 72276740, 130, '777-833-0355', '5108754018896268');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (69153, 'Normie Frostdyke', '74654 Maple Road', 'Липково', '1325', null, null, '483-957-0724', '5048372756945933');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (53749, 'Cyrillus Rounding', '533 Wayridge Plaza', 'Bandera', '3064', null, null, '152-905-5778', '5108752951930532');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (69425, 'Dominique Gratton', '35034 Maryland Pass', 'Tumauini', '3325', 24848108, 44, '130-209-4525', '5048377513692983');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (93625, 'Bart Shafto', '20024 Eggendart Park', 'Kayukembang', null, null, null, '355-642-2551', '5048379229199857');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (87143, 'Brig Cherry Holme', '813 Kipling Circle', 'Świeradów-Zdrój', '59-852', null, null, '334-173-3996', '5108750179352018');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (37654, 'Giovanna Buchanan', '3 Hermina Point', 'Barurao', '8108', null, null, '461-224-3547', '5108756828226842');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (51439, 'Kendre Jirka', '71756 Onsgard Avenue', 'Akim Swedru', null, 62548019, 112, '775-375-9045', '5048378180539812');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (69734, 'Christian Robion', '23 Knutson Junction', 'Tangwang', null, 44512828, 80, '693-355-8443', '5108751118729241');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (27513, 'Maxwell Rous', '34 Ramsey Trail', 'Gaimán', '9105', 12147137, 21, '593-688-3890', '5048370999021819');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (69850, 'Carey Hayland', '5 Mitchell Junction', 'Kostanay', null, 52023067, 93, '781-823-0209', '5108755066631952');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (91340, 'Anabal Thames', '7 Meadow Valley Center', 'Hepang', null, 46555775, 83, '381-267-0569', '5108753331917918');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (26943, 'Bettine Kirtlan', '4807 Manufacturers Terrace', 'Luna', '3813', null, null, '966-591-0408', '5048370987323318');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (58370, 'Susie Marzele', '02160 Comanche Lane', 'Ōsaka-shi', '661-0963', 43123337, 77, '462-817-4897', '5048372682870817');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (60789, 'Woodie Spurret', '9 Weeping Birch Junction', 'Wolmaransstad', '2630', 59687754, 107, '192-814-4634', '5108759070996617');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (13456, 'Corey Matusov', '1 Charing Cross Parkway', 'Nunmanu', null, 50046468, 90, '798-304-7163', '5108755614845690');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (84752, 'Milissent Aggiss', '020 Division Court', 'Rustāq', null, 55148247, 99, '960-478-5649', '5108756906014938');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (61398, 'Kamila Maxwaile', '73311 Sycamore Way', 'Zhentou', null, 54177682, 97, '798-560-6666', '5108752911355960');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (37089, 'Ardyce Coghlan', '284 Maryland Parkway', 'Nekrasovka', '140074', null, null, '571-231-1155', '5048374656431303');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (19846, 'Randolph Wimbush', '70178 Vernon Avenue', 'Balangonan', '2713', null, null, '518-987-2996', '5048376783136267');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (36750, 'Gustaf Ham', '1 Melrose Plaza', 'Tyarlevo', '196625', 86040608, 154, '281-693-7950', '5048370078421401');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (13980, 'Roland Whitesel', '496 Atwood Circle', 'Zhenchuan', null, 37789163, 68, '310-555-2828', '5048376584445461');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (25983, 'Adam Gaymar', '8 Twin Pines Avenue', 'San Agustin', '48040', 38048381, 68, '629-897-9632', '5108751346001900');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (13057, 'Theressa Berthod', '7 Sunfield Alley', 'Bedayutalang', null, 98223334, 176, '418-731-1910', '5108750465157246');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (65421, 'Val Rawls', '66 Esch Drive', 'Comé', null, 38167345, 68, '933-741-0837', '5108757558913633');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (80946, 'Myrtia McGettrick', '5 Stoughton Pass', 'Al Qurayn', null, 10959195, 19, '488-162-4218', '5108754113215968');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (35069, 'Gae Gueinn', '73482 Meadow Ridge Drive', 'Negotino', '1440', null, null, '923-450-5588', '5108750532061058');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (74930, 'Odell Brik', '2268 Oakridge Pass', 'Avon', '77214 CEDEX', null, null, '131-243-0643', '5048376880554404');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (96521, 'Amelia Tigner', '9 Old Gate Junction', 'Lutou', null, 92883223, 167, '696-161-6506', '5048377616943366');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (83754, 'Alyson Duval', '956 Mallard Point', 'Telgawah', null, null, null, '318-453-5191', '5048379904653095');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (14906, 'Anthea Bonfield', '4 Troy Terrace', 'Huishangang', null, 41181565, 74, '321-797-9033', '5108753284145913');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (26470, 'Bea Bletsoe', '062 Butterfield Crossing', 'Hiratsuka', '820-0702', 96098655, 172, '988-410-6903', '5048379694060774');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (54987, 'Prisca Lagen', '42 Schiller Drive', 'Puqi', null, 91292283, 164, '867-756-5384', '5048373514125131');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (97634, 'Ebeneser Dagnan', '3991 Derek Avenue', 'Tinaco', null, 46377689, 83, '957-504-5238', '5048378869602410');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (42685, 'Kamilah Marjoram', '585 Spenser Terrace', 'Huazhou', null, 95500120, 171, '328-383-9612', '5048373979918574');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (28743, 'Stern Guswell', '76 Warbler Drive', 'Nyzhni Sirohozy', null, 79181774, 142, '565-236-7780', '5048377424708613');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (50947, 'Aggie Derrell', '9791 Orin Street', 'Philadelphia', '19151', 61231110, 110, '215-627-2585', '5108757020454190');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (74801, 'Shayne Paula', '50 Ilene Point', 'Nazaré da Mata', '55800-000', 46659136, 83, '454-738-1688', '5048378953578328');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (12358, 'Gamaliel Philler', '846 East Terrace', 'Dualing', '1103', 82432062, 148, '635-738-4129', '5048374039639317');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (17609, 'Riobard Godson', '23993 Merrick Junction', 'Stare Pole', '82-220', 66290878, 119, '584-103-4445', '5108755306946434');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (29356, 'Matthieu Carleman', '3 Grasskamp Street', 'Cetinje', null, 37199661, 66, '623-221-8443', '5108751547330975');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (84059, 'Silva Leak', '63 Milwaukee Alley', 'Ueda', '963-5343', 61072649, 109, '674-845-2085', '5108750581957115');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (71390, 'Danica Torrie', '68106 Sunnyside Lane', 'Amersfoort', '3805', 94878670, 170, '579-390-1674', '5048375426072525');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (85176, 'Cynthia Becraft', '3 Buell Parkway', 'Jianyangping', null, 47511557, 85, '536-442-7277', '5048379593786545');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (49860, 'Maryjane Watkiss', '8 Loomis Lane', 'Nyamanari', null, 34720505, 62, '786-725-1284', '5108751307156859');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (70891, 'Susie Grafham', '335 Cambridge Parkway', 'Panaitólion', null, 14043030, 25, '508-134-4257', '5108758437829933');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (58064, 'Talyah Trenouth', '0417 Meadow Vale Road', 'Dongshui', null, 32875246, 59, '242-711-4511', '5048376486075184');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (61908, 'Georgetta Savine', '75 Victoria Drive', 'Toshbuloq', null, 40722018, 73, '364-805-3455', '5108756033834380');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (43750, 'Glenna Chittenden', '7840 Rutledge Pass', 'Sovetakan', null, 48106191, 86, '364-300-2853', '5108756593399170');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (30682, 'Cynthie MacGillreich', '42 Green Lane', 'Tanjungsari Barat', null, null, null, '625-642-1320', '5108752207552270');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (94270, 'Ian Bye', '33682 Cascade Way', 'Stari Grad', '21460', 20682592, 37, '578-589-0325', '5048370981106644');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (57284, 'Bo Gremane', '945 Dennis Place', 'Paris 12', '75582 CEDEX 12', 95883076, 172, '681-733-3891', '5108756076081162');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (46301, 'Ludvig Cadwell', '8005 Westridge Plaza', 'Fatufeto', null, 33495244, 60, '207-717-2540', '5048376053054851');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (23086, 'Lonny Ruse', '20 Fallview Street', 'Lons-le-Saunier', '39039 CEDEX 9', 48805240, 87, '222-439-2253', '5048370918758830');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (79021, 'Yasmeen Elvins', '3 Moland Park', 'Tirmiz', null, 13185218, 23, '262-370-9764', '5108757813563843');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (86502, 'Malissa Pawley', '79 Hansons Alley', 'Jiaowei', null, 71884781, 129, '321-883-2143', '5108755641592216');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (59834, 'Marni Croisier', '27798 Hooker Lane', 'La Laguna', '51247', 58616853, 105, '288-736-1073', '5048372871995086');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (65784, 'Reginauld Core', '6 Center Place', 'Bulgan', null, 53008186, 95, '865-168-3954', '5048379967896722');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (51486, 'Lauren le Keux', '6765 Old Gate Way', 'Jaquimeyes', '10411', 92015866, 165, '796-950-2546', '5048373447187919');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (48720, 'Ainslie Caws', '59 3rd Lane', 'Huabu', null, 33946791, 61, '651-253-9943', '5048373479545240');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (36572, 'Tanya Arundale', '07003 South Avenue', 'Jakšić', '34308', 20037833, 36, '441-198-8170', '5048370448425348');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (17543, 'Shelia Grouvel', '55 Monterey Road', 'Gomunice', '97-545', null, null, '212-495-4222', '5048372855362303');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (69438, 'Diann Detoc', '72 Arkansas Road', 'Miaoli', null, null, null, '151-603-0248', '5108750422829549');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (56780, 'Abbye Wogdon', '969 Memorial Pass', 'Zaña', null, 91766874, 165, '575-757-4110', '5048374077347799');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (43052, 'Elnar Warhurst', '95 Monument Avenue', 'Port Barton', '6819', 57052378, 102, '184-212-9733', '5108757840972587');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (18049, 'Elisabet Flood', '304 La Follette Place', 'Kuncen', null, 35250329, 63, '455-545-6744', '5048370516857349');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (62503, 'Germaine Scrace', '50466 Clemons Crossing', 'Kaskinen', '64260', 25836151, 46, '379-890-3103', '5108758097659422');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (92510, 'Devlin Garrelts', '74248 Warbler Lane', 'Ewirgol', null, 33350009, 60, '272-502-5018', '5048374671895771');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (34678, 'Lois Currell', '52394 Hauk Trail', 'Kakanj', null, 67329265, 121, '275-300-3227', '5048374510608989');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (76243, 'Harlen Tythacott', '938 Drewry Pass', 'Povedniki', '172026', 22283350, 40, '956-464-6607', '5048379488687725');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (82016, 'Hope Taffarello', '5 Hazelcrest Point', 'Skellefteå', '931 57', 30638188, 55, '931-137-3794', '5108759264316002');
insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (59348, 'Zacharia Crosland', '973 Linden Drive', 'Tomé Açu', '15640-000', 31034533, 55, '539-690-6951', '5108753512571377');

insert into RoomType (roomTypeID, roomTypeName, totalBathroom, totalBedroom, dollarDaily, pointDaily) values ('HS1', 'Single', 1, 1, 75, 35);
insert into RoomType (roomTypeID, roomTypeName, totalBathroom, totalBedroom, dollarDaily, pointDaily) values ('HD1', 'Double', 1, 2, 130, 65);
insert into RoomType (roomTypeID, roomTypeName, totalBathroom, totalBedroom, dollarDaily, pointDaily) values ('HD2', 'Double', 2, 2, 150, 75);
insert into RoomType (roomTypeID, roomTypeName, totalBathroom, totalBedroom, dollarDaily, pointDaily) values ('HT1', 'Triple', 2, 3, 225, 110);

insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 11, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 11, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 11, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 11, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 11, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 11, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 11, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 11, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 12, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 12, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 12, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 12, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 12, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 12, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 12, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 12, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 13, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 13, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 13, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 13, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 13, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 13, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 13, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 13, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 14, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 14, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 14, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 14, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 14, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 14, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 14, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 14, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 15, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 15, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 15, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 15, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 15, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 15, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 15, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 15, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 21, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 21, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 21, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 21, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 21, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 21, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 21, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 21, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 22, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 22, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 22, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 22, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 22, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 22, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 22, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 22, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 23, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 23, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 23, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 23, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 23, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 23, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 23, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 23, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 24, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 24, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 24, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 24, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 24, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 24, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 24, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 24, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 25, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 25, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 25, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 25, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 25, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 25, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 25, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 25, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 31, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 31, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 31, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 31, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 31, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 31, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 31, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 31, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 32, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 32, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 32, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 32, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 32, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 32, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 32, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 32, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 33, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 33, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 33, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 33, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 33, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 33, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 33, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 33, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 34, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 34, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 34, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 34, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 34, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 34, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 34, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 34, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (12345, 35, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45678, 35, 'HD2', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (67890, 35, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (78901, 35, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (23459, 35, 'HD1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (34560, 35, 'HS1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (45671, 35, 'HT1', 0, 0);
insert into Room (hotelID, roomNumber, roomTypeID, statusOccupation, statusCleaning) values (56782, 35, 'HS1', 0, 0);

UPDATE Room
SET statusOccupation = 1, statusCleaning = 0
WHERE (hotelID, roomNumber) IN (
SELECT hotelID, roomNumber
FROM Reservation
WHERE SYSDATE BETWEEN dateCheckIn AND dateCheckOut
);

insert into Amenities (hotelID, amenityName) values (45671, 'Laundry available');
insert into Amenities (hotelID, amenityName) values (12345, 'Bar');
insert into Amenities (hotelID, amenityName) values (45671, 'Swimming pool');
insert into Amenities (hotelID, amenityName) values (34560, 'Free breakfast');
insert into Amenities (hotelID, amenityName) values (12345, 'Free breakfast');
insert into Amenities (hotelID, amenityName) values (45671, 'Bar');
insert into Amenities (hotelID, amenityName) values (67890, 'Swimming pool');
insert into Amenities (hotelID, amenityName) values (23459, 'Fitness center');
insert into Amenities (hotelID, amenityName) values (78901, 'Laundry available');
insert into Amenities (hotelID, amenityName) values (45678, 'Free breakfast');
insert into Amenities (hotelID, amenityName) values (12345, 'Laundry available');
insert into Amenities (hotelID, amenityName) values (45678, 'Swimming pool');
insert into Amenities (hotelID, amenityName) values (45678, 'Bar');
insert into Amenities (hotelID, amenityName) values (67890, 'Laundry available');
insert into Amenities (hotelID, amenityName) values (67890, 'Bar');
insert into Amenities (hotelID, amenityName) values (45671, 'Fitness center');
insert into Amenities (hotelID, amenityName) values (23459, 'Laundry available');
insert into Amenities (hotelID, amenityName) values (56782, 'Laundry available');
insert into Amenities (hotelID, amenityName) values (45678, 'Fitness center');
insert into Amenities (hotelID, amenityName) values (23459, 'Free breakfast');
insert into Amenities (hotelID, amenityName) values (34560, 'Bar');
insert into Amenities (hotelID, amenityName) values (12345, 'Fitness center');
insert into Amenities (hotelID, amenityName) values (78901, 'Swimming pool');
insert into Amenities (hotelID, amenityName) values (23459, 'Swimming pool');
insert into Amenities (hotelID, amenityName) values (56782, 'Swimming pool');
insert into Amenities (hotelID, amenityName) values (56782, 'Free breakfast');
insert into Amenities (hotelID, amenityName) values (34560, 'Laundry available');

insert into Rates (rateID, dateRateStart, dateRateEnd, rateMultiplier) values ('Spring Break', TO_DATE('0310', 'MMDD'), TO_DATE('0324', 'MMDD'), 1.4);
insert into Rates (rateID, dateRateStart, dateRateEnd, rateMultiplier) values ('Christmas', TO_DATE('1222', 'MMDD'), TO_DATE('1231', 'MMDD'), 1.5);
insert into Rates (rateID, dateRateStart, dateRateEnd, rateMultiplier) values ('New Years', TO_DATE('0101', 'MMDD'), TO_DATE('0103', 'MMDD'), 1.5);
insert into Rates (rateID, dateRateStart, dateRateEnd, rateMultiplier) values ('Independence Day', TO_DATE('0702', 'MMDD'), TO_DATE('0705', 'MMDD'), 1.3);
insert into Rates (rateID, dateRateStart, dateRateEnd, rateMultiplier) values ('Normal', NULL, NULL, 1);
insert into Rates (rateID, dateRateStart, dateRateEnd, rateMultiplier) values ('Reduced', TO_DATE('0901', 'MMDD'), TO_DATE('1025', 'MMDD'), .8);
insert into Rates (rateID, dateRateStart, dateRateEnd, rateMultiplier) values ('Thanksgiving', TO_DATE('1120', 'MMDD'), TO_DATE('1130', 'MMDD'), 1.25);

insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (1, 59103, 45678, 15, '21-Jul-2023', '01-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (2, 69425, 45671, 33, '18-Jul-2023', '01-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (3, 97634, 34560, 35, '04-Dec-2023', '07-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (4, 69850, 45678, 12, '20-Jan-2023', '29-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (5, 87143, 45678, 12, '02-Jul-2023', '03-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (6, 51798, 45678, 35, '18-Jun-2023', '29-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (7, 67845, 67890, 11, '17-Apr-2023', '19-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (8, 36750, 12345, 12, '22-Dec-2023', '06-Jan-2024');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (9, 50234, 78901, 14, '17-Nov-2023', '22-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (10, 58064, 78901, 23, '01-Dec-2023', '14-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (11, 74801, 45671, 22, '09-Feb-2023', '20-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (12, 53607, 56782, 35, '30-Nov-2023', '04-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (13, 50234, 12345, 34, '21-Apr-2023', '04-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (14, 93625, 78901, 25, '09-Sep-2023', '22-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (15, 49860, 23459, 32, '13-Apr-2023', '27-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (16, 98624, 56782, 22, '08-Mar-2023', '14-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (17, 14906, 23459, 31, '07-Nov-2023', '10-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (18, 37654, 12345, 15, '04-Sep-2023', '10-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (19, 70153, 34560, 22, '08-Apr-2023', '19-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (20, 96172, 78901, 21, '16-Apr-2023', '30-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (21, 54793, 56782, 35, '10-Sep-2023', '15-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (22, 43570, 45671, 33, '21-Nov-2023', '01-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (23, 17609, 12345, 31, '26-Feb-2023', '27-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (24, 37096, 12345, 24, '15-Mar-2023', '20-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (25, 56780, 23459, 23, '19-Jun-2023', '02-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (26, 52901, 78901, 34, '10-Jan-2023', '19-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (27, 37089, 78901, 14, '26-Mar-2023', '07-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (28, 65784, 78901, 13, '28-May-2023', '30-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (29, 24109, 23459, 22, '17-Jul-2023', '01-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (30, 69734, 67890, 33, '04-Dec-2023', '06-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (31, 20793, 23459, 15, '26-Mar-2023', '01-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (32, 37096, 45671, 11, '11-May-2023', '16-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (33, 36572, 23459, 14, '04-May-2023', '11-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (34, 49860, 34560, 35, '23-Feb-2023', '05-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (35, 98624, 45671, 15, '22-Feb-2023', '07-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (36, 19846, 56782, 31, '22-Feb-2023', '26-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (37, 70891, 12345, 14, '18-Feb-2023', '24-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (38, 32090, 45671, 23, '09-Apr-2023', '24-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (39, 24039, 12345, 13, '19-Dec-2023', '01-Jan-2024');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (40, 82016, 56782, 15, '07-Mar-2023', '09-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (41, 12485, 12345, 25, '20-May-2023', '28-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (42, 14307, 45671, 22, '28-Mar-2023', '02-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (43, 59834, 23459, 21, '02-Dec-2023', '12-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (44, 42513, 56782, 13, '30-Jul-2023', '11-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (45, 70935, 67890, 24, '23-Aug-2023', '30-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (46, 31867, 12345, 25, '23-Jan-2023', '07-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (47, 69251, 23459, 13, '30-May-2023', '10-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (48, 84059, 78901, 11, '14-Sep-2023', '19-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (49, 14796, 12345, 12, '05-Jan-2023', '07-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (50, 35691, 45671, 31, '23-Mar-2023', '25-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (51, 74801, 45671, 32, '27-Jun-2023', '09-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (52, 51798, 34560, 31, '15-Nov-2023', '17-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (53, 51486, 56782, 22, '11-Apr-2023', '25-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (54, 87539, 56782, 32, '08-Jun-2023', '14-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (55, 51439, 67890, 24, '08-Apr-2023', '21-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (56, 13456, 23459, 34, '10-Dec-2023', '12-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (57, 50234, 45671, 33, '25-Jan-2023', '27-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (58, 12485, 67890, 15, '25-Feb-2023', '09-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (59, 67024, 56782, 31, '19-Jun-2023', '23-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (60, 17543, 78901, 21, '20-Nov-2023', '29-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (61, 98624, 45671, 13, '20-Mar-2023', '01-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (62, 62503, 23459, 21, '21-May-2023', '04-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (63, 51439, 23459, 31, '20-Aug-2023', '03-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (64, 70891, 23459, 15, '04-Dec-2023', '07-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (65, 71483, 67890, 32, '19-Aug-2023', '24-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (66, 87143, 45671, 33, '04-Jan-2023', '19-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (67, 69850, 78901, 22, '12-Mar-2023', '14-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (68, 69438, 23459, 23, '19-Oct-2023', '20-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (69, 67845, 56782, 15, '15-Feb-2023', '19-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (70, 61908, 23459, 33, '28-Feb-2023', '06-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (71, 35069, 45671, 13, '24-Jul-2023', '07-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (72, 69734, 45678, 11, '30-Nov-2023', '04-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (73, 50873, 23459, 31, '03-Jun-2023', '17-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (74, 78692, 45678, 33, '08-Jun-2023', '13-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (75, 53607, 56782, 31, '23-Jun-2023', '28-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (76, 42685, 67890, 35, '10-Sep-2023', '23-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (77, 48537, 78901, 11, '08-Oct-2023', '23-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (78, 79021, 45678, 32, '17-May-2023', '19-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (79, 50947, 56782, 12, '14-Oct-2023', '24-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (80, 61302, 23459, 12, '22-Apr-2023', '25-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (81, 36750, 56782, 31, '15-Sep-2023', '29-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (82, 70153, 67890, 34, '27-Jun-2023', '04-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (83, 32057, 34560, 11, '13-Jun-2023', '25-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (84, 48537, 67890, 14, '19-Jun-2023', '22-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (85, 51439, 34560, 21, '14-Apr-2023', '20-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (86, 42513, 12345, 35, '24-Jun-2023', '07-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (87, 74930, 78901, 11, '06-Dec-2023', '14-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (88, 32057, 67890, 22, '25-Dec-2023', '03-Jan-2024');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (89, 69837, 67890, 15, '13-Aug-2023', '28-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (90, 10475, 23459, 31, '15-Dec-2023', '24-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (91, 34678, 78901, 15, '18-Jan-2023', '31-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (92, 62503, 45671, 25, '09-May-2023', '17-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (93, 24039, 56782, 34, '14-Jul-2023', '28-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (94, 43052, 12345, 22, '26-Nov-2023', '03-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (95, 91340, 12345, 33, '05-Jun-2023', '19-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (96, 19846, 78901, 23, '23-Jan-2023', '05-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (97, 51486, 67890, 32, '14-Nov-2023', '17-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (98, 51486, 45671, 21, '17-Dec-2023', '24-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (99, 37089, 34560, 14, '18-Feb-2023', '21-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (100, 46581, 45671, 14, '19-Oct-2023', '29-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (101, 24061, 34560, 23, '12-Feb-2023', '27-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (102, 53749, 67890, 14, '02-Nov-2023', '04-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (103, 84752, 67890, 33, '11-Jun-2023', '19-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (104, 69837, 34560, 31, '22-Nov-2023', '01-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (105, 35691, 12345, 12, '22-Jan-2023', '28-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (106, 42685, 78901, 32, '06-Mar-2023', '19-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (107, 51798, 56782, 21, '10-Apr-2023', '16-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (108, 39524, 56782, 12, '29-Apr-2023', '30-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (109, 51247, 67890, 35, '02-Oct-2023', '04-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (110, 26470, 56782, 32, '28-Sep-2023', '09-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (111, 70891, 45671, 15, '10-Mar-2023', '20-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (112, 35069, 45678, 24, '03-Jan-2023', '13-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (113, 23086, 45678, 34, '29-Apr-2023', '09-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (114, 84752, 67890, 32, '10-Oct-2023', '24-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (115, 35069, 12345, 34, '02-Oct-2023', '14-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (116, 28743, 23459, 33, '15-Mar-2023', '16-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (117, 48537, 78901, 32, '17-Oct-2023', '01-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (118, 43750, 45678, 21, '25-Dec-2023', '27-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (119, 70438, 45678, 25, '03-Jun-2023', '18-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (120, 83754, 23459, 11, '10-Apr-2023', '13-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (121, 24061, 12345, 24, '22-Nov-2023', '23-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (122, 30682, 45671, 11, '05-Nov-2023', '07-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (123, 36572, 34560, 25, '20-Oct-2023', '03-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (124, 87143, 12345, 34, '17-Mar-2023', '18-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (125, 24109, 78901, 14, '05-Sep-2023', '07-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (126, 86502, 67890, 11, '26-Sep-2023', '09-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (127, 14796, 45678, 31, '10-Dec-2023', '21-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (128, 53749, 67890, 15, '05-Mar-2023', '11-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (129, 53607, 34560, 32, '20-Aug-2023', '24-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (130, 17609, 23459, 14, '29-Dec-2023', '05-Jan-2024');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (131, 27513, 45678, 31, '04-Jun-2023', '07-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (132, 86179, 45671, 34, '29-Jul-2023', '05-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (133, 86502, 78901, 32, '06-Nov-2023', '21-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (134, 37654, 34560, 23, '06-Sep-2023', '07-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (135, 78692, 34560, 25, '26-Jan-2023', '06-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (136, 79021, 12345, 13, '15-Mar-2023', '19-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (137, 28743, 12345, 11, '15-Feb-2023', '18-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (138, 48537, 23459, 15, '27-Feb-2023', '04-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (139, 50873, 56782, 33, '08-Feb-2023', '22-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (140, 46301, 45678, 11, '22-Dec-2023', '02-Jan-2024');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (141, 51486, 78901, 35, '30-Dec-2023', '04-Jan-2024');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (142, 61908, 56782, 15, '09-Aug-2023', '20-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (143, 58370, 45678, 21, '09-Jul-2023', '12-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (144, 35069, 34560, 21, '07-Oct-2023', '10-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (145, 54987, 23459, 14, '10-Jun-2023', '20-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (146, 51439, 56782, 21, '21-Oct-2023', '23-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (147, 50873, 45678, 21, '28-Aug-2023', '31-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (148, 79021, 56782, 15, '14-Dec-2023', '15-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (149, 18347, 78901, 35, '12-May-2023', '26-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (150, 98624, 23459, 11, '30-Jul-2023', '02-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (151, 87539, 67890, 15, '21-Mar-2023', '04-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (152, 50873, 12345, 22, '15-Jul-2023', '16-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (153, 84752, 67890, 31, '27-Mar-2023', '29-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (154, 67024, 45678, 14, '14-Jul-2023', '15-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (155, 78692, 45678, 25, '16-Jun-2023', '01-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (156, 75094, 12345, 25, '19-Jun-2023', '24-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (157, 37654, 56782, 13, '10-Oct-2023', '24-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (158, 26943, 67890, 31, '25-Jan-2023', '30-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (159, 25983, 45678, 35, '29-Apr-2023', '11-May-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (160, 31867, 34560, 34, '17-Feb-2023', '27-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (161, 79021, 78901, 15, '12-Jun-2023', '26-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (162, 51247, 56782, 23, '19-Jul-2023', '31-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (163, 78692, 67890, 24, '26-May-2023', '08-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (164, 97015, 78901, 23, '08-Jun-2023', '22-Jun-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (165, 37096, 45671, 35, '17-Feb-2023', '21-Feb-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (166, 26943, 45678, 11, '25-Mar-2023', '30-Mar-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (167, 19857, 45671, 25, '20-Jan-2023', '31-Jan-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (168, 24061, 34560, 31, '25-Aug-2023', '07-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (169, 19857, 12345, 14, '19-Sep-2023', '23-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (170, 54793, 34560, 12, '22-Aug-2023', '27-Aug-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (171, 13980, 34560, 33, '06-Nov-2023', '09-Nov-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (172, 69734, 23459, 33, '12-Sep-2023', '19-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (173, 93608, 12345, 15, '12-Apr-2023', '13-Apr-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (174, 56780, 23459, 24, '05-Sep-2023', '16-Sep-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (175, 61908, 34560, 22, '21-Dec-2023', '02-Jan-2024');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (176, 19857, 78901, 34, '21-Oct-2023', '31-Oct-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (177, 37654, 12345, 33, '26-Jul-2023', '30-Jul-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (178, 32068, 67890, 31, '25-Nov-2023', '10-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (179, 64085, 56782, 13, '14-Dec-2023', '26-Dec-2023');
insert into Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) values (180, 93608, 67890, 32, '13-Sep-2023', '16-Sep-2023');

INSERT INTO RateCalc (reservationID, roomTypeID, rateID)
SELECT r.reservationID, rt.roomTypeID, ra.rateID
FROM Reservation r
JOIN Room rm ON r.roomNumber = rm.roomNumber AND r.hotelID = rm.hotelID
JOIN RoomType rt ON rm.roomTypeID = rt.roomTypeID
JOIN Rates ra ON (r.dateCheckIn BETWEEN ra.dateRateStart AND ra.dateRateEnd)
OR (r.dateCheckOut BETWEEN ra.dateRateStart AND ra.dateRateEnd);

INSERT INTO RateCalc (reservationID, roomTypeID, rateID)
SELECT r.reservationID, rt.roomTypeID, 'Normal'
FROM Reservation r
JOIN Room rm ON r.roomNumber = rm.roomNumber AND r.hotelID = rm.hotelID
JOIN RoomType rt ON rm.roomTypeID = rt.roomTypeID
WHERE NOT EXISTS (
  SELECT 1
  FROM Rates ra
  WHERE (r.dateCheckIn BETWEEN ra.dateRateStart AND ra.dateRateEnd)
  OR (r.dateCheckOut BETWEEN ra.dateRateStart AND ra.dateRateEnd)
);

insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3352577, 1, 1, 0, TO_TIMESTAMP('2023-03-23 22:59:52' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9379331, 2, 0, 1, TO_TIMESTAMP('2023-01-26 13:22:38' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6328323, 3, 1, 0, TO_TIMESTAMP('2022-09-02 15:58:18' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4226055, 4, 1, 0, TO_TIMESTAMP('2022-06-15 13:54:35' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3268617, 5, 0, 1, TO_TIMESTAMP('2023-01-26 06:18:18' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3378191, 6, 1, 0, TO_TIMESTAMP('2023-01-16 17:33:45' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8497169, 7, 0, 1, TO_TIMESTAMP('2022-10-21 12:30:32' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6316051, 8, 0, 1, TO_TIMESTAMP('2022-06-12 23:01:35' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7966739, 9, 0, 1, TO_TIMESTAMP('2022-08-24 13:59:54' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6699542, 10, 1, 0, TO_TIMESTAMP('2023-01-19 16:42:26' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8859672, 11, 0, 1, TO_TIMESTAMP('2022-12-19 06:33:28' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2987035, 12, 0, 1, TO_TIMESTAMP('2022-08-12 06:25:51' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1487900, 13, 1, 0, TO_TIMESTAMP('2022-10-25 17:41:40' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2412063, 14, 1, 0, TO_TIMESTAMP('2023-04-20 11:33:31' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2503202, 15, 0, 1, TO_TIMESTAMP('2023-02-24 00:57:21' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5896228, 16, 1, 0, TO_TIMESTAMP('2023-03-05 07:14:28' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8266276, 17, 1, 0, TO_TIMESTAMP('2022-10-15 20:58:06' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6927398, 18, 0, 1, TO_TIMESTAMP('2023-02-02 20:29:05' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8486953, 19, 1, 0, TO_TIMESTAMP('2022-05-20 10:32:52' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9206827, 20, 0, 1, TO_TIMESTAMP('2022-11-22 14:35:04' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6291500, 21, 0, 1, TO_TIMESTAMP('2022-05-28 18:18:19' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3104308, 22, 1, 0, TO_TIMESTAMP('2023-01-22 02:05:50' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3390525, 23, 1, 0, TO_TIMESTAMP('2022-11-20 13:12:03' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7857216, 24, 1, 0, TO_TIMESTAMP('2023-02-20 17:52:25' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1855040, 25, 1, 0, TO_TIMESTAMP('2022-06-04 20:50:56' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8459846, 26, 1, 0, TO_TIMESTAMP('2022-08-10 23:41:08' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7833673, 27, 1, 0, TO_TIMESTAMP('2023-01-07 06:22:00' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6280786, 28, 0, 1, TO_TIMESTAMP('2022-09-12 03:31:13' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1131605, 29, 0, 1, TO_TIMESTAMP('2022-10-18 15:44:22' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5956183, 30, 1, 0, TO_TIMESTAMP('2022-11-13 22:55:33' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3428440, 31, 1, 0, TO_TIMESTAMP('2022-05-03 08:57:57' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3293272, 32, 0, 1, TO_TIMESTAMP('2023-04-24 18:19:40' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3351645, 33, 0, 1, TO_TIMESTAMP('2022-12-04 13:25:51' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2643552, 34, 0, 1, TO_TIMESTAMP('2022-07-01 13:06:48' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4999267, 35, 1, 0, TO_TIMESTAMP('2022-12-04 09:34:05' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7254629, 36, 1, 0, TO_TIMESTAMP('2022-11-25 13:09:40' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4236391, 37, 1, 0, TO_TIMESTAMP('2022-10-11 18:58:32' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7999594, 38, 0, 1, TO_TIMESTAMP('2022-10-19 17:53:17' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2263148, 39, 0, 1, TO_TIMESTAMP('2023-01-18 09:21:35' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4938348, 40, 1, 0, TO_TIMESTAMP('2022-07-25 09:37:13' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6584943, 41, 1, 0, TO_TIMESTAMP('2023-02-09 07:42:35' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1067123, 42, 0, 1, TO_TIMESTAMP('2023-01-12 14:31:13' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8087668, 43, 0, 1, TO_TIMESTAMP('2022-09-19 16:45:38' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6539894, 44, 1, 0, TO_TIMESTAMP('2022-05-11 00:16:32' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4211832, 45, 1, 0, TO_TIMESTAMP('2023-01-22 16:42:30' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3926137, 46, 0, 1, TO_TIMESTAMP('2023-04-21 15:56:55' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7030396, 47, 1, 0, TO_TIMESTAMP('2022-12-29 20:19:54' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8642686, 48, 0, 1, TO_TIMESTAMP('2023-02-23 04:52:51' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6569091, 49, 1, 0, TO_TIMESTAMP('2022-11-26 16:53:41' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9416326, 50, 0, 1, TO_TIMESTAMP('2022-08-19 20:52:32' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4444294, 51, 0, 1, TO_TIMESTAMP('2023-03-10 12:51:00' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8265863, 52, 0, 1, TO_TIMESTAMP('2023-03-08 11:01:50' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8468617, 53, 1, 0, TO_TIMESTAMP('2023-02-13 01:05:26' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9514637, 54, 1, 0, TO_TIMESTAMP('2023-02-27 03:00:57' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3115662, 55, 0, 1, TO_TIMESTAMP('2022-09-16 18:09:35' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6167698, 56, 1, 0, TO_TIMESTAMP('2022-08-16 09:50:34' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5272725, 57, 0, 1, TO_TIMESTAMP('2022-09-11 19:41:19' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1958562, 58, 0, 1, TO_TIMESTAMP('2022-11-04 07:53:26' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6254758, 59, 1, 0, TO_TIMESTAMP('2023-02-05 22:37:29' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3019434, 60, 1, 0, TO_TIMESTAMP('2023-03-13 11:04:30' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4329645, 61, 1, 0, TO_TIMESTAMP('2022-12-03 03:14:18' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5505198, 62, 0, 1, TO_TIMESTAMP('2022-10-24 00:39:54' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3816112, 63, 1, 0, TO_TIMESTAMP('2022-11-22 00:51:31' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1855152, 64, 1, 0, TO_TIMESTAMP('2022-08-08 03:23:29' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2625715, 65, 0, 1, TO_TIMESTAMP('2023-03-19 10:57:49' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8348854, 66, 0, 1, TO_TIMESTAMP('2023-01-06 17:54:22' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4839095, 67, 0, 1, TO_TIMESTAMP('2023-03-14 20:05:57' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8858296, 68, 1, 0, TO_TIMESTAMP('2023-03-01 13:39:01' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5948086, 69, 0, 1, TO_TIMESTAMP('2022-09-28 14:28:54' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4875450, 70, 0, 1, TO_TIMESTAMP('2023-02-12 22:45:59' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7650491, 71, 1, 0, TO_TIMESTAMP('2022-07-26 23:00:07' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2310652, 72, 1, 0, TO_TIMESTAMP('2023-03-08 07:27:57' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7904960, 73, 0, 1, TO_TIMESTAMP('2022-11-30 18:02:15' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9759937, 74, 1, 0, TO_TIMESTAMP('2023-04-23 16:44:27' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4521152, 75, 1, 0, TO_TIMESTAMP('2023-03-28 17:12:59' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1107651, 76, 0, 1, TO_TIMESTAMP('2023-02-13 11:00:17' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4461760, 77, 0, 1, TO_TIMESTAMP('2023-01-27 12:31:46' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1227971, 78, 0, 1, TO_TIMESTAMP('2023-03-09 18:48:32' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6249153, 79, 0, 1, TO_TIMESTAMP('2022-10-06 19:25:52' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6429895, 80, 0, 1, TO_TIMESTAMP('2022-09-25 06:52:30' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3348173, 81, 0, 1, TO_TIMESTAMP('2023-03-22 03:14:12' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6114512, 82, 1, 0, TO_TIMESTAMP('2022-06-23 22:31:36' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5581010, 83, 1, 0, TO_TIMESTAMP('2023-01-17 12:17:55' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3310817, 84, 0, 1, TO_TIMESTAMP('2022-06-14 12:51:46' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9709794, 85, 1, 0, TO_TIMESTAMP('2023-01-26 22:40:08' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6975204, 86, 1, 0, TO_TIMESTAMP('2022-09-04 04:01:55' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6872804, 87, 0, 1, TO_TIMESTAMP('2022-12-14 17:55:59' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3991788, 88, 0, 1, TO_TIMESTAMP('2023-02-15 00:54:20' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5717229, 89, 0, 1, TO_TIMESTAMP('2022-12-26 16:10:12' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6503155, 90, 1, 0, TO_TIMESTAMP('2023-04-13 22:54:20' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8037108, 91, 0, 1, TO_TIMESTAMP('2023-01-09 13:35:14' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1095416, 92, 0, 1, TO_TIMESTAMP('2023-01-31 12:10:45' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8061689, 93, 0, 1, TO_TIMESTAMP('2022-11-01 17:10:02' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9408254, 94, 1, 0, TO_TIMESTAMP('2022-09-04 13:57:09' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4137728, 95, 0, 1, TO_TIMESTAMP('2023-01-29 23:02:26' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5857031, 96, 1, 0, TO_TIMESTAMP('2023-02-17 20:21:08' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2903815, 97, 1, 0, TO_TIMESTAMP('2022-06-23 03:31:08' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5332745, 98, 0, 1, TO_TIMESTAMP('2023-02-10 08:02:23' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9341706, 99, 0, 1, TO_TIMESTAMP('2022-09-29 01:22:02' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8009482, 100, 0, 1, TO_TIMESTAMP('2023-02-03 03:14:29' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9599244, 101, 0, 1, TO_TIMESTAMP('2022-07-23 21:15:28' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1955591, 102, 0, 1, TO_TIMESTAMP('2022-10-04 01:07:43' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7084302, 103, 0, 1, TO_TIMESTAMP('2022-09-10 05:24:03' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9889558, 104, 0, 1, TO_TIMESTAMP('2023-01-09 01:59:28' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4230936, 105, 0, 1, TO_TIMESTAMP('2022-12-12 23:30:48' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2253089, 106, 1, 0, TO_TIMESTAMP('2022-10-13 18:58:44' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3973410, 107, 0, 1, TO_TIMESTAMP('2023-02-26 20:38:20' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7382819, 108, 1, 0, TO_TIMESTAMP('2022-11-15 05:11:59' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4118820, 109, 0, 1, TO_TIMESTAMP('2022-06-04 08:11:19' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9805093, 110, 0, 1, TO_TIMESTAMP('2022-10-04 11:05:39' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2685734, 111, 0, 1, TO_TIMESTAMP('2022-06-11 03:32:58' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1478948, 112, 1, 0, TO_TIMESTAMP('2022-11-15 01:29:37' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5208365, 113, 1, 0, TO_TIMESTAMP('2022-11-07 08:50:43' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6128430, 114, 0, 1, TO_TIMESTAMP('2023-04-12 15:42:53' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1811249, 115, 1, 0, TO_TIMESTAMP('2023-02-05 10:03:04' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8019762, 116, 0, 1, TO_TIMESTAMP('2022-05-07 22:18:09' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5580599, 117, 0, 1, TO_TIMESTAMP('2022-05-03 06:19:57' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8102713, 118, 0, 1, TO_TIMESTAMP('2022-11-02 07:46:17' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7718208, 119, 0, 1, TO_TIMESTAMP('2022-07-23 04:13:51' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5646144, 120, 1, 0, TO_TIMESTAMP('2022-10-19 10:29:21' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7544642, 121, 1, 0, TO_TIMESTAMP('2023-01-09 02:07:39' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1630530, 122, 1, 0, TO_TIMESTAMP('2022-09-14 15:41:32' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5270852, 123, 0, 1, TO_TIMESTAMP('2022-12-14 02:06:16' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7970120, 124, 0, 1, TO_TIMESTAMP('2023-01-12 07:02:10' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5671755, 125, 0, 1, TO_TIMESTAMP('2022-05-29 23:46:53' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1843022, 126, 0, 1, TO_TIMESTAMP('2022-08-07 10:35:45' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1471318, 127, 1, 0, TO_TIMESTAMP('2022-09-09 19:18:47' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7945049, 128, 0, 1, TO_TIMESTAMP('2023-04-26 00:41:33' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2120026, 129, 0, 1, TO_TIMESTAMP('2023-03-09 15:08:14' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6332253, 130, 0, 1, TO_TIMESTAMP('2023-04-30 02:12:58' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3150177, 131, 1, 0, TO_TIMESTAMP('2022-08-17 23:02:41' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3562849, 132, 0, 1, TO_TIMESTAMP('2022-08-16 10:44:28' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2317155, 133, 0, 1, TO_TIMESTAMP('2022-08-27 12:36:10' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5264230, 134, 1, 0, TO_TIMESTAMP('2023-01-10 17:05:48' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6877542, 135, 1, 0, TO_TIMESTAMP('2022-07-06 07:22:56' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9637224, 136, 0, 1, TO_TIMESTAMP('2022-08-27 00:59:13' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9725801, 137, 1, 0, TO_TIMESTAMP('2022-05-06 15:28:04' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2870633, 138, 1, 0, TO_TIMESTAMP('2022-10-14 15:55:37' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2353006, 139, 1, 0, TO_TIMESTAMP('2022-05-10 05:47:53' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3436403, 140, 0, 1, TO_TIMESTAMP('2022-10-20 07:00:56' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4122485, 141, 1, 0, TO_TIMESTAMP('2022-06-29 19:07:46' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5315450, 142, 1, 0, TO_TIMESTAMP('2023-04-14 10:31:22' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9470843, 143, 1, 0, TO_TIMESTAMP('2022-08-09 04:10:43' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (3694459, 144, 1, 0, TO_TIMESTAMP('2022-08-19 05:26:26' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6161789, 145, 0, 1, TO_TIMESTAMP('2022-12-31 17:31:53' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1213824, 146, 1, 0, TO_TIMESTAMP('2023-01-09 18:39:10' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4575106, 147, 0, 1, TO_TIMESTAMP('2023-03-04 18:46:31' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6502789, 148, 0, 1, TO_TIMESTAMP('2022-06-12 13:56:41' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9395593, 149, 1, 0, TO_TIMESTAMP('2022-05-14 09:42:10' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1299855, 150, 1, 0, TO_TIMESTAMP('2022-06-09 23:46:52' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2998161, 151, 0, 1, TO_TIMESTAMP('2023-04-12 06:48:46' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9131926, 152, 1, 0, TO_TIMESTAMP('2023-02-19 21:22:36' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8894874, 153, 1, 0, TO_TIMESTAMP('2022-12-02 22:50:10' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (6527904, 154, 1, 0, TO_TIMESTAMP('2022-05-30 05:46:06' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2742689, 155, 1, 0, TO_TIMESTAMP('2022-08-30 17:48:22' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7477667, 156, 1, 0, TO_TIMESTAMP('2023-04-19 11:02:49' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5876134, 157, 0, 1, TO_TIMESTAMP('2022-08-06 15:06:32' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2015656, 158, 0, 1, TO_TIMESTAMP('2022-05-12 21:31:37' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1498537, 159, 1, 0, TO_TIMESTAMP('2022-10-03 01:15:32' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9435565, 160, 1, 0, TO_TIMESTAMP('2023-03-14 08:37:05' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9581998, 161, 0, 1, TO_TIMESTAMP('2022-09-24 20:50:34' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5609397, 162, 0, 1, TO_TIMESTAMP('2023-03-08 17:22:12' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (4323766, 163, 0, 1, TO_TIMESTAMP('2022-11-06 10:34:38' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9416119, 164, 0, 1, TO_TIMESTAMP('2022-10-23 21:57:13' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8332214, 165, 0, 1, TO_TIMESTAMP('2023-04-13 04:38:13' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (2757562, 166, 1, 0, TO_TIMESTAMP('2022-12-19 07:03:24' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8844738, 167, 1, 0, TO_TIMESTAMP('2022-07-09 22:05:57' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9406405, 168, 1, 0, TO_TIMESTAMP('2022-12-29 21:12:08' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8902598, 169, 0, 1, TO_TIMESTAMP('2023-03-08 05:15:19' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (8902599, 170, 0, 1, TO_TIMESTAMP('2022-12-02 04:46:27' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9905094, 171, 1, 0, TO_TIMESTAMP('2022-12-25 06:29:49' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5860304, 172, 1, 0, TO_TIMESTAMP('2022-08-11 03:16:51' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7131600, 173, 0, 1, TO_TIMESTAMP('2022-08-12 18:56:04' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5167575, 174, 0, 1, TO_TIMESTAMP('2022-06-06 22:38:37' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7206879, 175, 0, 1, TO_TIMESTAMP('2023-01-06 15:23:17' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (7891943, 176, 1, 0, TO_TIMESTAMP('2022-06-16 16:41:23' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (1049068, 177, 1, 0, TO_TIMESTAMP('2022-10-07 14:20:40' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9194991, 178, 0, 1, TO_TIMESTAMP('2023-03-06 02:47:30' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (9167859, 179, 1, 0, TO_TIMESTAMP('2022-06-28 19:53:43' , 'YYYY-MM-DD HH24:MI:SS'));
insert into Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) values (5205500, 180, 1, 0, TO_TIMESTAMP('2022-08-23 06:01:16' , 'YYYY-MM-DD HH24:MI:SS'));

UPDATE Receipt rec
SET rec.dollarsPaid = (
  SELECT SUM(rts.rateMultiplier * rt.dollarDaily * 
             (rs.dateCheckOut - rs.dateCheckIn)) AS total_rate
  FROM Reservation rs
  JOIN RateCalc rc ON rs.reservationID = rc.reservationID
  JOIN RoomType rt ON rt.roomTypeID = rc.roomTypeID
  JOIN Rates rts ON rts.rateID = rc.rateID
  WHERE rec.reservationID = rs.reservationID
)
WHERE rec.dollarsPaid = 1;

UPDATE Receipt rec
SET rec.pointsPaid = (
  SELECT SUM(rts.rateMultiplier * rt.pointDaily * 
             (rs.dateCheckOut - rs.dateCheckIn)) AS total_rate
  FROM Reservation rs
  JOIN RateCalc rc ON rs.reservationID = rc.reservationID
  JOIN RoomType rt ON rt.roomTypeID = rc.roomTypeID
  JOIN Rates rts ON rts.rateID = rc.rateID
  WHERE rec.reservationID = rs.reservationID
)
WHERE rec.pointsPaid = 1;

/*
check your work for the rateCalc table => this query is not used but i needed it to check my work

SELECT rc.reservationID, rt.roomTypeID, r.dateCheckIn, r.dateCheckOut, rc.rateID, rs.rateMultiplier, h.hotelName, rm.roomNumber
FROM RateCalc rc
JOIN Rates rs on rc.rateID = rs.rateID
JOIN Reservation r ON rc.reservationID = r.reservationID
JOIN Room rm ON r.roomNumber = rm.roomNumber AND r.hotelID = rm.hotelID
JOIN Hotel h ON rm.hotelID = h.hotelID
JOIN RoomType rt ON rc.roomTypeID = rt.roomTypeID;
*/

/*
this query inserts all the matching RateID dates into the rateCalc table => can use this for creating new rateCalc addition

INSERT INTO RateCalc (reservationID, roomTypeID, rateID)
SELECT r.reservationID, rt.roomTypeID, ra.rateID
FROM Reservation r
JOIN Room rm ON r.roomNumber = rm.roomNumber AND r.hotelID = rm.hotelID
JOIN RoomType rt ON rm.roomTypeID = rt.roomTypeID
JOIN Rates ra ON (r.dateCheckIn BETWEEN ra.dateRateStart AND ra.dateRateEnd)
OR (r.dateCheckOut BETWEEN ra.dateRateStart AND ra.dateRateEnd);

this query inserts all the nonmatching RateID dates into the rateCalc table speifically as the 'Normal' rateID

INSERT INTO RateCalc (reservationID, roomTypeID, rateID)
SELECT r.reservationID, rt.roomTypeID, 'Normal'
FROM Reservation r
JOIN Room rm ON r.roomNumber = rm.roomNumber AND r.hotelID = rm.hotelID
JOIN RoomType rt ON rm.roomTypeID = rt.roomTypeID
WHERE NOT EXISTS (
  SELECT 1
  FROM Rates ra
  WHERE (r.dateCheckIn BETWEEN ra.dateRateStart AND ra.dateRateEnd)
  OR (r.dateCheckOut BETWEEN ra.dateRateStart AND ra.dateRateEnd)
);
*/

/*
this query is needed for constant change because every day the Rooms have people occupying them in and out ADD THIS TO HOTEL MAIN FOR INTERFACE 
not needed as all statusOCcupation are initally 0 => change statusOccupation to 0 if the current timestamp falls outside of the dateCheckIn and dateCheckOut
query shown below => change statusOccupation to 1 if the current timestamp falls between the dateCheckIn and dateCheckOut
ON SECOND THOUGHT: DO NOT ADD THIS TO THE CODE AS A REFRESH QUERY TO USE AT ALL TIMES, we'll need to manually check in customers

UPDATE Room
SET statusOccupation = 1, statusCleaning = 0
WHERE (hotelID, roomNumber) IN (
SELECT hotelID, roomNumber
FROM Reservation
WHERE SYSDATE BETWEEN dateCheckIn AND dateCheckOut
);

*/

/*
my original insert data from Mockaroo did not include the Receipt tables populated with the right amount of money paid or points paid so I inserted a random 0 or 1
and based on that I populated with the corresponding amount of money paid or points paid. will use in jdbc code to update the receipt once a user makes his reservation.

UPDATE Receipt rec
SET rec.dollarsPaid = (
  SELECT SUM(rts.rateMultiplier * rt.dollarDaily * 
             (rs.dateCheckOut - rs.dateCheckIn)) AS total_rate
  FROM Reservation rs
  JOIN RateCalc rc ON rs.reservationID = rc.reservationID
  JOIN RoomType rt ON rt.roomTypeID = rc.roomTypeID
  JOIN Rates rts ON rts.rateID = rc.rateID
  WHERE rec.reservationID = rs.reservationID
)
WHERE rec.dollarsPaid = 1;

UPDATE Receipt rec
SET rec.pointsPaid = (
  SELECT SUM(rts.rateMultiplier * rt.pointDaily * 
             (rs.dateCheckOut - rs.dateCheckIn)) AS total_rate
  FROM Reservation rs
  JOIN RateCalc rc ON rs.reservationID = rc.reservationID
  JOIN RoomType rt ON rt.roomTypeID = rc.roomTypeID
  JOIN Rates rts ON rts.rateID = rc.rateID
  WHERE rec.reservationID = rs.reservationID
)
WHERE rec.pointsPaid = 1;
*/

