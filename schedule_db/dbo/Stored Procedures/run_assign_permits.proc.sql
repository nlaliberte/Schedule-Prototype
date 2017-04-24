
-- ===============================================
-- Author:		Nate Laliberte
-- Create date: 09/27/2012
-- Description:	Assign permits for determined matchups
-- ===============================================
CREATE PROCEDURE [dbo].[run_assign_permits] 
	(
		@league_id	INT
		,@stg_id	INT
	)
AS
BEGIN
	--So now we have all the matchups and we need to assign permits to them.  To minimize orphaned matchups, we will constantly evaluate which matchups have available dates left
	--We will do this in a loop
	DECLARE @loop_id		INT = (SELECT MIN(matchup_id) FROM stg_matchup WHERE stg_id = @stg_id AND league_id = @league_id)
	DECLARE @max_loop_id	INT = (SELECT MAX(matchup_id) FROM stg_matchup WHERE stg_id = @stg_id AND league_id = @league_id)
	DECLARE @matchup_id		INT
	WHILE @loop_id <= @max_loop_id
	BEGIN

		SELECT @matchup_id = 
		(
			SELECT TOP 1 m.matchup_id
			FROM stg_matchup m
			WHERE 
				m.stg_id = @stg_id
				AND m.league_id = @league_id
				AND m.permit_id = -1
			--How many available dates are left where the away team doesn't have a game scheduled or a permit or a requested day off
			ORDER BY 
				(
					SELECT COUNT(1) 
					FROM stg_permit p 
					WHERE 
						p.stg_id = @stg_id 
						AND p.league_id = @league_id 
						AND p.home_team_id = m.home_team_id 
						AND NOT EXISTS (SELECT permit_id FROM stg_matchup WHERE stg_id = @stg_id AND league_id = @league_id AND permit_id = p.permit_id) 
						AND NOT EXISTS (SELECT permit_id FROM stg_permit WHERE stg_id = @stg_id and league_id = @league_id AND home_team_id = m.away_team_id AND MONTH(p.permit_date) = MONTH(permit_date) AND DAY(p.permit_date) = DAY(permit_date)) 
						AND NOT EXISTS (SELECT mt.matchup_id FROM stg_matchup mt INNER JOIN stg_permit pt ON mt.stg_id = pt.stg_id AND mt.league_id = pt.league_id AND mt.permit_id = pt.permit_id WHERE mt.stg_id = @stg_id AND mt.league_id = @league_id AND mt.away_team_id = m.away_team_id AND MONTH(pt.permit_date) = MONTH(p.permit_date) AND DAY(pt.permit_date) = DAY(p.permit_date))
						AND NOT EXISTS (SELECT team_id FROM team_off_day WHERE m.away_team_id = team_id AND MONTH(p.permit_date) = MONTH(off_day) AND DAY(p.permit_date) = DAY(off_day))
				)
				,newid()
		)

		--If No Matchups are left that can be scheduled, Break the loop
		IF @matchup_id IS NULL
			BREAK


		--Give the matchup a fitting permit
		UPDATE stg_matchup
		SET permit_id = ISNULL(
		(
			SELECT TOP 1
				p.permit_id
			FROM
				stg_matchup m
				INNER JOIN stg_permit p ON m.home_team_id = p.home_team_id 
					AND p.league_id = m.league_id
					AND p.stg_id = @stg_id
			WHERE 
				m.stg_id = @stg_id
				AND m.matchup_id = @matchup_id
				AND m.league_id = @league_id
				--Permit is already taken
				AND NOT EXISTS (SELECT permit_id FROM stg_matchup WHERE stg_id = @stg_id AND league_id = @league_id AND permit_id = p.permit_id)
				--Away team has permit on same day
				AND NOT EXISTS (SELECT permit_id FROM stg_permit WHERE stg_id = @stg_id AND league_id = @league_id AND home_team_id = m.away_team_id AND MONTH(p.permit_date) = MONTH(permit_date) AND DAY(p.permit_date) = DAY(permit_date))
				--Away team has game on same day
				AND NOT EXISTS (SELECT matchup_id FROM stg_matchup ma INNER JOIN stg_permit pe ON ma.permit_id = pe.permit_id AND pe.league_id = @league_id AND pe.stg_id = @stg_id WHERE ma.stg_id = @stg_id AND ma.league_id = @league_id AND ma.away_team_id = m.away_team_id AND ma.permit_id <> -1 AND MONTH(pe.permit_date) = MONTH(p.permit_date) AND DAY(pe.permit_date) = DAY(p.permit_date))
				--Away Team has requested day off
				AND NOT EXISTS (SELECT team_id FROM team_off_day WHERE m.away_team_id = team_id AND MONTH(off_day) = MONTH(p.permit_date) AND DAY(off_day) = DAY(p.permit_date))
			ORDER BY
				--Away Team's game already scheduled for the week + Away Team's permits within the week
				 (SELECT COUNT(1) FROM stg_matchup ma INNER JOIN stg_permit pe ON ma.permit_id = pe.permit_id AND pe.league_id = @league_id AND pe.stg_id = @stg_id WHERE ma.stg_id = @stg_id AND ma.league_id = @league_id AND ma.away_team_id = m.away_team_id AND ma.permit_id <> -1 AND pe.permit_date <= DATEADD(dd,4,p.permit_date) AND pe.permit_date >= DATEADD(dd,-4,p.permit_date))
				 + (SELECT COUNT(1) FROM stg_permit pe WHERE pe.stg_id = @stg_id AND pe.league_id = @league_id AND pe.home_team_id = m.away_team_id AND pe.permit_date <= DATEADD(dd,4,p.permit_date) AND pe.permit_date >= DATEADD(dd,-4,p.permit_date) AND NOT EXISTS (SELECT permit_id FROM stg_matchup WHERE stg_id = @stg_id AND league_id = @league_id AND permit_id = pe.permit_id))
				 ,newid()
		),-2)
		WHERE matchup_id = @matchup_id

		--Clear the @matchup_id
		SELECT @matchup_id = NULL

		--Increment the Loop
		SELECT @loop_id = @loop_id + 1
	END

	--Reset the Home Team for any permits that didn't get matchups.  We still have 'Orig_home_team' to see what team obtained the permit and use when scheduling makeups
	UPDATE p
	SET home_team_id = -1
	FROM 
		stg_permit p
		LEFT JOIN stg_matchup m ON p.permit_id = m.permit_id
			AND m.stg_id = @stg_id
			AND m.league_id = @league_id
	WHERE 
		p.stg_id = @stg_id
		AND p.league_id = @league_id
		AND m.matchup_id IS NULL

END

