CREATE PROCEDURE [dbo].[pr_contact_dropdown](@league_id INT)
AS 
BEGIN
	
	SELECT
		contact_id
		,contact_name = first_name + ' ' + ISNULL(last_name,'')
	FROM dbo.contact
	WHERE league_id = @league_id
	UNION
	SELECT
		-1
		,''
			
END