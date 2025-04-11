USE FlughafenDB;
GO

ALTER DATABASE [FlughafenDB] SET RECOVERY SIMPLE;
GO

BULK INSERT dbo.Flughafen_Geo 
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\flughafen_geo.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Flughafen_Geo'

BULK INSERT dbo.Flug
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\flug.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Flug'

BULK INSERT dbo.Flughafen 
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\flughafen.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Flughafen'

BULK INSERT dbo.Fluglinie
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\fluglinie.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Fluglinie'

BULK INSERT dbo.Flugplan 
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\flugplan.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Flugplan'

BULK INSERT dbo.Flugzeug 
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\flugzeug.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Flugzeug'

BULK INSERT dbo.Flugzeug_Typ
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\flugzeug_typ.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Flugzeug_Typ'

BULK INSERT dbo.Mitarbeiter 
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\mitarbeiter.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Flughafen_Mitarbeiter'

BULK INSERT dbo.Passagier
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\passagier.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Passagier'

BULK INSERT dbo.Passagierdetails
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\passagierdetails.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Passagierdetails'

BULK INSERT dbo.Wetterdaten
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\wetterdaten.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Wetterdaten'

BULK INSERT dbo.Buchung
    FROM 'C:\Users\nathh\Documents\GitHub\DNet2\SQLServer\Dat\buchung.dat' 
   WITH (DATAFILETYPE='widenative', TABLOCK); 
GO
PRINT 'Imported Buchung'

ALTER DATABASE [FlughafenDB] SET RECOVERY FULL;
GO