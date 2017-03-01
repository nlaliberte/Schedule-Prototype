CREATE PROCEDURE [dbo].[pr_fixed_matchup_delete] (@fixed_matchup_id	INT)
AS 
BEGIN
	
	DELETE FROM dbo.fixed_matchup
	WHERE fixed_matchup_id = @fixed_matchup_id

END