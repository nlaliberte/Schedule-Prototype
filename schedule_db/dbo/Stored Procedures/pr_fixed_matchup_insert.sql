﻿CREATE PROCEDURE [dbo].[pr_fixed_matchup_insert]
(
	@league_id			INT
	,@home_team_id		INT
	,@away_team_id		INT
	,@field_id			INT = -1
	,@matchup_date		VARCHAR(10) = NULL
	,@matchup_time		VARCHAR(10) = NULL
	,@am_pm				VARCHAR(2) = NULL
)
AS 
BEGIN
	
	DECLARE @matchup_datetime DATETIME
	SELECT @matchup_datetime = 
		CASE 
			WHEN @matchup_time = '12:00' AND @am_pm = 'AM' THEN DATEADD(hh,-12,CONVERT(DATETIME,@matchup_date + ' ' + @matchup_time))
			WHEN @am_pm = 'AM' OR @matchup_time = '12:00' THEN CONVERT(DATETIME,@matchup_date + ' ' + @matchup_time)
			ELSE DATEADD(hh,12,CONVERT(DATETIME,@matchup_date + ' ' + @matchup_time))
		END

	DECLARE @permit_id INT = -1

	--If we have a field_id we need to check and see if there's a permit and create one if there isn't, else we'll insert the -1
	IF @field_id <> -1
	BEGIN
		--Check to see if the permit exists
		SELECT @permit_id = permit_id
		FROM dbo.permit
		WHERE 
			home_team_id = @home_team_id
			AND field_id = @field_id
			AND permit_date = @matchup_datetime

	
		--If this is a new permit, make sure the teams don't already have a permit on this day at another field
		IF @permit_id = -1
		BEGIN
			IF EXISTS (SELECT permit_id FROM dbo.permit WHERE home_team_id = @home_team_id AND field_id <> @field_id AND DATEPART(DAY,permit_date) = DATEPART(DAY,@matchup_datetime) AND DATEPART(MONTH,permit_date) = DATEPART(MONTH,@matchup_datetime))
			BEGIN
				RAISERROR ('The home team has a permit at a different field on the same day',18, 1) 
				RETURN
			END

			IF EXISTS (SELECT permit_id FROM dbo.permit WHERE home_team_id = @away_team_id AND DATEPART(DAY,permit_date) = DATEPART(DAY,@matchup_datetime) AND DATEPART(MONTH,permit_date) = DATEPART(MONTH,@matchup_datetime))
			BEGIN
				RAISERROR ('The away team has a permit at a different field on the same day',18, 1) 
				RETURN
			END

			--Create a new permit
			EXEC dbo.pr_permit_insert @league_id, @matchup_date, @matchup_time, @am_pm, @field_id, @home_team_id, @home_team_id

			--Fetch the Permit_id
			SELECT @permit_id = permit_id
			FROM dbo.permit
			WHERE 
				home_team_id = @home_team_id
				AND field_id = @field_id
				AND permit_date = @matchup_datetime

		END

		--Still check to make sure the away team doesn't have a permit on this day even if a field isnt' selected
		IF 
			(
				@matchup_date IS NOT NULL 
				AND @matchup_time IS NOT NULL 
				AND EXISTS (SELECT permit_id FROM dbo.permit WHERE home_team_id = @away_team_id AND DATEPART(DAY,permit_date) = DATEPART(DAY,@matchup_datetime) AND DATEPART(MONTH,permit_date) = DATEPART(MONTH,@matchup_datetime))
			)
		BEGIN
			RAISERROR ('The away team has a permit at a different field on the same day',18, 1) 
		END

	END


	--Now insert the Matchup Record
	INSERT INTO dbo.fixed_matchup
	(
		league_id
		,home_team_id
		,away_team_id
		,permit_id
	)
	SELECT
		@league_id
		,@home_team_id
		,@away_team_id
		,@permit_id

END