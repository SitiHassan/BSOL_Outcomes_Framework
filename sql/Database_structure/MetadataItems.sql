/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE [OF].[MetadataItems]
	(
	ItemID smallint NOT NULL IDENTITY (1, 1),
	ItemLabel nvarchar(500)
	)  ON [PRIMARY]
GO

ALTER TABLE [OF].[MetadataItems] ADD CONSTRAINT
	PK_MetadataItems_1 PRIMARY KEY CLUSTERED 
	(
	ItemID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE [OF].[MetadataItems] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



