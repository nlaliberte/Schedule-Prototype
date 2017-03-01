CREATE PROCEDURE [dbo].[pr_fixed_matchup_getall] (@league_id	INT)
AS 
BEGIN
	
	SELECT
		fixed_matchup_id
		,home_team_id 
		,away_team_id
		,field_id
		,matchup_date 
	FROM dbo.fixed_matchup
	WHERE league_id = @league_id

END