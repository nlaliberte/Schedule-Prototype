CREATE PROCEDURE [dbo].[sch_schedule_getbyteam] 
	(
		@league_id		INT
		,@stg_id		INT
		,@team_id		INT
	)
AS
BEGIN

	SELECT 
		m.matchup_id
		,permit_date = CONVERT(VARCHAR(10),p.permit_date,101)
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
		,team = t.team_name
		,vs = 'vs.'
		,opponent = at.team_name
		,field_name = f.field_name
	FROM 
		stg_matchup m
		INNER JOIN team t ON m.home_team_id = t.team_id
		INNER JOIN team at ON m.away_team_id = at.team_id
		INNER JOIN permit p ON m.permit_id = p.permit_id
		INNER JOIN field f ON p.field_id = f.field_id
	WHERE
		m.league_id = @league_id
		AND m.stg_id = @stg_id
		AND m.home_team_id = @team_id
	UNION
	SELECT 
		m.matchup_id
		,permit_date = CONVERT(VARCHAR(10),p.permit_date,101)
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
		,team = at.team_name
		,vs = '@'
		,opponent = t.team_name
		,field_name = f.field_name
	FROM 
		stg_matchup m
		INNER JOIN team t ON m.home_team_id = t.team_id
		INNER JOIN team at ON m.away_team_id = at.team_id
		INNER JOIN permit p ON m.permit_id = p.permit_id
		INNER JOIN field f ON p.field_id = f.field_id
	WHERE
		m.league_id = @league_id
		AND m.stg_id = @stg_id
		AND m.away_team_id = @team_id
	ORDER BY
		permit_date
		,permit_time
	
	
END