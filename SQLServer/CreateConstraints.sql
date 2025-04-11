USE FlughafenDB
GO

-- Fluglinie

ALTER TABLE [dbo].[Fluglinie]  WITH NOCHECK ADD  CONSTRAINT [Fluglinie_Fluglinie_FK_1] FOREIGN KEY([heimat_Flughafen])
REFERENCES [dbo].[Flughafen] ([Flughafen_ID])
GO

ALTER TABLE [dbo].[Fluglinie] CHECK CONSTRAINT [Fluglinie_Fluglinie_FK_1]
GO

-- Flugplan

ALTER TABLE [dbo].[Flugplan]  WITH NOCHECK ADD  CONSTRAINT [Flugplan_Flugplan_FK_1] FOREIGN KEY([Von])
REFERENCES [dbo].[Flughafen] ([Flughafen_ID])
GO

ALTER TABLE [dbo].[Flugplan] CHECK CONSTRAINT [Flugplan_Flugplan_FK_1]
GO

ALTER TABLE [dbo].[Flugplan]  WITH NOCHECK ADD  CONSTRAINT [Flugplan_Flugplan_FK_2] FOREIGN KEY([Nach])
REFERENCES [dbo].[Flughafen] ([Flughafen_ID])
GO

ALTER TABLE [dbo].[Flugplan] CHECK CONSTRAINT [Flugplan_Flugplan_FK_2]
GO

ALTER TABLE [dbo].[Flugplan]  WITH NOCHECK ADD  CONSTRAINT [Flugplan_Flugplan_FK_3] FOREIGN KEY([Fluglinie_ID])
REFERENCES [dbo].[Fluglinie] ([Fluglinie_ID])
GO

ALTER TABLE [dbo].[Flugplan] CHECK CONSTRAINT [Flugplan_Flugplan_FK_3]
GO

-- Flug

ALTER TABLE [dbo].[Flug]  WITH NOCHECK ADD  CONSTRAINT [Flug_Flug_FK_1] FOREIGN KEY([Von])
REFERENCES [dbo].[Flughafen] ([Flughafen_ID])
GO

ALTER TABLE [dbo].[Flug] CHECK CONSTRAINT [Flug_Flug_FK_1]
GO

ALTER TABLE [dbo].[Flug]  WITH NOCHECK ADD  CONSTRAINT [Flug_Flug_FK_2] FOREIGN KEY([Nach])
REFERENCES [dbo].[Flughafen] ([Flughafen_ID])
GO

ALTER TABLE [dbo].[Flug] CHECK CONSTRAINT [Flug_Flug_FK_2]
GO

ALTER TABLE [dbo].[Flug]  WITH NOCHECK ADD  CONSTRAINT [Flug_Flug_FK_3] FOREIGN KEY([Fluglinie_ID])
REFERENCES [dbo].[Fluglinie] ([Fluglinie_ID])
GO

ALTER TABLE [dbo].[Flug] CHECK CONSTRAINT [Flug_Flug_FK_3]
GO

ALTER TABLE [dbo].[Flug]  WITH NOCHECK ADD  CONSTRAINT [Flug_Flug_FK_4] FOREIGN KEY([Flugzeug_ID])
REFERENCES [dbo].[Flugzeug] ([Flugzeug_ID])
GO

ALTER TABLE [dbo].[Flug] CHECK CONSTRAINT [Flug_Flug_FK_4]
GO

-- Passagierdetails

ALTER TABLE [dbo].[Passagierdetails]  WITH NOCHECK ADD CONSTRAINT [Passagierdetails_Passagierdetails_FK_1] FOREIGN KEY([Passagier_ID])
REFERENCES [dbo].[Passagier] ([Passagier_ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Passagierdetails] CHECK CONSTRAINT [Passagierdetails_Passagierdetails_FK_1]
GO

-- Buchung

ALTER TABLE [dbo].[Buchung]  WITH NOCHECK ADD  CONSTRAINT [Buchung_Buchung_FK_1] FOREIGN KEY([Flug_ID])
REFERENCES [dbo].[Flug] ([Flug_ID])
GO

ALTER TABLE [dbo].[Buchung] CHECK CONSTRAINT [Buchung_Buchung_FK_1]
GO

ALTER TABLE [dbo].[Buchung]  WITH NOCHECK ADD  CONSTRAINT [Buchung_Buchung_FK_2] FOREIGN KEY([Passagier_ID])
REFERENCES [dbo].[Passagier] ([Passagier_ID])
GO

ALTER TABLE [dbo].[Buchung] CHECK CONSTRAINT [Buchung_Buchung_FK_2]
GO
