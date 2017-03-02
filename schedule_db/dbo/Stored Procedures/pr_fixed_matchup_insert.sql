CREATE PROCEDURE [dbo].[pr_fixed_matchup_insert]
(
	@league_id			INT
	,@home_team_id		INT
	,@away_team_id		INT
	,@field_id			INT = -1
	,@matchup_date		VARCHAR(10) = NULL
	,@matchup_time		VARCHAR(10) = NULL
	,@am_pm				VARCHAR(2) = NULL
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
		,@matchup_datetime

END