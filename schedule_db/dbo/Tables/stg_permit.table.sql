CREATE TABLE [dbo].[stg_permit] (
    [permit_id]         INT      NOT NULL,
    [stg_id]            INT      NOT NULL,
    [league_id]         INT      NOT NULL,
    [permit_date]       DATETIME NOT NULL,
    [field_id]          INT      NOT NULL,
    [home_team_id]      INT      DEFAULT ((-1)) NOT NULL,
    [orig_home_team_id] INT      DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [pk_stg_permit] PRIMARY KEY CLUSTERED ([permit_id] ASC, [stg_id] ASC)
);

