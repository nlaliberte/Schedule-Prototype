CREATE PROCEDURE [dbo].[pr_permit_delete] (@permit_id INT)
AS
BEGIN
	
	DELETE FROM dbo.permit
	WHERE permit_id = @permit_id

END