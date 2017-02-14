CREATE PROCEDURE [dbo].[pr_league_get] (@league_id INT) 
AS 
BEGIN
	
	SELECT
		l.league_id
		,l.league_name
		,number_of_teams = (SELECT COUNT(1) FROM dbo.team t INNER JOIN dbo.conference c ON t.conference_id = c.conference_id AND c.league_id = @league_id)
		,l.number_of_games
		,number_of_permits = (SELECT COUNT(1) FROM dbo.permit WHERE league_id = @league_id)
		,minimum_number_of_permits = CONVERT(INT,ROUND(CONVERT(DECIMAL(5,2),l.number_of_games) * CONVERT(DECIMAL(5,2),l.number_of_teams) / 2,0))
		,l.number_of_conferences
		,l.number_of_games_in_conference
		,l.primary_contact_id
		,primary_contact = p.first_name + ' ' + ISNULL(p.last_name,'')
		,primary_contact_phone = p.phone
		,primary_contact_email = p.email
		,l.secondary_contact_id
		,secondary_contact = s.first_name + ' ' + ISNULL(s.last_name,'')
		,secondary_contact_phone = s.phone
		,secondary_contact_email = s.email
	FROM 
		dbo.league l
		LEFT JOIN dbo.contact p ON l.primary_contact_id = p.contact_id
		LEFT JOIN dbo.contact s ON l.secondary_contact_id = s.contact_id
	WHERE l.league_id = @league_id	
END