CREATE PROCEDURE [dbo].[pr_fixed_matchup_insert]
(
	@league_id			INT
	,@home_team_id		INT
	,@away_team_id		INT
	,@field_id			INT = -1
	,@matchup_date		DATETIME = NULL
)
AS 
BEGIN
	
	INSERT INTO dbo.fixed_matchup
	(
		league_id
		,home_team_id
		,away_team_id
		,field_id
		,matchup_date
	)
	SELECT
		@league_id
		,@home_team_id
		,@away_team_id
		,@field_id
		,@matchup_date

END