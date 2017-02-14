
--Now let's add current Teams with their initial contact info.
CREATE PROCEDURE [dbo].[deploy_seed_team]
AS
BEGIN

	INSERT INTO dbo.team
	VALUES
		(1, 'AlThomas Athletics', 1, 20, 18)
		,(2, 'Brighton Black Sox', 2, 19, NULL)
		,(3, 'Brighton Braves', 2, 28, 27)
		,(4, 'Charlestown Townies', 2, 13, NULL)
		,(5, 'East Boston Knights', 1, 15, NULL)
		,(6, 'Malden Maddogs', 2, 2, NULL)
		,(7, 'McKay Club Beacons', 1, 12, 17)
		,(8, 'Revere Rockies', 2, 3, 4)
		,(9, 'Savin Hill Dodgers', 1, 8, NULL)
		,(10, 'Somerville Alibrandis', 2, 6, 9)
		,(11, 'South Boston Saints', 1, 21, NULL)
		,(12, 'South End Astros', 1, 10, 11)
		,(13, 'Stoneham Sabers', 2, 2, 29)
		
END

