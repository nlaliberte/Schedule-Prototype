USE [schedule]
GO
/****** Object:  StoredProcedure [dbo].[sch_stg_select]    Script Date: 2/23/2017 3:27:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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