CREATE TABLE [dbo].[league] (
    [league_id]                     INT           NOT NULL,
    [league_name]                   VARCHAR (255) NOT NULL,
    [number_of_teams]               INT           DEFAULT ((2)) NOT NULL,
    [number_of_games]               INT           DEFAULT ((1)) NOT NULL,
    [number_of_conferences]         INT           DEFAULT ((0)) NOT NULL,
    [number_of_games_in_conference] INT           DEFAULT ((0)) NOT NULL,
    [primary_contact_id]            INT           DEFAULT ((-1)) NOT NULL,
    [secondary_contact_id]          INT           DEFAULT ((-1)) NOT NULL,
    [pass]                          VARCHAR (25)  NOT NULL
);

