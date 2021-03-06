CREATE PROCEDURE [dbo].[sch_stg_delete] (@league_id INT, @stg_id INT) 
AS 
BEGIN

	DELETE FROM dbo.stg_stats
	WHERE 
		league_id = @league_id
		AND stg_id = @stg_id
	
	DELETE FROM dbo.stg_permit 
	WHERE
		league_id = @league_id
		AND stg_id = @stg_id

	DELETE FROM dbo.stg_matchup
	WHERE
		league_id = @league_id
		AND stg_id = @stg_id

END