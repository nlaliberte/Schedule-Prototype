CREATE PROCEDURE [dbo].[pr_fixed_matchup_update]
(
	@fixed_matchup_id	INT
	,@home_team_id		INT
	,@away_team_id		INT
	,@field_id			INT 
	,@matchup_date		VARCHAR(10)
	,@matchup_time		VARCHAR(10)
	,@am_pm				VARCHAR(2)
)
AS 
BEGIN
	
	DECLARE @matchup_datetime DATETIME
	SELECT @matchup_datetime = 
		CASE 
			WHEN @matchup_time = '12:00' AND @am_pm = 'AM' THEN DATEADD(hh,-12,CONVERT(DATETIME,@matchup_date + ' ' + @matchup_time))
			WHEN @am_pm = 'AM' OR @matchup_time = '12:00' THEN CONVERT(DATETIME,@matchup_date + ' ' + @matchup_time)
			ELSE DATEADD(hh,12,CONVERT(DATETIME,@matchup_date + ' ' + @matchup_time))
		END

	UPDATE dbo.fixed_matchup
	SET
		home_team_id = @home_team_id
		,away_team_id = @away_team_id
		,field_id = @field_id
		,matchup_date = @matchup_datetime
	WHERE fixed_matchup_id = @fixed_matchup_id

END