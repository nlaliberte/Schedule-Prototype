CREATE PROCEDURE [dbo].[pr_team_get] (@team_id INT)
AS 
BEGIN
	
	SELECT 
		t.team_id
		,t.team_name
		,t.conference_id
		,c.conference_name
		,t.contact_id
		,primary_contact = pc.first_name + ' ' + ISNULL(pc.last_name,'')
		,contact_id2 = ISNULL(t.contact_id2,-1)
		,secondary_contact = sc.first_name + ' ' + ISNULL(sc.last_name,'')
	FROM 
		dbo.team t
		INNER JOIN dbo.conference c ON t.conference_id = c.conference_id
		LEFT JOIN dbo.contact pc ON t.contact_id = pc.contact_id
		LEFT JOIN dbo.contact sc ON t.contact_id2 = sc.contact_id
	WHERE t.team_id = @team_id
	
END