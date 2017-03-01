CREATE PROCEDURE [dbo].[pr_permit_update] 
	(
		@permit_id			INT
		,@league_id			INT	
		,@permit_date		VARCHAR(10)
		,@permit_time		VARCHAR(10)
		,@am_pm				VARCHAR(2)
		,@field_id			INT
		,@home_team_id		INT
	)
AS
BEGIN
	
	DECLARE @permit_datetime DATETIME
	SELECT @permit_datetime = 
		CASE 
			WHEN @permit_time = '12:00' AND @am_pm = 'AM' THEN DATEADD(hh,-12,CONVERT(DATETIME,@permit_date + ' ' + @permit_time))
			WHEN @am_pm = 'AM' OR @permit_time = '12:00' THEN CONVERT(DATETIME,@permit_date + ' ' + @permit_time)
			ELSE DATEADD(hh,12,CONVERT(DATETIME,@permit_date + ' ' + @permit_time))
		END
		
	UPDATE dbo.permit
	SET
		league_id = @league_id
		,permit_date = @permit_datetime
		,field_id = @field_id
		,home_team_id = @home_team_id
		,orig_home_team_id = @home_team_id
	WHERE permit_id = @permit_id

END