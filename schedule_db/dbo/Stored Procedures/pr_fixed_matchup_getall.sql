CREATE PROCEDURE [dbo].[pr_fixed_matchup_getall] (@league_id	INT)
AS 
BEGIN
	
	SELECT
		fm.fixed_matchup_id
		,fm.home_team_id 
		,home_team_name = ht.team_name
		,fm.away_team_id
		,away_team_name = at.team_name
		,p.field_id
		,field_name = ISNULL(f.field_name,'')
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
				+' '+
				CASE 
					WHEN DATEPART(HH,p.permit_date) >= 12
					THEN 'PM'
					ELSE 'AM'
				END
	FROM 
		dbo.fixed_matchup fm
		INNER JOIN dbo.team ht ON fm.home_team_id = ht.team_id
		INNER JOIN dbo.team at ON fm.away_team_id = at.team_id
		LEFT JOIN dbo.permit p ON fm.permit_id = p.permit_id
		LEFT JOIN dbo.field f ON p.field_id = f.field_id
	WHERE fm.league_id = @league_id

END