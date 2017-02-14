CREATE PROCEDURE [dbo].[pr_league_getall] 
AS 
BEGIN
	
	SELECT
		l.league_id
		,l.league_name
		,primary_contact = p.first_name + ' ' + ISNULL(p.last_name,'')
		,secondary_contact = s.first_name + ' ' + ISNULL(s.last_name,'')
	FROM 
		dbo.league l
		LEFT JOIN dbo.contact p ON l.primary_contact_id = p.contact_id
		LEFT JOIN dbo.contact s ON l.secondary_contact_id = s.contact_id
	ORDER BY l.league_id
END