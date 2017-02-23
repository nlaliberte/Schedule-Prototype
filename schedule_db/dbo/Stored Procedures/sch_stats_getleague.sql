CREATE PROCEDURE [dbo].[sch_stats_getleague] (@league_id INT) 
AS 
BEGIN
	
	DECLARE @chosen_stg INT
	
	SELECT @chosen_stg = ISNULL((SELECT MAX(stg_id) FROM matchup WHERE league_id = @league_id),-1)
	
	SELECT @chosen_stg
	
	SELECT  
		a.stg_id
		,two_row = SUM(a.two_in_a_row)
		,two_row_avg = AVG(CONVERT(DECIMAL(4,1),a.two_in_a_row))
		,two_row_max = MAX(a.two_in_a_row)
		,three_row = SUM(a.three_in_a_row)
		,three_row_avg = AVG(CONVERT(DECIMAL(4,1),a.three_in_a_row))
		,three_row_max = MAX(a.three_in_a_row)
		,four_row = SUM(a.four_in_a_row)
		,four_row_avg = AVG(CONVERT(DECIMAL(4,1),a.four_in_a_row))
		,four_row_max = MAX(a.four_in_a_row)
		,five_row = SUM(a.five_in_a_row)
		,five_row_avg = AVG(CONVERT(DECIMAL(4,1), a.five_in_a_row))
		,five_row_max = MAX(a.five_in_a_row)
		,six_row = SUM(a.six_in_a_row)
		,six_row_avg = AVG(CONVERT(DECIMAL(4,1), a.six_in_a_row))
		,six_row_max = MAX(a.six_in_a_row)
		,no_week = SUM(a.no_game_week)
		,no_week_avg = AVG(CONVERT(DECIMAL(4,1), a.no_game_week))
		,no_week_max = MAX(a.no_game_week)
		,one_week = SUM(a.one_game_week)
		,one_week_avg = AVG(CONVERT(DECIMAL(4,1), a.one_game_week))
		,one_week_max = MAX(a.one_game_week)
		,two_week = 0--SUM(two_game_week)
		,two_week_avg = 0--AVG(CONVERT(DECIMAL(4,1), two_game_week))
		,two_week_max = 0--MAX(two_game_week) 
		,three_week = SUM(a.three_game_week)
		,three_week_avg = AVG(CONVERT(DECIMAL(4,1), a.three_game_week))
		,three_week_max = MAX(a.three_game_week)
		,four_week = SUM(a.four_game_week)
		,four_week_avg = AVG(CONVERT(DECIMAL(4,1), a.four_game_week))
		,four_week_max = MAX(a.four_game_week)
		,five_week = SUM(a.five_game_week)
		,five_week_avg = AVG(CONVERT(DECIMAL(4,1), a.five_game_week))
		,five_week_max = MAX(a.five_game_week)
		,six_week = SUM(a.six_game_week)
		,six_week_avg = AVG(CONVERT(DECIMAL(4,1), a.six_game_week))
		,six_week_max = MAX(a.six_game_week)
		,seven_week = SUM(a.seven_game_week)
		,seven_week_avg = AVG(CONVERT(DECIMAL(4,1), a.seven_game_week))
		,seven_week_max = MAX(a.seven_game_week)
		,may_games = SUM(a.may_games)
		,may_games_avg = AVG(CONVERT(DECIMAL(4,1), a.may_games))
		,may_games_max = MAX(a.may_games)
		,may_games_min = MIN(a.may_games)
		,june_games = AVG(a.june_games)
		,june_games_avg = AVG(CONVERT(DECIMAL(4,1), a.june_games))
		,june_games_max = MAX(a.june_games)
		,june_games_min = MIN(a.june_games)
		,july_games = AVG(a.july_games)
		,july_games_avg = AVG(CONVERT(DECIMAL(4,1), a.july_games))
		,july_games_max = MAX(a.july_games)
		,july_games_min = MIN(a.july_games)
		,august_games = AVG(a.august_games)
		,august_games_avg = AVG(CONVERT(DECIMAL(4,1), a.august_games))
		,august_games_max = MAX(a.august_games)
		,august_games_min = MIN(a.august_games)
		,remaining_matchups_to_schedule = SUM(b.remaining_matchups_to_schedule)
		,chosen_stg = CASE WHEN a.stg_id = @chosen_stg THEN 1 ELSE 0 END
		,create_date = MAX(a.create_date)
	FROM 
		stg_stats a
		INNER JOIN
		(
			SELECT DISTINCT 
				s.stg_id
				,s.home_team_id
				,remaining_matchups_to_schedule = ISNULL(x.matchups,0)
			FROM
				stg_matchup s
				LEFT JOIN
				(
					SELECT
						stg_id
						,home_team_id
						,matchups = COUNT(1)
					FROM stg_matchup
					WHERE 
						permit_id = -1
						AND league_id = @league_id
					GROUP BY 
						stg_id
						,home_team_id
				) x ON s.stg_id = x.stg_id
					AND s.home_team_id = x.home_team_id
			WHERE s.league_id = @league_id
		) b ON a.stg_id = b.stg_id AND a.team_id = b.home_team_id
	WHERE a.league_id = @league_id
	GROUP BY a.stg_id 
	ORDER BY a.stg_id

END