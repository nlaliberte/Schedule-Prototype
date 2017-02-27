CREATE PROCEDURE [dbo].[deploy_seed_league]
AS
BEGIN	
	TRUNCATE TABLE dbo.league
	INSERT INTO dbo.league
	SELECT 
		1
		,'Yawkey Baseball League'
		,13
		,32
		,0
		,0
		,22
		,12 
		,'YBL2017'
END