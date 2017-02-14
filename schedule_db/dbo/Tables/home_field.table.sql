CREATE TABLE [dbo].[home_field] (
    [team_id]  INT NOT NULL,
    [field_id] INT NOT NULL,
    CONSTRAINT [pk_home_field] PRIMARY KEY CLUSTERED ([team_id] ASC, [field_id] ASC)
);

