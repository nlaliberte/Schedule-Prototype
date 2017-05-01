CREATE PROCEDURE [dbo].[deploy_seed_fixed_matchup]
AS
BEGIN

	TRUNCATE TABLE fixed_matchup

	INSERT INTO fixed_matchup
	VALUES
		(1, 1, 7, 2)
		,(1, 7, 1, 24)
		,(1, 8, 2, 131)

END

