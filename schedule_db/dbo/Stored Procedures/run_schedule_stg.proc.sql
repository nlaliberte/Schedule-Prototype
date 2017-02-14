

---- ===============================================
---- Author:		Nate Laliberte
---- Create date:   01/31/2012
---- Description:	Will clear out existing matchup data and create new matchups based on inputted league format
---- ===============================================
CREATE PROCEDURE [dbo].[run_schedule_stg] 
	(
		@league_id		INT
		,@iterations	INT
	)
AS
BEGIN
	--Clear out the staging tables from previous runs
	DELETE FROM stg_permit
	WHERE league_id = @league_id
	
	DELETE FROM stg_matchup
	WHERE league_id = @league_id
	
	
	--Iterate the Schedule Creation process for the amount of iterations specified
	DECLARE @stg_id INT = 1
	WHILE @stg_id <= @iterations
	BEGIN
		--Populates the stg_permits table for the run
		INSERT INTO dbo.stg_permit
		(
			permit_id
			,stg_id
			,league_id
			,permit_date
			,field_id
			,home_team_id
			,orig_home_team_id
		)
		SELECT
			p.permit_id
			,@stg_id
			,@league_id
			,p.permit_date
			,p.field_id
			,p.home_team_id
			,p.orig_home_team_id
		FROM dbo.permit p
		WHERE p.league_id = @league_id
		
		--Assign open permits to Home Teams
		EXEC [dbo].[run_assign_home_permits] 1, 1--@stg_id
		
		--Create the Matchups
		EXEC [dbo].[run_create_matchups] 1, 1--@stg_id

		--Assign Permits to the Matchups
		EXEC [dbo].[run_assign_permits] 1, @stg_id
		
		--Collect Stats
		INSERT INTO dbo.stg_schedule
		(
			league_id
			,stg_id
		)
		SELECT 
			@league_id
			,@stg_id
			
		--Increment the Loop
		SELECT @stg_id = @stg_id + 1	
	
	END
END

