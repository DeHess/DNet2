USE FlughafenDB
BEGIN TRANSACTION
SELECT TOP (1) * FROM Flugzeug WHERE Flugzeug_ID = 1
COMMIT TRANSACTION