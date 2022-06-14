CREATE TABLE Province ( 
provinceName		VARCHAR(50)	NOT NULL, 
provinceCode		CHAR(2)		NOT NULL, 
PRIMARY KEY (provinceCode), 
UNIQUE (provinceName)
); 

CREATE TABLE CasesByProvince ( 
provinceCode			CHAR(2)	    NOT NULL, 
reportedDate			DATE		NOT NULL, 
confirmedPositive	    INT			CHECK (confirmedPositive >= 0), 
resolved	    		INT			CHECK (resolved >= 0), 
deaths			    	INT			CHECK (deaths >= 0), 
totalCases			    INT			CHECK (totalCases >=0), 
hospitalizedPatients	INT			CHECK (hospitalizedPatients >= 0), 
icuPatients			    INT			CHECK (icuPatients>= 0), 
icuPatientsPositive 	INT			CHECK (icuPatientsPositive>= 0), 
icuPatientsNegative		INT			CHECK (icuPatientsNegative>= 0), 
icuOnVentilator		    INT			CHECK (icuOnVentilator>= 0), 
PRIMARY KEY (provinceCode, reportedDate), 
FOREIGN KEY (provinceCode) REFERENCES Province(provinceCode) 
); 

CREATE TABLE IcuByHealthRegion ( 
provinceCode		CHAR(2) 	NOT NULL, 
regionName			VARCHAR(20)	NOT NULL, 
reportedDate		DATE		NOT NULL, 
icuCurrent			INT			CHECK (icuCurrent >= 0), 
icuCurrentVented	INT			CHECK (icuCurrentVented >= 0), 
hospitalizations	INT			CHECK (hospitalizations >= 0), 
PRIMARY KEY (provinceCode, regionName, reportedDate),
FOREIGN KEY (provinceCode) REFERENCES Province(provinceCode)
); 

CREATE TABLE IDHealthUnitByRegion (
unitID          INT             NOT NULL,
provinceCode    CHAR(2)         NOT NULL,
unitName        VARCHAR(50)     NOT NULL,
regionName      VARCHAR(10)     NOT NULL,
PRIMARY KEY (unitID),
FOREIGN KEY (provinceCode) REFERENCES Province(provinceCode)
);

CREATE TABLE VaccinationByUnitAndAge (  
unitID  			INT     	NOT NULL, 
reportedDate        DATE        NOT NULL,
ageGroup			VARCHAR(10)	NOT NULL, 
firstDose			INT			CHECK (firstDose >= 0), 
secondDose			INT			CHECK (secondDose >= 0), 
thirdDose			INT			CHECK (thirdDose >= 0), 
PRIMARY KEY (unitID, reportedDate, ageGroup), 
FOREIGN KEY (unitID) REFERENCES IDHealthUnitByRegion (unitID) 
); 

CREATE TABLE CasesByAge ( 
provinceCode        CHAR(2)     NOT NULL,
reportedDate		DATE		NOT NULL,  
ageGroup			VARCHAR(20)	NOT NULL, 
percentPositive		DECIMAL(5, 4), 
PRIMARY KEY (provinceCode, reportedDate, ageGroup),
FOREIGN KEY (provinceCode) REFERENCES Province(provinceCode)
); 

