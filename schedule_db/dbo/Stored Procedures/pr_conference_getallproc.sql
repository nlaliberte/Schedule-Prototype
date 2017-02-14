CREATE PROCEDURE [dbo].[pr_conference_getall] (@league_id INT)
AS 
BEGIN
	
	SELECT 
		conference_id
		,conference_name
	FROM dbo.conference 
	WHERE league_id = @league_id
	
END