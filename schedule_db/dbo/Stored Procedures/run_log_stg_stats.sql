CREATE PROCEDURE [dbo].[run_log_stg_stats] 
	(
		@league_id		INT
		,@stg_id		INT
		,@session_start	DATETIME
	)
AS
BEGIN
	
	DELETE FROM dbo.stg_stats
	WHERE	
		league_id = @league_id
		AND stg_id = @stg_id
		
	CREATE TABLE #schedule
	(
		schedule_id		INT			IDENTITY
		,matchup_id		INT			NOT NULL
		,league_id		INT			NOT NULL
		,stg_id			INT			NOT NULL
		,team			INT			NOT NULL
		,opponent		INT			NOT NULL
		,home_team_id	INT			NOT NULL
		,permit_date	DATETIME	NOT NULL
	)
	INSERT INTO #schedule	
	SELECT 
		m.matchup_id 
		,m.league_id
		,m.stg_id
		,team = m.home_team_id
		,opponent = m.away_team_id
		,home_team_id = m.home_team_id	
		,p.permit_date
	FROM
		stg_matchup m
		INNER JOIN stg_permit p ON m.permit_id = p.permit_id 
			AND p.stg_id = @stg_id
			AND p.league_id = @league_id
	WHERE
		m.stg_id = @stg_id
		AND m.league_id = @league_id
	UNION
	SELECT 
		m.matchup_id 
		,m.league_id
		,m.stg_id
		,team = m.away_team_id
		,opponent = m.home_team_id
		,home_team_id = m.home_team_id
		,p.permit_date
	FROM
		stg_matchup m
		INNER JOIN stg_permit p ON m.permit_id = p.permit_id 
			AND p.stg_id = @stg_id
			AND p.league_id = @league_id
	WHERE 
		m.stg_id = @stg_id
		AND m.league_id = @league_id
	ORDER BY stg_id, team, permit_date
		

	CREATE TABLE #weekly_count
	(
		team_id			INT		NOT NULL
		,week_id		INT		NOT NULL
		,num_games		INT		NOT NULL
	)
	INSERT INTO #weekly_count
	SELECT 
		x.team
		,x.week_id
		,SUM(CASE WHEN sx.schedule_id IS NULL THEN 0 ELSE 1 END)
	FROM
		(
			SELECT DISTINCT 
				s.team
				,c.week_id
			FROM 
				#schedule s
				FULL OUTER JOIN dbo.calendar c
					ON c.date_date <= (SELECT MAX(permit_date) FROM dbo.stg_permit WHERE stg_id = @stg_id)
					AND c.date_date >= (SELECT MIN(permit_date) FROM dbo.stg_permit WHERE stg_id = @stg_id)
			WHERE s.team IS NOT NULL
			AND s.stg_id = @stg_id
		) x
		LEFT JOIN dbo.calendar cx ON x.week_id = cx.week_id
			AND cx.date_date <= (SELECT MAX(permit_date) FROM dbo.stg_permit WHERE stg_id = @stg_id)
			AND cx.date_date >= (SELECT MIN(permit_date) FROM dbo.stg_permit WHERE stg_id = @stg_id)
		LEFT JOIN #schedule sx ON CONVERT(DATE,(cx.date_date)) = CONVERT(DATE,(sx.permit_date))
			AND x.team = sx.team
			AND sx.stg_id = @stg_id
	GROUP BY 
		x.team
		,x.week_id
	
	CREATE TABLE #schedule_rpt	
	(
		schedule_id			INT			NOT NULL
		,matchup_id			INT			NOT NULL
		,league_id			INT			NOT NULL
		,team				INT			NOT NULL
		,permit_date		DATETIME	NOT NULL
		,last_game			INT			NOT NULL
		,two_games_ago		INT			NOT NULL
		,three_games_ago	INT			NOT NULL
		,four_games_ago		INT			NOT NULL
		,five_games_ago		INT			NOT NULL
	)
	INSERT INTO #schedule_rpt
	SELECT 
		s.schedule_id
		,s.matchup_id
		,s.league_id
		,s.team
		,s.permit_date
		,last_game = ISNULL(DATEDIFF(dd,p.permit_date, s.permit_date),0)
		,two_games_ago = ISNULL(DATEDIFF(dd,p2.permit_date, s.permit_date),0)
		,three_games_ago = ISNULL(DATEDIFF(dd,p3.permit_date, s.permit_date),0)
		,four_games_ago = ISNULL(DATEDIFF(dd,p4.permit_date, s.permit_date),0)
		,five_games_ago = ISNULL(DATEDIFF(dd,p5.permit_date, s.permit_date),0)
	FROM 
		#schedule s
		LEFT JOIN #schedule p ON s.schedule_id = p.schedule_id + 1
			AND s.team = p.team
		LEFT JOIN #schedule p2 ON s.schedule_id = p2.schedule_id + 2
			AND s.team = p2.team
		LEFT JOIN #schedule p3 ON s.schedule_id = p3.schedule_id + 3
			AND s.team = p3.team
		LEFT JOIN #schedule p4 ON s.schedule_id = p4.schedule_id + 4
			AND s.team = p4.team
		LEFT JOIN #schedule p5 ON s.schedule_id = p5.schedule_id + 5
			AND s.team = p5.team
	ORDER BY 
		s.team
		,s.permit_date
		
		
	INSERT INTO dbo.stg_stats
	SELECT 
		league_id = @league_id
		,stg_id = @stg_id 
		,a.team_id		
		,two_in_a_row = a.two_in_a_row - (a.three_in_a_row*2)
		,three_in_a_row = a.three_in_a_row - (a.four_in_a_row*2)
		,four_in_a_row = a.four_in_a_row - (a.five_in_a_row*2)
		,five_in_a_row = a.five_in_a_row - (a.six_in_a_row*2)
		,six_in_a_row = a.six_in_a_row
		,b.no_game_week
		,b.one_game_week
		,b.two_game_week
		,b.three_game_week
		,b.four_game_week
		,b.five_game_week
		,b.six_game_week
		,b.seven_game_week
		,c.may_games
		,c.june_games
		,c.july_games
		,c.august_games
		,create_date = @session_start
	FROM
		(
			SELECT 
				team_id = team
				,two_in_a_row = SUM(CASE last_game WHEN 1 THEN 1 ELSE 0 END)
				,three_in_a_row = SUM(CASE two_games_ago WHEN 2 THEN 1 ELSE 0 END)
				,four_in_a_row = SUM(CASE three_games_ago WHEN 3 THEN 1 ELSE 0 END)
				,five_in_a_row = SUM(CASE four_games_ago WHEN 4 THEN 1 ELSE 0 END)
				,six_in_a_row = SUM(CASE five_games_ago WHEN 5 THEN 1 ELSE 0 END)
			FROM #schedule_rpt
			GROUP BY team
		) a
		INNER JOIN 
		(
			SELECT 
				team_id
				,no_game_week = SUM(CASE num_games WHEN 0 THEN 1 ELSE 0 END)
				,one_game_week = SUM(CASE num_games WHEN 1 THEN 1 ELSE 0 END) 
				,two_game_week = SUM(CASE num_games WHEN 2 THEN 1 ELSE 0 END) 
				,three_game_week = SUM(CASE num_games WHEN 3 THEN 1 ELSE 0 END) 
				,four_game_week = SUM(CASE num_games WHEN 4 THEN 1 ELSE 0 END) 
				,five_game_week = SUM(CASE num_games WHEN 5 THEN 1 ELSE 0 END) 
				,six_game_week = SUM(CASE num_games WHEN 6 THEN 1 ELSE 0 END) 
				,seven_game_week = SUM(CASE num_games WHEN 7 THEN 1 ELSE 0 END)
			FROM #weekly_count
			GROUP BY team_id
		) b ON a.team_id = b.team_id
		INNER JOIN
		(
			SELECT
				m.team_id
				,may_games = SUM(CASE m.month_id WHEN 5 THEN num_games ELSE 0 END)
				,june_games = SUM(CASE m.month_id WHEN 6 THEN num_games ELSE 0 END)
				,july_games = SUM(CASE m.month_id WHEN 7 THEN num_games ELSE 0 END)
				,august_games = SUM(CASE m.month_id WHEN 8 THEN num_games ELSE 0 END)
			FROM
			(
				SELECT
					team_id = s.team
					,c.month_id
					,num_games = COUNT(1)
				FROM
					#schedule s
					INNER JOIN dbo.calendar c ON CONVERT(DATE,s.permit_date) = CONVERT(DATE,c.date_date)
				GROUP BY
					s.team
					,c.month_id
			) m
			GROUP BY m.team_id
		)c ON a.team_id = c.team_id
	
	DROP TABLE #schedule
	DROP TABLE #schedule_RPT
	DROP TABLE #weekly_count

END