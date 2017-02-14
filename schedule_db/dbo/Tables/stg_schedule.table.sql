CREATE TABLE [dbo].[stg_schedule] (
    [stg_id]    INT IDENTITY (1, 1) NOT NULL,
    [league_id] INT NOT NULL,
    [stat1]     INT NULL,
    [stat2]     INT NULL,
    [stat3]     INT NULL,
    CONSTRAINT [pk_stg_schedule] PRIMARY KEY CLUSTERED ([stg_id] ASC, [league_id] ASC)
);

