CREATE PROCEDURE [dbo].[pr_off_day_insert] 
	(
		@team_id		INT	
		,@off_day		VARCHAR(10)
	)
AS
BEGIN
	
	DECLARE @off_datetime DATETIME
	SELECT @off_datetime = CONVERT(DATETIME,@off_day)
		
	--Insert the new contact into the table
	INSERT INTO dbo.team_off_day
	VALUES 
		(
			@team_id
			,@off_datetime
		)

END