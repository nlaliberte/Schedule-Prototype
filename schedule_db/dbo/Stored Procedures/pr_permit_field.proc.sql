CREATE PROCEDURE [dbo].[pr_permit_field] (@league_id INT, @field_id INT)
AS 
BEGIN
		SELECT
			p.permit_id
			,p.permit_date
			,permit_date_desc = CONVERT(VARCHAR(10),p.permit_date,101)
			,permit_date_time = 
				CASE 
					WHEN DATEPART(HH,p.permit_date) > 12 
					THEN CONVERT(VARCHAR(2),DATEPART(HH,p.permit_date)-12)
					ELSE CONVERT(VARCHAR(2),DATEPART(HH,p.permit_date))
				END 
				+':'+
				CASE 
					WHEN DATEPART(MINUTE,p.permit_date) = 0
					THEN '00'
					ELSE CONVERT(VARCHAR(2),DATEPART(MINUTE,p.permit_date))
				END
			,p.home_team_id
			,team_name = ISNULL(t.team_name,'League')
		FROM 
			dbo.permit p
			LEFT JOIN dbo.team t ON p.home_team_id = t.team_id
		WHERE 
			p.league_id = @league_id
			AND p.field_id = @field_id
END