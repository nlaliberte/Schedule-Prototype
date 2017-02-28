CREATE PROCEDURE [dbo].[pr_field_insert] 
	(
		@field_name		VARCHAR(255)
		,@addr			VARCHAR(255)
		,@city			VARCHAR(255)
		,@state			VARCHAR(2)
		,@zip			VARCHAR(5)
	)
AS 
BEGIN
		DECLARE @field_id INT = (SELECT ISNULL(MAX(field_id),1) + 1 FROM dbo.field)

		INSERT INTO dbo.field
		(
			field_id
			,field_name
			,addr
			,addr_2
			,addr_3
			,city
			,state_code
			,zip
		)
		SELECT
			field_id = @field_id 
			,field_name = @field_name
			,addr = @addr
			,addr_2 = ''
			,addr_3 = ''
			,city = @city
			,state_code = @state
			,zip = @zip

END