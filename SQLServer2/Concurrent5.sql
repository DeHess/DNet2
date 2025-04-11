/*

Parallele Ausf�hrung simulieren:

1. Statement #1 ausf�hren in Concurrent1.sql
2. Statement #2 ausf�hren in Concurrent2.sql
3. Statement #3 ausf�hren in Concurrent1.sql
4. Statement #4 ausf�hren in Concurrent2.sql
4. Statement #5 ausf�hren in Concurrent1.sql

*/

-- Statement #1
USE FlughafenDB
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
BEGIN TRANSACTION
SELECT TOP (1) * FROM Flugzeug WHERE Flugzeug_ID = 1

-- Statement #3
COMMIT TRANSACTION

-- Statement #5 - undo changes
BEGIN TRANSACTION
UPDATE Flugzeug SET Kapazitaet = 150 WHERE Flugzeug_ID = 1
COMMIT TRANSACTION