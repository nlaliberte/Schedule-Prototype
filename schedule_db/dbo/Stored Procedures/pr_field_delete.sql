CREATE PROCEDURE [dbo].[pr_field_delete] (@field_id	INT)
AS 
BEGIN
		
	DELETE FROM dbo.home_field
	WHERE field_id = @field_id

	DELETE FROM dbo.permit
	WHERE field_id = @field_id

	DELETE FROM dbo.field
	WHERE field_id = @field_id

END