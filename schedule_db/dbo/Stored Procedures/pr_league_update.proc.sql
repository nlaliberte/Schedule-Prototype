CREATE PROCEDURE [dbo].[pr_league_update] 
	(
		@league_id							INT
		,@league_name						VARCHAR(255)	
		,@number_of_teams					INT	= 1
		,@number_of_games					INT	= 1
		,@number_of_conferences				INT	= 1
		,@number_of_games_in_conference		INT = 1
		,@primary_contact_id				INT = 1
		,@secondary_contact_id				INT = 1
	)
AS
BEGIN

	--Insert the new contact into the table
	UPDATE dbo.league
	SET 
		league_name = @league_name
		,number_of_teams = @number_of_teams
		,number_of_games = @number_of_games
		,number_of_conferences = @number_of_conferences
		,number_of_games_in_conference = @number_of_games_in_conference
		,primary_contact_id = @primary_contact_id
		,secondary_contact_id = @secondary_contact_id
	WHERE league_id = @league_id

END