CREATE TABLE [dbo].[stg_matchup] (
    [matchup_id]   INT IDENTITY (1, 1) NOT NULL,
    [league_id]    INT NOT NULL,
    [stg_id]       INT NOT NULL,
    [home_team_id] INT NOT NULL,
    [away_team_id] INT DEFAULT ((-1)) NOT NULL,
    [permit_id]    INT DEFAULT ((-1)) NOT NULL
);



