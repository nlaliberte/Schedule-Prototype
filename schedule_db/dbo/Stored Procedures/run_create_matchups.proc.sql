
---- ===============================================
---- Author:		Nate Laliberte
---- Create date: 09/27/2012
---- Description:	Will clear out existing matchup data and create new matchups based on inputted league format
---- ===============================================
CREATE PROCEDURE [dbo].[run_create_matchups] 
	(
		@league_id	INT
		,@stg_id	INT
	)
AS
BEGIN

	--We need to determine the league format based on the input given.
	--Number of teams should be what's in the team table
	DECLARE
		@number_of_games				INT
		,@number_of_teams				INT
		,@number_of_conferences			INT
		,@number_of_games_in_conference	INT
		
	SELECT
		@number_of_games = number_of_games
		,@number_of_teams = number_of_teams
		,@number_of_conferences = number_of_conferences
		,@number_of_games_in_conference = number_of_games_in_conference
	FROM dbo.league
	WHERE league_id = @league_id
		
	--!!THERE CAN NOT BE AN ODD NUMBER OF TEAMS IN THE LEAGUE AND AND ODD NUMBER OF GAMES PLAYED.  WE SHOULD THROW AN ERROR HERE IN THE FRONT END!!
	IF (@number_of_games %2) = 1 AND (@number_of_teams % 2) = 1
	BEGIN
		SELECT 'ERROR: You can not create a complete schedule where an odd number of teams plays an odd number of games'
		RETURN
	END
	--!!IF ANY CONFERENCE HAS AN ODD NUMBER OF TEAMS THERE CAN NOT BE AN ODD NUMBER OF CONFERENCE GAMES. WE SHOULD THROW AN ERROR HERE IN THE FRONT END!!
	IF (@number_of_games_in_conference % 2) = 1 AND EXISTS (SELECT conference_id FROM team GROUP BY conference_id HAVING (COUNT(team_id) % 2) = 1)
	BEGIN
		SELECT 'ERROR: You can not create a complete schedule with an odd number of games in conference and a conference with an odd number of teams'
		RETURN
	END

	--If we are using a conference format the @number_of_games_in_conference variable will be greater than 0
	DECLARE @use_conference INT = (SELECT CASE @number_of_games_in_conference WHEN 0 THEN 0 ELSE 1 END)


	--Clear out all records currently in the matchup for this league
	DELETE FROM stg_matchup WHERE stg_id = @stg_id AND league_id = @league_id 

	--Let's Delcare some variables we'll use
	DECLARE @base INT
	DECLARE @iteration INT
	DECLARE @loop_id INT
	DECLARE @random_games INT
	DECLARE @sub_loop_id INT
	DECLARE @away_seed INT 
	DECLARE @increment INT

	DECLARE @home_seeds TABLE 
		(
			loop_id	INT	IDENTITY
			,seed_id INT NOT NULL
			,conference_id INT NOT NULL DEFAULT(-1)
		)

	DECLARE @away_seeds TABLE
		(
			seed_id INT NOT NULL
			,conference_id INT NOT NULL DEFAULT(-1)
		)

	DECLARE @temp_team TABLE
		(
			team_id		INT	NOT NULL
			,seed_id	INT	NOT NULL
		)

	DECLARE @temp_matchup TABLE
		(
			home_seed		INT		NOT NULL
			,away_seed		INT		NOT NULL
		)


	--If we are not using the conference, we will play every team a fixed number of games, and then randomly distribute the remaining
	--The fixed number of games is effectively the amount of whole times you can divide the total number of games by the number of teams.
	IF @use_conference = 0
	BEGIN
		--base = Determines the amount of times each team can play eachother
		SELECT @base = (SELECT @number_of_games / @number_of_teams) --since the variables are INTs we will get a whole number always rounded down

		--@iteration is the amount of fixed games each team will play against a given other team at home.  It's effectively the number of @base games you play against each team, divided by 2
		--If we don't have at least 1 iteration, the schedule will be completely random.  If the @base is an odd number (3), then the iteration will round down (3/2 = 1.5 = 1), and the rest of the games will be randomized
		SELECT @iteration = (SELECT CASE WHEN @base = 1 THEN 0 ELSE @base / 2 END)

		--We need to use a loop to add these games in case there is more than one iteration
		SELECT @loop_id = 1
		WHILE @loop_id <= @iteration
		BEGIN
			--Add a home and away game against each opponent, for every opponent
			INSERT INTO stg_matchup (league_id, stg_id, home_team_id, away_team_id)
			SELECT 
				league_id = @league_id
				,stg_id = @stg_id
				,home_team_id = t.team_id
				,away_team_id = a.team_id
			FROM
				(
					SELECT	
						c.league_id
						,ta.team_id
					FROM
						dbo.team ta
						INNER JOIN dbo.conference c ON ta.conference_id = c.conference_id
							AND c.league_id = @league_id
				) t
				CROSS JOIN 
				(
					SELECT	
						c.league_id
						,ta.team_id
					FROM
						dbo.team ta
						INNER JOIN dbo.conference c ON ta.conference_id = c.conference_id
							AND c.league_id = @league_id
				) a
			WHERE t.team_id <> a.team_id

			--Increment the loop
			SELECT @loop_id = @loop_id + 1
		END

		--Now we have the fixed games, we need to determine and add the random games.  
		--Since the @iteration is adding two games each pass, we multiply that by two and multiply it by the number of teams (minus 1 since teams don't play themselves). 
		--This gives you the number of games already in the matchup table for each team. Subtract that value from the total number of games to get the remaining 'random' games we need to add.
		SELECT @random_games = @number_of_games - ((@iteration*2) * (@number_of_teams - 1))

		-----------------------------------------
		--DEBUG CODE --checking all variables
		--select 
		--	number_of_games = @number_of_games
		--	,iteration = @iteration
		--	,number_of_teams = @number_of_teams
		--	,random_games = @random_games
		--	,increment = @increment
		--	,random_games = @random_games/2
		--	,extra_home_games = @random_games % 2
		-----------------------------------------

		--My approach to randomly selecting teams is one that doesn't use an algorithm to loop through teams and find the best possible matchups without duplication
		--Instead I use a mathmatical pattern to assign 'away_seeds' to 'home_seeds' 1 through @number of teams.  The pattern is essential the home_seed + (@number_of_teams / @random_games)...
		--This pattern will eventually go past @number_of_teams, at which point a modular (remainder) is used to represent the away_seed.
		--This pattern is scalable and will work for any number of teams and any number of games played, ensuring every team plays the same number of games, and doesn't play any one team
		--more than any other one team.

		--If the number of random games is odd, we split the league in half and assign that half home games against the other half, ensuring that other
		--random games have not already been scheduled between the two as well.

		--Once this pattern is established in the @temp_matchup table, I use the @temp_team table to randomly assign a seed to each team that corresponds to the seeds in the @temp_matchup table.
		--A join between these two tables will then produce the actual random matchups between team_ids.
		--Reset the Loop and declare other variables
		SELECT @loop_id = 1
		SELECT @sub_loop_id = 1
		SELECT @away_seed = -1
		SELECT @increment = (@number_of_teams - 1)/(@random_games/2)--teams don't play themselves, and @random_games is divided by 2 to only represent home games

		WHILE @loop_id <= @number_of_teams
		BEGIN
			SELECT @sub_loop_id = 1

			WHILE @sub_loop_id <= (@random_games / 2) --The number of home games we need to schedule
			BEGIN
				SELECT @away_seed = (@loop_id + @sub_loop_id)
				SELECT @away_seed = CASE WHEN @away_seed > @number_of_teams THEN (@away_seed % @number_of_teams) ELSE @away_seed END

				INSERT INTO @temp_matchup (home_seed, away_seed)
				SELECT @loop_id, @away_seed

				SELECT @sub_loop_id = @sub_loop_id + 1
			END

			SELECT @loop_id = @loop_id + 1
		END

		--If there are an odd number of random games to be assigned, we'll need to assign a home game to half of the league.
		--Since the seeds are being assigned random teams, we can just talk the first half of the seeds, the randomization will come later.
		--(In order for there to be an odd number of random games, there must be an even number of teams)
		IF (@random_games % 2) = 1
		BEGIN
			--Get all home seeds
			DELETE FROM @home_seeds
			INSERT INTO @home_seeds (seed_id)
			SELECT t.team_id
			FROM 
				dbo.team t
				INNER JOIN dbo.conference c ON t.conference_id = c.conference_id
					AND c.league_id = @league_id
			WHERE (t.team_id % 2) = 0
			
			--Add remaining seeds to the away table
			DELETE FROM @away_seeds 
			INSERT INTO @away_seeds (seed_id)
			SELECT t.team_id
			FROM 
				dbo.team t
				INNER JOIN dbo.conference c ON t.conference_id = c.conference_id
					AND c.league_id = @league_id
			WHERE (t.team_id % 2) = 1

			--Now let's go through each home seed and assign an available away seed.
			SELECT @loop_id = 1
			SELECT @away_seed = -1
			WHILE @loop_id <= (SELECT MAX(loop_id) FROM @home_seeds)
			BEGIN
				SELECT @away_seed = 
				(
					SELECT TOP 1 a.seed_id
					FROM 
						@home_seeds h
						CROSS JOIN @away_seeds a
						LEFT JOIN @temp_matchup m ON h.seed_id = m.home_seed
							AND m.away_seed = a.seed_id
					WHERE 
						h.loop_id = @loop_id
						AND m.away_seed IS NULL
					ORDER BY
						h.seed_id
						,a.seed_id
				)
				--remove the away seed from the available seeds as it now has a matchup
				DELETE FROM @away_seeds WHERE seed_id = @away_seed

				--Add the matchup to the table
				INSERT INTO @temp_matchup (home_seed, away_seed)
				SELECT 
					seed_id
					,@away_seed
				FROM @home_seeds
				WHERE loop_id = @loop_id

				--Increment Loop
				SELECT @loop_id = @loop_id + 1
			END		
		END
		
		--Now get the list of teams in a random order, so we can apply it to the seeds in @temp_matchup
		DELETE FROM @temp_team
		INSERT INTO @temp_team 
		SELECT
			t.team_id 
			,seed_id = RANK() OVER (ORDER BY newid()) --Random Order
		FROM 
			dbo.team t
			INNER JOIN dbo.conference c ON t.conference_id = c.conference_id
				AND c.league_id = @league_id
		
		--Now Lets insert the games against random opponents
		INSERT INTO stg_matchup (league_id, stg_id, home_team_id, away_team_id)
		SELECT 
			league_id = @league_id
			,stg_id = @stg_id
			,htt.team_id
			,att.team_id
		FROM 
			@temp_matchup g
			INNER JOIN @temp_team htt ON g.home_seed = htt.seed_id
			INNER JOIN @temp_team att ON g.away_seed = att.seed_id

	END
	--End of Non-Conference scheduling
	--ELSE
	--BEGIN --Start Conference Scheduling
	--	--IN CONFERENCE GAMES
	--	--Due to the parameter, we already know how many in-conference games we need to schedule.  If the number is odd
	--	--we'll need to randomly choose home teams.
	--	DECLARE @teams_in_conference INT = ((SELECT COUNT(1) FROM team) / (SELECT COUNT(DISTINCT conference_id) FROM team))
	--	DECLARE @number_of_conferences INT = (SELECT COUNT(DISTINCT conference_id) FROM team)

	--	--@iteration is the amount of fixed games each team will play against a given other team at home.  It's effectively the number of conference games you play against each team, divided by 2
	--	--If we don't have at least 1 iteration, the schedule will be completely random.  If the @base is an odd number (3), then the iteration will round down (3/2 = 1.5 = 1), and the rest of the games will be randomized
	--	SELECT @iteration = (SELECT CASE @games_in_conference WHEN 1 THEN 0 ELSE @games_in_conference / 2 END)

	--	--We need to use a loop to add these games in case there is more than one iteration
	--	SELECT @loop_id = 1
	--	WHILE @loop_id <= @iteration
	--	BEGIN
	--		--Add a home and away game against each opponent, for every opponent
	--		INSERT INTO matchup (home_team_id, away_team_id)
	--		SELECT 
	--			home_team_id = t.team_id
	--			,away_team_id = a.team_id
	--		FROM
	--			team t
	--			CROSS JOIN team a
	--		WHERE 
	--			t.team_id <> a.team_id
	--			AND t.conference_id = a.conference_id

	--		--Increment the loop
	--		SELECT @loop_id = @loop_id + 1
	--	END

	--	--If there are an odd number of in conference games to be assigned, we'll need to assign each team in the conference and equal number 
	--	--of home and away games against other conference opponents. If the number of opponents an odd number, we we assign half the conference an extra home game randomely.
	--	IF (@games_in_conference % 2) = 1
	--	BEGIN
	--		--Each team needs to have 1 more game scheduled against each team in conference, half home and half away
	--		--To do this we will take the same approach we did in the non-conference scheduling, utilizing @temp_matchup
	--		--and then randomizing the seeds after.  See the non-conference code for notes
	--		SELECT @loop_id = 1
	--		SELECT @sub_loop_id = 1
	--		SELECT @away_seed = -1

	--		WHILE @loop_id <= @teams_in_conference
	--		BEGIN
	--			SELECT @sub_loop_id = 1

	--			WHILE @sub_loop_id <= ((@teams_in_conference-1)/2) --The number of home games we need to schedule
	--			BEGIN
	--				SELECT @away_seed = (@loop_id + (@sub_loop_id))
	--				SELECT @away_seed = CASE WHEN @away_seed > @teams_in_conference THEN (@away_seed % @teams_in_conference) ELSE @away_seed END

	--				INSERT INTO @temp_matchup (home_seed, away_seed)
	--				SELECT @loop_id, @away_seed

	--				SELECT @sub_loop_id = @sub_loop_id + 1
	--			END

	--			SELECT @loop_id = @loop_id + 1
	--		END
			
	--		--If there are an odd number of oppponents to be assigned, we'll need to assign a home game to half of the conference.
	--		--(In order for there to be an odd number of random games, there must be an even number of teams)
	--		--NOTE-We only use the team table to insert into @home_seeds and @away_seeds because the team_IDs are in numerical order starting with one.
	--		--There is no connection between the seed_ids in @home_seeds and @away_seeds, and the team table, once the table variable are populated
	--		IF ((@teams_in_conference - 1) % 2) = 1
	--		BEGIN
	--			--Get all home seeds (We will take all even team_ids in the conference here to create some space in the sequences)
	--			DELETE FROM @home_seeds
	--			INSERT INTO @home_seeds (seed_id)
	--			SELECT team_id
	--			FROM team
	--			WHERE
	--				(team_id % 2) = 0
	--				AND team_id <= @teams_in_conference
			
	--			--Add remaining seeds to the away table
	--			DELETE FROM @away_seeds 
	--			INSERT INTO @away_seeds (seed_id)
	--			SELECT team_id
	--			FROM team
	--			WHERE 
	--				(team_id % 2) = 1
	--				AND team_id <= @teams_in_conference

	--			--Now let's go through each home seed and assign an available away seed.
	--			SELECT @loop_id = 1
	--			SELECT @away_seed = -1
	--			WHILE @loop_id <= (SELECT MAX(loop_id) FROM @home_seeds)
	--			BEGIN
	--				SELECT @away_seed = 
	--				(
	--					SELECT TOP 1 a.seed_id
	--					FROM 
	--						@home_seeds h
	--						CROSS JOIN @away_seeds a
	--						LEFT JOIN @temp_matchup m ON h.seed_id = m.home_seed
	--							AND m.away_seed = a.seed_id
	--					WHERE 
	--						h.loop_id = @loop_id
	--						AND m.away_seed IS NULL
	--					ORDER BY
	--						h.seed_id
	--						,a.seed_id
	--				)

	--				--remove the away seed from the available seeds as it now has a matchup
	--				DELETE FROM @away_seeds WHERE seed_id = @away_seed

	--				--Add the matchup to the table
	--				INSERT INTO @temp_matchup (home_seed, away_seed)
	--				SELECT 
	--					seed_id
	--					,@away_seed
	--				FROM @home_seeds
	--				WHERE loop_id = @loop_id

	--				--Increment Loop
	--				SELECT @loop_id = @loop_id + 1
	--			END		
	--		END


	--	END

	--	--Now get the list of teams in a random order, so we can apply it to the seeds in @temp_matchup
	--	DELETE FROM @temp_team
	--	INSERT INTO @temp_team 
	--	SELECT
	--		team_id 
	--		,seed_id = RANK() OVER (PARTITION BY conference_id ORDER BY newid()) --Random Order
	--	FROM team

	--	--Now Lets insert the games against random opponents
	--	INSERT INTO matchup (home_team_id, away_team_id)
	--	SELECT 
	--		htt.team_id
	--		,att.team_id
	--	FROM 
	--		@temp_matchup g
	--		INNER JOIN @temp_team htt ON g.home_seed = htt.seed_id
	--		INNER JOIN team ht ON htt.team_id = ht.team_id
	--		INNER JOIN @temp_team att ON g.away_seed = att.seed_id
	--		INNER JOIN team at ON att.team_id = at.team_id
	--	WHERE ht.conference_id = at.conference_id

	--	select @number_of_conferences
	--	--END IN CONFERENCE GAMES
	--	--START OUT OF CONFERENCE GAMES
	--	--Determine how many games there are left and how they are to be divied amongst the remaining teams
	--	SELECT @random_games = @number_of_games - ((@teams_in_conference - 1) * @games_in_conference)

	--	select @random_games

	--	--base = Determines the amount of times each team can play eachother
	--	SELECT @base = (SELECT @random_games / (@teams_in_conference * @number_of_conferences)) --since the variables are INTs we will get a whole number always rounded down

	--	select @base
	--	--END OUT OF CONFERENCE GAMES
	--END
END
