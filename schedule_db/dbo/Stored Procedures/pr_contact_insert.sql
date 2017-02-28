﻿CREATE PROCEDURE [dbo].[pr_contact_insert]
	(
		@contact_id		INT
		,@league_id		INT
		,@first_name	VARCHAR(255)
		,@last_name		VARCHAR(255)
		,@phone			VARCHAR(12)
		,@email			VARCHAR(500)
	)
AS 
BEGIN
	
	INSERT INTO dbo.contact
	SELECT
		@contact_id
		,@league_id
		,@first_name
		,@last_name
		,@phone
		,@email
		
END