﻿CREATE TABLE [dbo].[fixed_matchup] (
    [fixed_matchup_id] INT IDENTITY (1, 1) NOT NULL,
    [league_id]        INT NOT NULL,
    [home_team_id]     INT NOT NULL,
    [away_team_id]     INT NOT NULL,
    [permit_id]        INT NOT NULL
);





