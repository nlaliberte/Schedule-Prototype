﻿CREATE PROCEDURE [dbo].[deploy_seed_team_off_day]
AS
BEGIN

	TRUNCATE TABLE dbo.team_off_day

	INSERT INTO dbo.team_off_day
	VALUES 
		(12, '06/23/2017')
		,(12, '06/24/2017')
		,(12, '06/25/2017')
		,(12, '06/29/2017')
		,(12, '06/30/2017')
		,(13, '05/13/2017')
		,(13, '08/04/2017')
		,(2, '05/14/2017')
		,(2, '06/10/2017')
		,(2, '06/16/2017')
		,(2, '06/17/2017')
		,(2, '06/18/2017')
		,(1, '05/14/2017')
		,(1, '06/30/2017')
		,(1, '06/02/2017')
		,(1, '06/10/2017')
		,(1, '07/17/2017')
		,(1, '08/05/2017')

END
