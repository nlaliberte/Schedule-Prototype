CREATE PROCEDURE [dbo].[pr_contact_delete](@contact_id INT)
AS 
BEGIN
	UPDATE dbo.league
	SET primary_contact_id = -1
	WHERE primary_contact_id = @contact_id

	UPDATE dbo.league
	SET secondary_contact_id = -1
	WHERE secondary_contact_id = @contact_id

	UPDATE dbo.team
	SET contact_id = -1
	WHERE contact_id = @contact_id

	UPDATE dbo.team
	SET contact_id2 = -1
	WHERE contact_id2 = @contact_id

	DELETE FROM dbo.contact
	WHERE contact_id = @contact_id

END