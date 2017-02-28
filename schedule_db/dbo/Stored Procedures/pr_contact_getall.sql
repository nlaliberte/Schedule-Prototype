CREATE PROCEDURE [dbo].[pr_contact_getall](@league_id INT)
AS 
BEGIN
	
	SELECT 
		contact_id
		,first_name
		,last_name
		,email
		,phone
	FROM dbo.contact
	WHERE league_id = @league_id

END