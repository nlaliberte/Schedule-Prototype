CREATE PROCEDURE [dbo].[pr_fixed_matchup_get] (@fixed_matchup_id	INT)
AS 
BEGIN
	
	SELECT
		home_team_id 
		,away_team_id
		,field_id
		,matchup_date 
	FROM dbo.fixed_matchup
	WHERE fixed_matchup_id = @fixed_matchup_id

END