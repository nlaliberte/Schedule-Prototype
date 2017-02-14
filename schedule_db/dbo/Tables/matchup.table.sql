CREATE TABLE [dbo].[matchup] (
    [league_id]    INT NOT NULL,
    [matchup_id]   INT IDENTITY (1, 1) NOT NULL,
    [home_team_id] INT NOT NULL,
    [away_team_id] INT DEFAULT ((-1)) NOT NULL,
    [permit_id]    INT DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [pk_matchup] PRIMARY KEY CLUSTERED ([league_id] ASC, [matchup_id] ASC, [home_team_id] ASC, [away_team_id] ASC, [permit_id] ASC)
);

