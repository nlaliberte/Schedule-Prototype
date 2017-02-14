CREATE TABLE [dbo].[permit] (
    [permit_id]         INT      IDENTITY (1, 1) NOT NULL,
    [league_id]         INT      NOT NULL,
    [permit_date]       DATETIME NOT NULL,
    [field_id]          INT      NOT NULL,
    [home_team_id]      INT      DEFAULT ((-1)) NOT NULL,
    [orig_home_team_id] INT      DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [pk_permit] PRIMARY KEY CLUSTERED ([permit_id] ASC),
    CONSTRAINT [unq_permit_date_field] UNIQUE NONCLUSTERED ([permit_date] ASC, [field_id] ASC)
);

