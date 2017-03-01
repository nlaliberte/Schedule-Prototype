CREATE PROCEDURE [dbo].[pr_fixed_matchup_update]
(
	@fixed_matchup_id	INT
	,@home_team_id		INT
	,@away_team_id		INT
	,@field_id			INT 
	,@matchup_date		DATETIME 
)
AS 
BEGIN
	
	UPDATE dbo.fixed_matchup
	SET
		home_team_id = @home_team_id
		,away_team_id = @away_team_id
		,field_id = @field_id
		,matchup_date = @matchup_date
	WHERE fixed_matchup_id = @fixed_matchup_id

END