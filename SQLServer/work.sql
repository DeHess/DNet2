USE FlughafenDB
GO

--Testen Sie, ob tatsächlich alle Buchungen in der Tabelle eingefügt wurden (36'604'040).
SELECT COUNT(*) AS TotalEntries FROM dbo.Buchung;

--Wie lange braucht der SQL-Server um einen Join über eine Million Datensätze durchzuführen und diese
--anzuzeigen? 8 Sekunden
SELECT TOP 1000000 * FROM Buchung JOIN Flug ON Buchung.Flug_ID = Flug.Flug_ID

--Wie lange braucht der SQL-Server um alle Buchungen für den Sitzplatz 18C zu suchen (es sind insgesamt
--36’604’040 Buchungen), wie viele Buchungen findet er, haben Sie eine Idee wie er das macht (siehe auch
--Bild des Ausführungsplans, dieser kann je nach Ressourcen verschieden aussehen)? 7 Sekunden
SELECT * FROM Buchung WHERE Sitzplatz = '18C' 