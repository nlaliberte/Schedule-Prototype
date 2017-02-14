CREATE PROCEDURE [dbo].[pr_team_update] 
	(
		@team_id		INT
		,@team_name		VARCHAR(255)
		,@conference_id	INT = -1
		,@contact_id	INT = -1
		,@contact_id2	INT = -1
	)
AS
BEGIN
	
	--Insert the new contact into the table
	UPDATE dbo.team
	SET 
		team_name = @team_name
		,conference_id = @conference_id
		,contact_id = @contact_id
		,contact_id2 = @contact_id2
	WHERE
		team_id = @team_id
		
END