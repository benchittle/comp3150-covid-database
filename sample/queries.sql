SET echo OFF
SET verify OFF
SET linesize 200
SET pagesize 15

PROMPT (Press enter to continue) Insert January 2022 data into the database:
ACCEPT cont;
SET echo ON
--------------------------------------------------------------------------------
-- NEW INSERTIONS: Data added to CasesByProvince Table for January 2022
INSERT INTO CasesByProvince VALUES ('ON', '01-Jan-2022', 112486, 652114, 10206, 774806, 1314, 214, 200, 14, 112);
INSERT INTO CasesByProvince VALUES ('ON', '02-Jan-2022', 123282, 658015, 10223, 791520, 1117, 224, 212, 12, 114);
INSERT INTO CasesByProvince VALUES ('ON', '03-Jan-2022', 130307, 664562, 10229, 805098, 1232, 248, 235, 13, 125);
INSERT INTO CasesByProvince VALUES ('ON', '04-Jan-2022', 134130, 672081, 10239, 816450, 1290, 266, 254, 12, 128);
INSERT INTO CasesByProvince VALUES ('ON', '05-Jan-2022', 134030, 683750, 10252, 828032, 2081, 288, 276, 12, 138);
INSERT INTO CasesByProvince VALUES ('ON', '06-Jan-2022', 135313, 695786, 10272, 841371, 2279, 319, 307, 12, 164);
INSERT INTO CasesByProvince VALUES ('ON', '07-Jan-2022', 135223, 707732, 10315, 853270, 2472, 338, 324, 14, 177);
INSERT INTO CasesByProvince VALUES ('ON', '08-Jan-2022', 136548, 719739, 10345, 866632, 2594, 385, 372, 13, 219);
INSERT INTO CasesByProvince VALUES ('ON', '09-Jan-2022', 137822, 730403, 10366, 878591, 2419, 412, 397, 15, 226);
INSERT INTO CasesByProvince VALUES ('ON', '10-Jan-2022', 140523, 737396, 10378, 888297, 2467, 438, 423, 15, 234);
INSERT INTO CasesByProvince VALUES ('ON', '11-Jan-2022', 138560, 747289, 10399, 896248, 3220, 477, 459, 18, 250);
INSERT INTO CasesByProvince VALUES ('ON', '12-Jan-2022', 132188, 763398, 10445, 906031, 3448, 505, 486, 19, 265);
INSERT INTO CasesByProvince VALUES ('ON', '13-Jan-2022', 122246, 783214, 10480, 915940, 3630, 500, 481, 19, 275);
INSERT INTO CasesByProvince VALUES ('ON', '14-Jan-2022', 111496, 804886, 10522, 926904, 3814, 527, 511, 16, 288);
INSERT INTO CasesByProvince VALUES ('ON', '15-Jan-2022', 99315, 827756, 10565, 937636, 3957, 558, 544, 14, 319);
INSERT INTO CasesByProvince VALUES ('ON', '16-Jan-2022', 94408, 843073, 10605, 948086, 3595, 579, 563, 16, 340);
INSERT INTO CasesByProvince VALUES ('ON', '17-Jan-2022', 94614, 851365, 10628, 956607, 3887, 578, 565, 13, 343);
INSERT INTO CasesByProvince VALUES ('ON', '18-Jan-2022', 91473, 861554, 10666, 963693, 4183, 580, 568, 12, 337);
INSERT INTO CasesByProvince VALUES ('ON', '19-Jan-2022', 84266, 874445, 10726, 969437, 4132, 589, 577, 12, 341);
INSERT INTO CasesByProvince VALUES ('ON', '20-Jan-2022', 79370, 887023, 10801, 977194, 4061, 594, 577, 17, 347);
INSERT INTO CasesByProvince VALUES ('ON', '21-Jan-2022', 74905, 898589, 10865, 984359, 4114, 590, 573, 17, 366);
INSERT INTO CasesByProvince VALUES ('ON', '22-Jan-2022', 71387, 908533, 10912, 990832, 4026, 600, 576, 24, 378);
INSERT INTO CasesByProvince VALUES ('ON', '23-Jan-2022', 67674, 918023, 10968, 996665, 3797, 604, 579, 25, 375);
INSERT INTO CasesByProvince VALUES ('ON', '24-Jan-2022', 65504, 924947, 11004, 1001455, 3861, 615, 586, 29, 372);
INSERT INTO CasesByProvince VALUES ('ON', '25-Jan-2022', 61566, 932245, 11068, 1004879, 4008, 626, 594, 32, 380);
INSERT INTO CasesByProvince VALUES ('ON', '26-Jan-2022', 56929, 942158, 11160, 1010247, 4016, 608, 577, 31, 367);
INSERT INTO CasesByProvince VALUES ('ON', '27-Jan-2022', 54074, 950795, 11230, 1016099, 3645, 599, 566, 33, 366);
INSERT INTO CasesByProvince VALUES ('ON', '28-Jan-2022', 51437, 958701, 11298, 1021436, 3535, 607, 577, 30, 387);
INSERT INTO CasesByProvince VALUES ('ON', '29-Jan-2022', 49551, 965386, 11354, 1026291, 3439, 597, 563, 34, 386);
INSERT INTO CasesByProvince VALUES ('ON', '30-Jan-2022', 46950, 971889, 11412, 1030251, 3019, 587, 555, 32, 358);
INSERT INTO CasesByProvince VALUES ('ON', '31-Jan-2022', 44863, 976987, 11444, 1033294, 2983, 583, 555, 28, 347);


