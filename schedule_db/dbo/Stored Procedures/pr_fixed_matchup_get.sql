CREATE PROCEDURE [dbo].[pr_fixed_matchup_get] (@fixed_matchup_id	INT)
AS 
BEGIN
	
	SELECT
		home_team_id 
		,away_team_id
		,field_id
		,matchup_date = CONVERT(VARCHAR(10),matchup_date,101)
		,matchup_time = 
				CASE 
					WHEN DATEPART(HH,matchup_date) = 0
					THEN '12'
					WHEN DATEPART(HH,matchup_date) > 12 
					THEN CONVERT(VARCHAR(2),DATEPART(HH,matchup_date)-12)
					ELSE CONVERT(VARCHAR(2),DATEPART(HH,matchup_date))
				END 
				+':'+
				CASE 
					WHEN DATEPART(MINUTE,matchup_date) = 0
					THEN '00'
					ELSE CONVERT(VARCHAR(2),DATEPART(MINUTE,matchup_date))
				END
		,matchup_ampm = CASE WHEN DATEPART(HH,matchup_date) >= 12 THEN 'PM' ELSE 'AM' END
	FROM dbo.fixed_matchup
	WHERE fixed_matchup_id = @fixed_matchup_id

END