CREATE PROCEDURE [dbo].[pr_contact_get](@contact_id INT)
AS 
BEGIN
	
	SELECT 
		contact_id
		,first_name
		,last_name
		,email
		,phone
	FROM dbo.contact
	WHERE contact_id = @contact_id

END