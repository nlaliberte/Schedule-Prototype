CREATE PROCEDURE [dbo].[pr_off_day_delete] 
	(
		@team_id		INT	
		,@off_day		VARCHAR(10)
	)
AS
BEGIN
	
	DECLARE @off_datetime DATETIME
	SELECT @off_datetime = CONVERT(DATETIME,@off_day)
		
	--Insert the new contact into the table
	DELETE FROM dbo.team_off_day
	WHERE 
		team_id = @team_id
		AND off_day = @off_datetime
		

END