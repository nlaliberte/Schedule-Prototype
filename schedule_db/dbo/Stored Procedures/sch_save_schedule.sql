CREATE PROCEDURE [dbo].[sch_save_schedule] 
	(
		@league_id	INT
		,@stg_id	INT
	) 
AS 
BEGIN

	UPDATE p
	SET home_team_id = s.home_team_id
	FROM 
		permit p
		INNER JOIN stg_permit s ON p.permit_id = s.permit_id
			AND s.stg_id = @stg_id
			AND s.league_id = @league_id

	DELETE FROM matchup
	WHERE league_id = @league_id

	INSERT INTO matchup
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
	FROM stg_matchup
	WHERE 
		league_id = @league_id
		AND stg_id = @stg_id

END