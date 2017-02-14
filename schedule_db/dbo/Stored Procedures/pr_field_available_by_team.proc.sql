CREATE PROCEDURE [dbo].[pr_field_available_by_team] (@team_id INT)
AS 
BEGIN
	
	SELECT 
		f.field_id
		,f.field_name
		,f.addr
		,f.addr_2
		,f.addr_3
		,f.city
		,f.state_code
		,f.zip
	FROM dbo.field f 
	WHERE NOT EXISTS
	(
		SELECT h.field_id
		FROM dbo.home_field h
		WHERE f.field_id = h.field_id
			AND h.team_id = @team_id
	)
	
END