CREATE PROCEDURE [dbo].[pr_team_delete] (@team_id INT)
AS
BEGIN
	
	--First Remove any permits belonging to the team
	DELETE FROM dbo.permit WHERE home_team_id = @team_id
	
	--Remove any Home Field Records
	DELETE FROM dbo.home_field WHERE team_id = @team_id
	
	--Remove any Team Off Days
	DELETE FROM dbo.team_off_day WHERE team_id = @team_id
	
	--Remove the Team
	DELETE FROM dbo.team	WHERE team_id = @team_id
		
END