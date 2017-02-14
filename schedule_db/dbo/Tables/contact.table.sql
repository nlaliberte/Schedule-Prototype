CREATE TABLE [dbo].[contact] (
    [contact_id] INT           NOT NULL,
    [league_id]  INT           NOT NULL,
    [first_name] VARCHAR (255) NOT NULL,
    [last_name]  VARCHAR (255) NOT NULL,
    [email]      VARCHAR (500) NULL,
    [phone]      VARCHAR (12)  NULL,
    CONSTRAINT [pk_contact] PRIMARY KEY CLUSTERED ([contact_id] ASC, [first_name] ASC, [last_name] ASC)
);

