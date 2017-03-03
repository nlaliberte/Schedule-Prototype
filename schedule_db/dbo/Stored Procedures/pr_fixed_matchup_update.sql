CREATE PROCEDURE [dbo].[pr_fixed_matchup_update]
(
	@fixed_matchup_id	INT
	,@league_id			INT
	,@home_team_id		INT
	,@away_team_id		INT
	,@field_id			INT 
	,@matchup_date		VARCHAR(10)
	,@matchup_time		VARCHAR(10)
	,@am_pm				VARCHAR(2)
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
				RAISERROR ('The home team has a permit at a different field on the same day',10, 1) 
			END

			IF EXISTS (SELECT permit_id FROM dbo.permit WHERE home_team_id = @home_team_id AND field_id <> @field_id AND DATEPART(DAY,permit_date) = DATEPART(DAY,@matchup_datetime) AND DATEPART(MONTH,permit_date) = DATEPART(MONTH,@matchup_datetime))
			BEGIN
				RAISERROR ('The away team has a permit at a different field on the same day',10, 1) 
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
	END

	UPDATE dbo.fixed_matchup
	SET
		home_team_id = @home_team_id
		,away_team_id = @away_team_id
		,permit_id = @permit_id
	WHERE fixed_matchup_id = @fixed_matchup_id

END