SET echo OFF
PROMPT Press enter to continue to QUERY 1...
ACCEPT cont;
SET echo ON
--------------------------------------------------------------------------------
-- QUERY 1: Get the average number of hospitalizations in each province for each
-- month and order the results by province and date.
SELECT P.provinceName, 
       EXTRACT(YEAR FROM C.reportedDate) AS "year", 
       EXTRACT(MONTH FROM C.reportedDate) AS "month", 
       ROUND(AVG(C.hospitalizedPatients), 0) AS "avgHospitalized"
FROM CasesByProvince C 
JOIN Province P ON P.provinceCode = C.ProvinceCode 
GROUP BY P.provinceName, 
         EXTRACT(YEAR FROM C.reportedDate), 
         EXTRACT(MONTH FROM C.reportedDate)
ORDER BY P.provinceName, 
         EXTRACT(YEAR FROM C.reportedDate), 
         EXTRACT(MONTH FROM C.reportedDate);


SET echo OFF
PROMPT Press enter to continue to QUERY 2...
ACCEPT cont;
SET echo ON
--------------------------------------------------------------------------------
-- QUERY 2: Get the average ratio of ICU ventilators in use to total 
-- hospitalizations for each month in each health region. Order the results by 
-- province, date, and health region.
SELECT P.provinceName, 
       EXTRACT(YEAR FROM H.reportedDate) AS "year", 
       EXTRACT(MONTH FROM H.reportedDate) AS "month", 
       H.regionName,
       ROUND(AVG(H.icuCurrentVented), 0) AS "vented", 
       ROUND(AVG(H.hospitalizations), 0) AS "hospitalizations",
       ROUND(AVG(H.icuCurrentVented) / AVG(H.hospitalizations) * 100, 2) AS "ratio (%)"
FROM IcuByHealthRegion H
JOIN Province P ON P.provinceCode = H.ProvinceCode 
GROUP BY P.provinceName, 
         EXTRACT(YEAR FROM H.reportedDate), 
         EXTRACT(MONTH FROM H.reportedDate), 
         H.regionName
ORDER BY P.provinceName, 
         EXTRACT(YEAR FROM H.reportedDate), 
         EXTRACT(MONTH FROM H.reportedDate), 
         H.regionName;


SET echo OFF
PROMPT Press enter to continue to QUERY 3...
ACCEPT cont;
SET echo ON
--------------------------------------------------------------------------------
-- QUERY 3: Prompt the user to enter an age group. Then, display the total 
-- number of people in that age group who have received their first and second
-- dose of the vaccine, grouped and sorted by region and date.
SET echo OFF
PROMPT Enter one of the following age groups to display vaccination data for: 18-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80
ACCEPT ageGroup PROMPT "ageGroup: "
SET echo ON
SELECT I.regionName, 
       EXTRACT(YEAR FROM V.reportedDate) AS "year",
       EXTRACT(MONTH FROM V.reportedDate) AS "month", 
       SUM(V.firstDose) AS "total first doses (age=&ageGroup)",
       SUM(V.secondDose) AS "total second doses (age=&ageGroup)" 
FROM VaccinationByUnitAndAge V 
JOIN IdHealthUnitByRegion I 
ON V.unitId = I.unitId 
WHERE V.ageGroup = '&ageGroup'  
GROUP BY EXTRACT(YEAR FROM V.reportedDate), 
         EXTRACT(MONTH FROM V.reportedDate), 
         I.regionName 
ORDER BY EXTRACT(YEAR FROM V.reportedDate), 
         EXTRACT(MONTH FROM V.reportedDate),
         I.regionName;


SET echo OFF
PROMPT Press enter to continue to QUERY 4...
ACCEPT cont;
SET echo ON
--------------------------------------------------------------------------------
-- QUERY 4: Assume a COVID outbreak occurred due to holiday gatherings. Find how 
-- many ICU cases each provincial region saw during the last 2 weeks of December 
-- of 2021 (December 18 – December 31). Order them from most cases to least 
-- cases. 
SELECT regionName,  
SUM(icuCurrent) 
FROM IcuByHealthRegion 
WHERE reportedDate BETWEEN '18-Dec-2021' AND '31-Dec-2021' 
GROUP BY regionName
ORDER BY SUM(icuCurrent) DESC;


