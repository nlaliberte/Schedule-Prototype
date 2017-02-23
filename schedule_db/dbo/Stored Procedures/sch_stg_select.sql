CREATE PROCEDURE [dbo].[sch_stg_select] (@league_id INT, @stg_id INT) 
AS 
BEGIN

	DELETE FROM dbo.matchup
	WHERE league_id = @league_id
	
	INSERT INTO dbo.matchup
	(
		stg_id
		,league_id
		,matchup_id
		,home_team_id
		,away_team_id
		,permit_id
	)
	SELECT
		stg_id
		,league_id
		,matchup_id
		,home_team_id
		,away_team_id
		,permit_id
	FROM dbo.stg_matchup
	WHERE
		league_id = @league_id
		AND stg_id = @stg_id

END