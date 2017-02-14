CREATE TABLE [dbo].[field] (
    [field_id]   INT           NOT NULL,
    [field_name] VARCHAR (255) NOT NULL,
    [addr]       VARCHAR (255) NOT NULL,
    [addr_2]     VARCHAR (255) NULL,
    [addr_3]     VARCHAR (255) NULL,
    [city]       VARCHAR (255) NOT NULL,
    [state_code] VARCHAR (2)   NOT NULL,
    [zip]        VARCHAR (5)   NOT NULL,
    CONSTRAINT [pk_field] PRIMARY KEY CLUSTERED ([field_id] ASC, [field_name] ASC)
);

