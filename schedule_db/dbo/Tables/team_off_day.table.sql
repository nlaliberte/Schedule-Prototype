CREATE TABLE [dbo].[team_off_day] (
    [team_id] INT      NOT NULL,
    [off_day] DATETIME NOT NULL,
    CONSTRAINT [pk_off_day] PRIMARY KEY CLUSTERED ([team_id] ASC, [off_day] ASC)
);

