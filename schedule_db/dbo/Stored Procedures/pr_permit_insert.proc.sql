CREATE PROCEDURE [dbo].[pr_permit_insert] 
	(
		@league_id			INT	
		,@permit_date		VARCHAR(10)
		,@permit_time		VARCHAR(10)
		,@am_pm				VARCHAR(2)
		,@field_id			INT
		,@home_team_id		INT
		,@orig_home_team_id	INT
	)
AS
BEGIN
	
	DECLARE @permit_datetime DATETIME
	SELECT @permit_datetime = 
		CASE @am_pm
			WHEN 'AM' THEN CONVERT(DATETIME,@permit_date + ' ' + @permit_time)
			ELSE DATEADD(hh,12,CONVERT(DATETIME,@permit_date + ' ' + @permit_time))
		END
		
	--Insert the new contact into the table
	INSERT INTO dbo.permit
	VALUES 
		(
			@league_id
			,@permit_datetime
			,@field_id
			,@home_team_id
			,@orig_home_team_id
		)

END