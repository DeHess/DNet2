----------- Vorbereitung der �bung -------------------------------------------------------------------------------
-- Setze isolation mode auf read committed (ohne Snapshot) 
USE master
ALTER DATABASE FlughafenDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE 
ALTER DATABASE FlughafenDB SET READ_COMMITTED_SNAPSHOT ON
ALTER DATABASE FlughafenDB SET MULTI_USER
SELECT CASE is_read_committed_snapshot_on WHEN 1 THEN 'Snapshot ON' ELSE 'Snapshot OFF' END
   FROM sys.databases WHERE name= 'FlughafenDB'
USE FlughafenDB


/*
Parallele Ausf�hrung simulieren:

1. Alle Statements in Concurrent2.sql ausf�hren, beachten Sie den Wert in Kapazit�t
2. Statement #1 ausf�hren in Concurrent1.sql
3. Alle Statements in Concurrent2.sql ausf�hren, beachten Sie den Wert in Kapazit�t
4. Statement #2 ausf�hren in Concurrent1.sql
5. Alle Statements in Concurrent2.sql ausf�hren, beachten Sie den Wert in Kapazit�t
6. Statement #3 ausf�hren in Concurrent1.sql (R�cksetzen der �nderungen

*/

-- Statement #1
BEGIN TRANSACTION
UPDATE Flugzeug SET Kapazitaet = 160 WHERE Flugzeug_ID = 1

-- Statement #2
COMMIT TRANSACTION


-- Statement #3 - undo changes
BEGIN TRANSACTION
UPDATE Flugzeug SET Kapazitaet = 150 WHERE Flugzeug_ID = 1
COMMIT TRANSACTION