CREATE PROCEDURE [dbo].[pr_field_update] 
	(
		@field_id		INT
		,@field_name	VARCHAR(255)
		,@addr			VARCHAR(255)
		,@city			VARCHAR(255)
		,@state			VARCHAR(2)
		,@zip			VARCHAR(5)
	)
AS 
BEGIN
		
		UPDATE dbo.field
		SET 
			field_name = @field_name
			,addr = @addr
			,city = @city
			,state_code = @state
			,zip = @zip
		WHERE field_id = @field_id

END