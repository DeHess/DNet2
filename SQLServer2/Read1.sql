----------- Vorbereitung der �bung -------------------------------------------------------------------------------
-- Setze isolation mode auf read committed (snapshot) da andernfalls
-- die Abfrage B in der zweiten Session h�ngen bleiben w�rde. Wieso?
USE master
ALTER DATABASE FlughafenDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE 
ALTER DATABASE FlughafenDB SET READ_COMMITTED_SNAPSHOT ON
ALTER DATABASE FlughafenDB SET MULTI_USER
SELECT CASE is_read_committed_snapshot_on WHEN 1 THEN 'Snapshot ON' ELSE 'Snapshot OFF' END
   FROM sys.databases WHERE name= 'FlughafenDB'
USE FlughafenDB
-- allf�llige Daten in Tabelle test aus verherigem "Lauf" l�schen
DELETE FROM dbo.Test
INSERT INTO test (Flugzeug_ID, Kapazitaet, Typ_ID, Fluglinie_ID )
   SELECT TOP 500 * FROM Flugzeug


/*
Parallele Ausf�hrung simulieren:

1. Statement #1 ausf�hren in Read1.sql
2. Statement #2 ausf�hren in Read2.sql
3. Statement #3 ausf�hren in Read1.sql
4. Statement #4 ausf�hren in Read2.sql
5. Statement #5 ausf�hren in Read1.sql
6. Statement #6 ausf�hren in Read2.sql

*/


-- Statement #1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
INSERT INTO test (Flugzeug_ID, Kapazitaet, Typ_ID, Fluglinie_ID )
   SELECT TOP 500 * FROM Flugzeug WHERE flugzeug_id NOT IN  (SELECT flugzeug_id FROM Test)
SELECT count(*) FROM test;    

-- Statement #3
INSERT INTO test (Flugzeug_ID, Kapazitaet, Typ_ID, Fluglinie_ID )
   SELECT TOP 500 * FROM Flugzeug WHERE flugzeug_id NOT IN  (SELECT flugzeug_id FROM Test)
SELECT count(*) FROM test;

-- Statement #5
COMMIT TRANSACTION;
SELECT count(*) FROM test; 