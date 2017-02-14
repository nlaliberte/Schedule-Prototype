CREATE PROCEDURE [dbo].[pr_home_field_insert] 
	(
		@team_id			INT
		,@field_id			INT
	)
AS
BEGIN

	--Insert the new contact into the table
	INSERT INTO dbo.home_field
	VALUES (@team_id, @field_id)
	
END