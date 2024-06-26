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
CREATE TABLE [OF].[IndicatorList]
	(
	IndicatorID int NOT NULL IDENTITY (1, 1),
	DomainID smallint NULL,
	ReferenceID nvarchar(50) NULL,
	ICBIndicatorTitle nvarchar(500) NOT NULL,
	IndicatorLabel nvarchar(500) NOT NULL,
	StatusID smallint NOT NULL
	)  ON [PRIMARY]
GO

ALTER TABLE [OF].[IndicatorList] ADD CONSTRAINT
	PK_IndicatorList_1 PRIMARY KEY CLUSTERED 
	(
	IndicatorID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE [OF].[IndicatorList] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT