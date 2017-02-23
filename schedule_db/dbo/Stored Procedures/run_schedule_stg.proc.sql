
-- ===============================================
-- Author:		Nate Laliberte
-- Create date:   01/31/2012
-- Description:	Will clear out existing matchup data and create new matchups based on inputted league format
---- ===============================================
CREATE PROCEDURE [dbo].[run_schedule_stg] 
	(
		@league_id		INT
		,@iterations	INT
		,@new_run		INT
	)
AS
BEGIN
	
	DECLARE @session_start DATETIME = GETDATE()
	
	--If new run than clear out old runds
	IF @new_run = 1
	BEGIN
		--Clear out the staging tables from previous runs
		DELETE FROM stg_permit
		WHERE league_id = @league_id
		
		DELETE FROM stg_matchup
		WHERE league_id = @league_id
		
		DELETE FROM stg_stats
		WHERE league_id = @league_id
	END
	
	--Iterate the Schedule Creation process for the amount of iterations specified
	DECLARE @stg_id INT = ISNULL((SELECT MAX(stg_id) FROM stg_stats WHERE league_id = @league_id),0) + 1
	DECLARE @end_stg_id INT = @stg_id + @iterations - 1
	
	WHILE @stg_id <= @end_stg_id
	BEGIN
		--Reset permits to their original home teams in case we have run this before
		UPDATE dbo.permit
		SET home_team_id = orig_home_team_id
		WHERE league_id = @league_id	
			
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
		EXEC [dbo].[run_assign_home_permits] @league_id, @stg_id
				
		--Create the Matchups
		EXEC [dbo].[run_create_matchups] @league_id, @stg_id

		--Assign Permits to the Matchups
		EXEC [dbo].[run_assign_permits] @league_id, @stg_id
		
		----Collect Stats
		EXEC [dbo].[run_log_stg_stats] @league_id, @stg_id, @session_start
			
		----Increment the Loop
		SELECT @stg_id = @stg_id + 1	
	
		select GETDATE()
	END
	
	
END

