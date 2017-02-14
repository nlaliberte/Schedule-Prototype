CREATE TABLE [dbo].[team] (
    [team_id]       INT           NOT NULL,
    [team_name]     VARCHAR (255) NOT NULL,
    [conference_id] INT           NOT NULL,
    [contact_id]    INT           NOT NULL,
    [contact_id2]   INT           NULL,
    CONSTRAINT [pk_team] PRIMARY KEY CLUSTERED ([team_id] ASC)
);

