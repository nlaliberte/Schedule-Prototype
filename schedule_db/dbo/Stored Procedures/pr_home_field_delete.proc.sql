CREATE PROCEDURE [dbo].[pr_home_field_delete] 
	(
		@team_id			INT
		,@field_id			INT
	)
AS
BEGIN

	--Insert the new contact into the table
	DELETE FROM dbo.home_field
	WHERE
		team_id = @team_id
		AND field_id = @field_id

END