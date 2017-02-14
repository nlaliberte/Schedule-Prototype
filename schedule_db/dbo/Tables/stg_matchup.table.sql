CREATE TABLE [dbo].[stg_matchup] (
    [league_id]    INT NOT NULL,
    [stg_id]       INT NOT NULL,
    [matchup_id]   INT NOT NULL,
    [home_team_id] INT NOT NULL,
    [away_team_id] INT DEFAULT ((-1)) NOT NULL,
    [permit_id]    INT DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [pk_stg_matchup] PRIMARY KEY CLUSTERED ([league_id] ASC, [matchup_id] ASC, [stg_id] ASC)
);

