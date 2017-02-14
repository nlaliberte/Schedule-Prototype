CREATE PROCEDURE [dbo].[pr_home_field_getall] (@team_id INT)
AS 
BEGIN
	
	SELECT 
		h.team_id
		,t.team_name
		,h.field_id
		,f.field_name
	FROM 
		dbo.team t
		INNER JOIN dbo.home_field h ON t.team_id = h.team_id
		INNER JOIN dbo.field f ON h.field_id = f.field_id
	WHERE t.team_id = @team_id
	
END