SET echo OFF
PROMPT Press enter to continue to QUERY 5...
ACCEPT cont;
SET echo ON
--------------------------------------------------------------------------------
-- QUERY 5: The Omicron COVID variant was first reported in Canada November 28, 
-- 2021. This query finds the percent increase of Ontario COVID cases between 
-- each month. Use this to observe the drastic change between November and
--  December.
SELECT 
    P.provinceName,
    EXTRACT(YEAR FROM C.reportedDate) AS "year",
    EXTRACT(MONTH FROM C.reportedDate) AS "month", 
    SUM(C.confirmedPositive) AS "total positive cases",
    LAG(SUM(C.confirmedPositive), 1, NULL) OVER (ORDER BY EXTRACT(YEAR FROM C.reportedDate), EXTRACT(MONTH FROM C.reportedDate)) AS "last month total",
    (SUM(C.confirmedPositive) - LAG(SUM(C.confirmedPositive), 1, NULL) OVER (ORDER BY EXTRACT(YEAR FROM C.reportedDate), EXTRACT(MONTH FROM C.reportedDate))) AS "difference",
    (SUM(C.confirmedPositive) - LAG(SUM(C.confirmedPositive), 1, NULL) OVER (ORDER BY EXTRACT(YEAR FROM C.reportedDate), EXTRACT(MONTH FROM C.reportedDate))) / LAG(SUM(C.confirmedPositive), 1, NULL) OVER (ORDER BY EXTRACT(YEAR FROM C.reportedDate), EXTRACT(MONTH FROM C.reportedDate)) * 100 AS "% increase"
FROM CasesByProvince C
JOIN Province P
ON C.provinceCode = P.provinceCode
GROUP BY provinceName, EXTRACT(YEAR FROM C.reportedDate), EXTRACT(MONTH FROM C.reportedDate)
ORDER BY provinceName, EXTRACT(YEAR FROM C.reportedDate), EXTRACT(MONTH FROM C.reportedDate);


SET echo OFF
PROMPT Press enter to continue to QUERY 6...
ACCEPT cont;
SET echo ON
--------------------------------------------------------------------------------
-- QUERY 6: Prompt the user to enter an age group. Get the percentage of people 
-- who took the first dose and did not take the second dose for each month from 
-- specified age-group.
SET echo OFF
PROMPT Enter one of the following age groups to display vaccination data for: 18-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80 
ACCEPT ageGroup PROMPT "ageGroup: " 
SET echo ON
SELECT  
    I.regionName AS "regionName", 
    EXTRACT(YEAR FROM V.reportedDate) AS "year",
    EXTRACT(MONTH FROM V.reportedDate) AS "month", 
    ROUND((SUM(V.firstDose) - SUM(V. secondDose)) /SUM(V.firstDose) * 100, 2) AS "percentage (&ageGroup)"  
FROM VaccinationByUnitAndAge V 
JOIN IdHealthUnitByRegion I  
ON V.unitId = I.unitId  
WHERE V.ageGroup = '&ageGroup'   
GROUP BY 
    EXTRACT(YEAR FROM V.reportedDate),
    EXTRACT(MONTH FROM V.reportedDate), 
    V.ageGroup, 
    I.regionName 
ORDER BY 
    EXTRACT(YEAR FROM V.reportedDate),
    EXTRACT(MONTH FROM V.reportedDate), 
    I.regionName; 

SET echo OFF
PROMPT (Press enter to continue) Updating the database:
ACCEPT cont;
SET echo ON
--------------------------------------------------------------------------------
-- Change the name of the "reportedDate" column in each table to "dataDate". 
-- Display the first 10 rows of the table to prove it works.
ALTER TABLE CasesByProvince RENAME COLUMN reportedDate TO dataDate;
ALTER TABLE IcuByHealthRegion RENAME COLUMN reportedDate TO dataDate;
ALTER TABLE CasesByAge RENAME COLUMN reportedDate TO dataDate;
SELECT DataDate FROM CasesByProvince WHERE rownum < 10;

-- Reduce VARCHAR size for "provinceName" column of "Province" table to tighten
-- upper size bound. Display the table after to prove it works.
ALTER TABLE Province MODIFY provinceName VARCHAR(45);
SELECT * FROM Province;

-- Drop "thirdDose" column of "VaccinationByUnitAndAge" since the third dose was
-- not available in 2021. Display the first 10 rows of the table after to prove 
-- it works.
ALTER TABLE VaccinationByUnitAndAge DROP COLUMN thirdDose;
SELECT * FROM VaccinationByUnitAndAge WHERE rownum < 10

-- Rename table "IdHealthUnitByRegion" to "HealthUnitIdByRegion" (and then 
-- revert the change). Display the first 10 rows of the table after each name 
-- change to prove it works.
ALTER TABLE IdHealthUnitByRegion RENAME TO HealthUnitIdByRegion;
SELECT * FROM HealthUnitIdByRegion WHERE rownum < 10;
ALTER TABLE HealthUnitIdByRegion RENAME TO IdHealthUnitByRegion;
SELECT * FROM IdHealthUnitByRegion WHERE rownum < 10;




SET verify ON