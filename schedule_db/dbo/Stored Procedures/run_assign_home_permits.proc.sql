-- ===============================================
-- Author:		Nate Laliberte
-- Create date: 09/27/2012
-- Description:	Will assign outstanding permits to teams
-- ===============================================
CREATE PROCEDURE [dbo].[run_assign_home_permits] 
	(
		@league_id	INT
		,@stg_id	INT
	)
AS
BEGIN

	--Before Creating matchups we have to make sure there are at least 16 permits assigned to all teams.  Once each team has 16 we will assign the rest of the outstanding permits
	--to teams via the home_teams table.  Having more than 16 available dates will make it easier on the scheduling proc.
	DECLARE @home_team_id	INT
	DECLARE @permit_id	INT

	DECLARE @loop_status INT = 0

	WHILE @loop_status = 0
	BEGIN
		
		--UPDATE stg_permit
		--SET home_team_id = orig_home_team_id
		--WHERE 
		--	stg_id = @stg_id
		--	AND league_id = @league_id
		
		WHILE EXISTS 
		(
			SELECT home_team_id
			FROM 
				stg_permit
			WHERE 
				stg_id = @stg_id
				AND home_team_id <> -1
				AND league_id = @league_id
			GROUP BY home_team_id
			HAVING COUNT(1) < 16
		) 
		BEGIN
			--Clear out the @home_team_id and @permit_id variables
			SELECT 
				@home_team_id = NULL
				,@permit_id = NULL

			--Get the first team we'll schedule a permit for, this will be the team with the fewest games schedule
			SELECT @home_team_id = 
				(
					SELECT TOP 1 home_team_id
					FROM stg_permit
					WHERE 
						stg_id = @stg_id
						AND home_team_id <> -1
						AND league_id = @league_id
					GROUP BY home_team_id
					HAVING COUNT(1) < 16
					ORDER BY 
						COUNT(1)
						,NEWID()
				)

			--Assign the team the earliest available permit from a home_field, where the team has the fewest games in the week of the permit
			SELECT @permit_id = 
			(
				SELECT TOP 1
					p.permit_id
				FROM 
					home_field h
					INNER JOIN stg_permit p ON p.stg_id = @stg_id
						AND h.field_id = p.field_id
						AND p.home_team_id = -1
						AND p.league_id = @league_id
					LEFT JOIN stg_permit pl ON pl.stg_id = @stg_id
						AND h.team_id = pl.home_team_id	
						AND pl.permit_date > DATEADD(dd,-3,p.permit_date)
						AND pl.permit_date < DATEADD(dd,3,p.permit_date)
						AND pl.league_id = @league_id
				WHERE 
					h.team_id = @home_team_id
					--Make sure the team doesn't already have a permit on this day
					AND NOT EXISTS (SELECT home_team_id FROM stg_permit WHERE stg_id = @stg_id AND home_team_id = @home_team_id AND DATEPART(dd,permit_date) = DATEPART(dd,p.permit_date) AND DATEPART(mm,permit_date) = DATEPART(mm,p.permit_date))
					--Make sure the team hasn't requested an off day on this day
					AND NOT EXISTS (SELECT team_id FROM team_off_day WHERE team_id = @home_team_id AND DATEPART(dd,off_day) = DATEPART(dd,p.permit_date) AND DATEPART(mm,off_day) = DATEPART(mm,p.permit_date))
				GROUP BY
					p.permit_id
					,p.permit_date
				ORDER BY
					COUNT(pl.permit_date)
					,p.permit_date
					,NEWID()
			)
			
			--If permit can still not be found ,assign the team the earliest available permit for any field, where the team has the fewest games in the week of the permit
			IF @permit_id IS NULL
			BEGIN
				SELECT @permit_id = 
				(
					SELECT TOP 1
						p.permit_id
					FROM 
						stg_permit p
						LEFT JOIN stg_permit pl ON p.stg_id = pl.stg_id
							AND pl.permit_date > DATEADD(dd,-3,p.permit_date)
							AND pl.permit_date < DATEADD(dd,3,p.permit_date)
							AND pl.home_team_id = @home_team_id
							AND pl.league_id = @league_id
					WHERE 
						p.stg_id = @stg_id
						AND p.home_team_id = -1
						AND p.league_id = @league_id
						--Make sure the team doesn't already have a permit on this day
						AND NOT EXISTS (SELECT home_team_id FROM stg_permit WHERE stg_id = @stg_id AND league_id = @league_id AND home_team_id = @home_team_id AND DATEPART(dd,permit_date) = DATEPART(dd,p.permit_date) AND DATEPART(mm,permit_date) = DATEPART(mm,p.permit_date))
						--Make sure the team hasn't requested an off day on this day
						AND NOT EXISTS (SELECT team_id FROM team_off_day WHERE team_id = @home_team_id AND DATEPART(dd,off_day) = DATEPART(dd,p.permit_date) AND DATEPART(mm,off_day) = DATEPART(mm,p.permit_date))
					GROUP BY
						p.permit_id
						,p.permit_date
					ORDER BY
						COUNT(pl.permit_date)
						,p.permit_date
						,NEWID()
				)
			END

			IF ISNULL(@permit_id,-1) = -1
				BREAK

			--Set the home_team_id for the permit
			UPDATE p
			SET home_team_id = @home_team_id
			FROM stg_permit p
			WHERE 
				p.stg_id = @stg_id
				AND p.permit_id = @permit_id
				AND p.league_id = @league_id

		END
		--DEBUG
		----Teams with multiple home games on the same date
		--SELECT 
		--	loop_check = p.home_team_id
		--	,p.permit_date
		--	,COUNT(1)
		--FROM permit p 
		--GROUP BY 
		--	p.home_team_id
		--	,p.permit_date
		--HAVING COUNT(1) > 1

		--Now assign remaining permits to teams who have a 'Home Field' at the Permit's field.
		WHILE EXISTS
		(
			SELECT permit_id
			FROM stg_permit
			WHERE 
				stg_id = @stg_id
				AND home_team_id = -1
				AND league_id = @league_id
		)
		BEGIN
			SELECT 
				@permit_id = NULL
				,@home_team_id = NULL

			--Get the next permit to assign
			SELECT @permit_id = 
			(
				SELECT TOP 1 permit_id
				FROM stg_permit
				WHERE 
					stg_id = @stg_id
					AND home_team_id = -1
					AND league_id = @league_id
				ORDER BY 
					permit_date
					,field_id
			)

			--Get the eligible home team with the fewest home permits.  In the event of ties, choose randomly (NewID())
			SELECT @home_team_id = 
			(
				SELECT TOP 1
					h.team_id
				FROM 
					stg_permit p
					INNER JOIN home_field h ON p.field_id = h.field_id
					INNER JOIN stg_permit ph ON h.team_id = ph.home_team_id
						AND ph.league_id = @league_id
						AND ph.stg_id = @stg_id
				WHERE 
					p.stg_id = @stg_id
					AND p.permit_id = @permit_id
					--Make sure the team doesn't already have a permit on this day
					AND NOT EXISTS (SELECT home_team_id FROM stg_permit WHERE stg_id = @stg_id AND league_id = @league_id AND home_team_id = h.team_id AND DATEPART(dd,permit_date) = DATEPART(dd,p.permit_date) AND DATEPART(mm,permit_date) = DATEPART(mm,p.permit_date))
					--Make sure the team hasn't requested an off day on this day
					AND NOT EXISTS (SELECT team_id FROM team_off_day WHERE team_id = h.team_id AND DATEPART(dd,off_day) = DATEPART(dd,p.permit_date) AND DATEPART(mm,off_day) = DATEPART(mm,p.permit_date))
				GROUP BY 
					p.permit_id
					,h.team_id
				ORDER BY 
					COUNT(1)
					,NEWID()
			)

			IF ISNULL(@permit_id,-1) = -1
				BREAK

			--Set the home_team_id for the permit
			UPDATE p
			SET home_team_id = ISNULL(@home_team_id,-1)
			FROM stg_permit p
			WHERE 
				p.stg_id = @stg_id 
				AND p.permit_id = @permit_id
				AND p.league_id = @league_id
		END
			
		IF NOT EXISTS --Teams with multiple home games on the same date
		(
			SELECT p.home_team_id
			FROM stg_permit p 
			WHERE p.stg_id = @stg_id
			GROUP BY 
				p.home_team_id
				,CONVERT(VARCHAR(2),DATEPART(mm,p.permit_date)) + '/' + CONVERT(VARCHAR(2),DATEPART(dd,p.permit_date))
			HAVING COUNT(1) > 1
		)
		BEGIN
			SELECT @loop_status = 1
		END
	END
END

