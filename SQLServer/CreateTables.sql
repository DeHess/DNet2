USE [FlughafenDB]
GO

-------------------------------------------------------------------------------
-- Flughafen
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Flughafen](
	[Flughafen_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[IATA] [varchar]  (3)      NULL,
	[ICAO] [varchar]  (4)  NOT NULL,
	[Name] [varchar] (50)  NOT NULL,
 CONSTRAINT [PK_Flughafen_Flughafen_ID] PRIMARY KEY CLUSTERED 
(
	[Flughafen_ID] ASC
) ON [PRIMARY],
 CONSTRAINT [Flughafen_ICAO_UNQ] UNIQUE NONCLUSTERED 
(
	[ICAO] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IATA_IDx] ON [dbo].[Flughafen]
(
	[IATA] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Name_IDx] ON [dbo].[Flughafen]
(
	[Name] ASC
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Passagier
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Passagier](
	[Passagier_ID] [int] IDENTITY(1,1) NOT NULL,
	[Passnummer] [varchar](9)  NOT NULL,
	[Vorname] [varchar](100)  NOT NULL,
	[Nachname] [varchar](100)  NOT NULL,
 CONSTRAINT [PK_Passagier_Passagier_ID] PRIMARY KEY CLUSTERED 
(
	[Passagier_ID] ASC
) ON [PRIMARY],
 CONSTRAINT [Passagier_Passnummer_UNQ] UNIQUE NONCLUSTERED 
(
	[Passnummer] ASC
) ON [PRIMARY]
) ON [PRIMARY]

-------------------------------------------------------------------------------
-- Passagierdetails
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Passagierdetails](
	[Passagier_ID] [int] NOT NULL,
	[Geburtsdatum] [date] NOT NULL,
	[Geschlecht] [char](1)  NULL,
	[Strasse] [varchar](100)  NOT NULL,
	[Ort] [varchar](100)  NOT NULL,
	[PLZ] [smallint] NOT NULL,
	[Land] [varchar](100)  NOT NULL,
	[Emailadresse] [varchar](120)  NULL,
	[Telefonnummer] [varchar](30)  NULL,
 CONSTRAINT [PK_Passagierdetails_Passagier_ID] PRIMARY KEY CLUSTERED 
(
	[Passagier_ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Buchung
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Buchung](
	[Buchung_ID] [int] IDENTITY(1,1) NOT NULL,
	[Flug_ID] [int] NOT NULL,
	[Sitzplatz] [varchar](4)  NULL,
	[Passagier_ID] [int] NOT NULL,
	[Preis] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Buchung_Buchung_ID] PRIMARY KEY CLUSTERED 
(
	[Buchung_ID] ASC
) ON [PRIMARY],
 CONSTRAINT [Buchung_Sitzplan_UNQ] UNIQUE NONCLUSTERED 
(
	[Flug_ID] ASC,
	[Sitzplatz] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Flug_IDx] ON [dbo].[Buchung]
(
	[Flug_ID] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Passagier_IDx] ON [dbo].[Buchung]
(
	[Passagier_ID] ASC
) ON [PRIMARY]
GO

/*

ALTER TABLE [dbo].[Buchung] REBUILD PARTITION = ALL
WITH 
(DATA_COMPRESSION = PAGE
)

*/
-------------------------------------------------------------------------------
-- Flugplan
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Flugplan](
	[Flugnr] [varchar](8)  NOT NULL,
	[Von] [smallint] NOT NULL,
	[Nach] [smallint] NOT NULL,
	[Abflug] [char](8) NOT NULL,
	[Ankunft] [char](8) NOT NULL,
	[Fluglinie_ID] [int] NOT NULL,
	[Montag] [smallint] NULL,
	[Dienstag] [smallint] NULL,
	[Mittwoch] [smallint] NULL,
	[Donnerstag] [smallint] NULL,
	[Freitag] [smallint] NULL,
	[Samstag] [smallint] NULL,
	[Sonntag] [smallint] NULL,
 CONSTRAINT [PK_Flugplan_Flugnr] PRIMARY KEY CLUSTERED 
(
	[Flugnr] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Fluglinie_IDx] ON [dbo].[Flugplan]
(
	[Fluglinie_ID] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Nach_IDx] ON [dbo].[Flugplan]
(
	[Nach] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Von_IDx] ON [dbo].[Flugplan]
(
	[Von] ASC
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Flug
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Flug](
	[Flug_ID] [int] IDENTITY(1,1) NOT NULL,
	[Flugnr] [varchar](8)  NOT NULL,
	[Von] [smallint] NOT NULL,
	[Nach] [smallint] NOT NULL,
	[Abflug] [datetime] NOT NULL,
	[Ankunft] [datetime] NOT NULL,
	[Fluglinie_ID] [int] NOT NULL,
	[Flugzeug_ID] [int] NOT NULL,
 CONSTRAINT [PK_Flug_Flug_ID] PRIMARY KEY CLUSTERED 
(
	[Flug_ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Abflug_IDx] ON [dbo].[Flug]
(
	[Abflug] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Ankunft_IDx] ON [dbo].[Flug]
(
	[Ankunft] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Fluglinie_IDx] ON [dbo].[Flug]
(
	[Fluglinie_ID] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Flugzeug_IDx] ON [dbo].[Flug]
(
	[Flugzeug_ID] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Nach_IDx] ON [dbo].[Flug]
(
	[Nach] ASC
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Von_IDx] ON [dbo].[Flug]
(
	[Von] ASC
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Fluglinie
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Fluglinie](
	[Fluglinie_ID] [int] IDENTITY(1,1) NOT NULL,
	[IATA] [varchar](2)  NOT NULL,
	[Firmenname] [varchar](30)  NULL,
	[Heimat_Flughafen] [smallint] NOT NULL,
 CONSTRAINT [PK_Fluglinie_Fluglinie_ID] PRIMARY KEY CLUSTERED 
(
	[Fluglinie_ID] ASC
) ON [PRIMARY],
 CONSTRAINT [Fluglinie_IATA_UNQ] UNIQUE NONCLUSTERED 
(
	[IATA] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [Heimat_IDx] ON [dbo].[Fluglinie]
(
	[Heimat_Flughafen] ASC
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Flugzeug
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Flugzeug](
	[Flugzeug_ID] [int] IDENTITY(1,1) NOT NULL,
	[Kapazitaet] [int] NOT NULL,
	[Typ_ID] [int] NOT NULL,
	[Fluglinie_ID] [int] NOT NULL,
 CONSTRAINT [PK_Flugzeug_Flugzeug_ID] PRIMARY KEY CLUSTERED 
(
	[Flugzeug_ID] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Flugzeug_Typ
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Flugzeug_Typ](
	[Typ_ID] [int] IDENTITY(1,1) NOT NULL,
	[Bezeichnung] [varchar](50)  NULL,
	[Beschreibung] [varchar](max)  NULL,
 CONSTRAINT [PK_Flugzeug_typ_Typ_ID] PRIMARY KEY CLUSTERED 
(
	[Typ_ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] 
GO

-------------------------------------------------------------------------------
-- Flughafen_Geo
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Flughafen_Geo](
	[Flughafen_ID] [int] NOT NULL,
	[Name] [varchar](50)  NOT NULL,
	[Stadt] [varchar](50)  NULL,
	[Land] [varchar](50)  NULL,
	[Breite] [decimal](11, 8) NOT NULL,
	[Laenge] [decimal](11, 8) NOT NULL
) ON [PRIMARY] 
GO

CREATE NONCLUSTERED INDEX [Flughafen_IDx] ON [dbo].[Flughafen_Geo]
(
	[Flughafen_ID] ASC
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Wetterdaten
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Wetterdaten](
	[DatumZeit] [datetime] NOT NULL,
	[Station] [int] NOT NULL,
	[Temp] [decimal](3, 1) NOT NULL,
	[Feuchtigkeit] [decimal](4, 1) NOT NULL,
	[Luftdruck] [decimal](10, 2) NOT NULL,
	[Wind] [decimal](5, 2) NOT NULL,
	[Wetter] [varchar](16)  NULL,
	[Windrichtung] [smallint] NOT NULL,
 CONSTRAINT [PK_Wetterdaten_Datum] PRIMARY KEY CLUSTERED 
(
	[DatumZeit] ASC,
	[Station] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Flug_Log
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Flug_Log](
	[Datum] [datetime] NOT NULL,
	[Benutzer] [varchar](100)  NOT NULL,
	[Flug_ID] [int] NOT NULL,
	[Flugnr_Alt] [char](8)  NOT NULL,
	[Flugnr_Neu] [char](8)  NOT NULL,
	[Von_Alt] [smallint] NOT NULL,
	[Nach_Alt] [smallint] NOT NULL,
	[Von_Neu] [smallint] NOT NULL,
	[Nach_Neu] [smallint] NOT NULL,
	[Abflug_Alt] [datetime2](0) NOT NULL,
	[Ankunft_Alt] [datetime2](0) NOT NULL,
	[Abflug_Neu] [datetime2](0) NOT NULL,
	[Ankunft_Neu] [datetime2](0) NOT NULL,
	[Flugzeug_ID_Alt] [int] NOT NULL,
	[Flugzeug_ID_Neu] [int] NOT NULL,
	[Fluglinie_ID_Alt] [smallint] NOT NULL,
	[Fluglinie_ID_Neu] [smallint] NOT NULL,
	[Kommentar] [varchar](200)  NULL
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Mitarbeiter
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Mitarbeiter](
	[Mitarbeiter_ID] [int] IDENTITY(1,1) NOT NULL,
	[Vorname] [varchar](100)  NOT NULL,
	[Nachname] [varchar](100)  NOT NULL,
	[Geburtsdatum] [date] NOT NULL,
	[Geschlecht] [char](1)  NULL,
	[Strasse] [varchar](100)  NOT NULL,
	[Ort] [varchar](100)  NOT NULL,
	[PLZ] [smallint] NOT NULL,
	[Land] [varchar](100)  NOT NULL,
	[Emailadresse] [varchar](120)  NULL,
	[Telefonnummer] [varchar](30)  NULL,
	[Gehalt] [decimal](8, 2) NULL,
	[Abteilung] [varchar](11)  NULL,
	[Benutzername] [varchar](20)  NULL,
	[Passwort] [char](32)  NULL,
 CONSTRAINT [PK_Mitarbeiter_Mitarbeiter_ID] PRIMARY KEY CLUSTERED 
(
	[Mitarbeiter_ID] ASC
) ON [PRIMARY],
 CONSTRAINT [Mitarbeiter_Benutzer_UNQ] UNIQUE NONCLUSTERED 
(
	[Benutzername] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- Test
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[Test](
	[Flugzeug_ID] [int] NOT NULL,
	[Kapazitaet] [int] NOT NULL,
	[Typ_ID] [int] NOT NULL,
	[Fluglinie_ID] [int] NOT NULL,
 CONSTRAINT [TEST_PK] PRIMARY KEY CLUSTERED 
(
	[Flugzeug_ID] ASC)
) ON [PRIMARY]
GO