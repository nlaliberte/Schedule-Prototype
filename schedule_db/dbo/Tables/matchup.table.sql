CREATE TABLE [dbo].[matchup] (
    [stg_id]       INT NOT NULL,
    [league_id]    INT NOT NULL,
    [matchup_id]   INT NOT NULL,
    [home_team_id] INT NOT NULL,
    [away_team_id] INT DEFAULT ((-1)) NOT NULL,
    [permit_id]    INT DEFAULT ((-1)) NOT NULL
);



