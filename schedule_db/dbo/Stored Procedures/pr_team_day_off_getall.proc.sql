CREATE PROCEDURE [dbo].[pr_team_day_off_getall] @team_id INT
AS 
BEGIN
	
	SELECT
		team_id
		,off_day = CONVERT(VARCHAR(10),off_day,101)
	FROM dbo.team_off_day 
	WHERE team_id = @team_id
	
END
