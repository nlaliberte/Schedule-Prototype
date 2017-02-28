CREATE PROCEDURE [dbo].[pr_contact_update]
	(
		@contact_id INT
		,@first_name VARCHAR(255)
		,@last_name VARCHAR(255)
		,@phone VARCHAR(12)
		,@email VARCHAR(500)
	)
AS 
BEGIN
	
	UPDATE dbo.contact
	SET
		first_name = @first_name
		,last_name = @last_name
		,phone = @phone
		,email = @email
	WHERE contact_id = @contact_id

END