CREATE PROCEDURE [dbo].[sch_stg_export] (@league_id INT, @stg_id INT) 
AS 
BEGIN

	SELECT 
		permit_date = CONVERT(VARCHAR(10),p.permit_date,101)
		,permit_time = 
				CASE 
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
		,home_team = ht.team_name
		,away_team = at.team_name
		,field_name = f.field_name
	FROM 
		dbo.matchup m
		INNER JOIN dbo.team ht ON m.home_team_id = ht.team_id
		INNER JOIN dbo.team at ON m.away_team_id = at.team_id
		INNER JOIN dbo.permit p ON m.permit_id = p.permit_id
		INNER JOIN dbo.field f ON p.field_id = f.field_id
	ORDER By
		permit_date
		,permit_time
END