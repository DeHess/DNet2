-- Statement #2
USE FlughafenDB
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
BEGIN TRANSACTION
UPDATE Flugzeug SET Kapazitaet = 170 WHERE Flugzeug_ID = 1
SELECT TOP (1) * FROM Flugzeug WHERE Flugzeug_ID = 1

-- Statement #4
COMMIT TRANSACTION
SELECT TOP (1) * FROM Flugzeug WHERE Flugzeug_ID = 1