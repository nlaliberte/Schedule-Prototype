CREATE PROCEDURE [dbo].[pr_fixed_matchup_get] (@fixed_matchup_id	INT)
AS 
BEGIN
	
	SELECT
		fm.home_team_id 
		,fm.away_team_id
		,p.field_id
		,matchup_date = CONVERT(VARCHAR(10),p.permit_date,101)
		,matchup_time = 
				CASE 
					WHEN DATEPART(HH,p.permit_date) = 0
					THEN '12'
					WHEN DATEPART(HH,p.permit_date) > 12 
					THEN CONVERT(VARCHAR(2),DATEPART(HH,p.permit_date)-12)
					ELSE CONVERT(VARCHAR(2),DATEPART(HH,p.permit_date))
				END 
				+':'+
				CASE 
					WHEN DATEPART(MINUTE,p.permit_date) = 0
					THEN '00'
					ELSE CONVERT(VARCHAR(2),DATEPART(MINUTE,p.permit_date))
				END
		,matchup_ampm = CASE WHEN DATEPART(HH,p.permit_date) >= 12 THEN 'PM' ELSE 'AM' END
	FROM 
		dbo.fixed_matchup fm
		LEFT JOIN dbo.permit p ON fm.permit_id = p.permit_id
	WHERE fm.fixed_matchup_id = @fixed_matchup_id

END