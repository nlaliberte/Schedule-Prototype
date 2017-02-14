CREATE PROCEDURE [dbo].[pr_team_insert] 
	(
		@team_name		VARCHAR(255)
		,@conference_id	INT = -1
		,@contact_id	INT = -1
		,@contact_id2	INT = -1
	)
AS
BEGIN

	--Derive and ID for the team
	DECLARE @team_id INT
	
	SELECT @team_id = 1 + (SELECT MAX(team_id) FROM dbo.team)
	
	
	--Insert the new contact into the table
	INSERT INTO dbo.team
	VALUES 
		(
			@team_id
			,@team_name
			,@conference_id
			,@contact_id
			,@contact_id2
		)

END