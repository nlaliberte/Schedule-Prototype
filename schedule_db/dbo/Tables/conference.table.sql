CREATE TABLE [dbo].[conference] (
    [league_id]       INT           NOT NULL,
    [conference_id]   INT           NOT NULL,
    [conference_name] VARCHAR (255) NOT NULL,
    CONSTRAINT [pk_conference] PRIMARY KEY CLUSTERED ([league_id] ASC, [conference_id] ASC),
    CONSTRAINT [unq_conference_name] UNIQUE NONCLUSTERED ([league_id] ASC, [conference_name] ASC)
);

