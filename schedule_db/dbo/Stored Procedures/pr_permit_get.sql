CREATE PROCEDURE [dbo].[pr_permit_get] (@permit_id	INT)
AS
BEGIN
	
	SELECT 
		f.field_id
		,f.field_name
		,permit_date = CONVERT(VARCHAR(10),p.permit_date,101)
		,permit_time = 
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
		,permit_ampm = CASE WHEN DATEPART(HH,p.permit_date) > 12 THEN 'AM' ELSE 'PM' END
		,t.team_id
		,t.team_name
	FROM 
		dbo.permit p
		INNER JOIN dbo.field f ON p.field_id = f.field_id
		LEFT JOIN dbo.team t ON p.orig_home_team_id = t.team_id
	WHERE p.permit_id = @permit_id

END