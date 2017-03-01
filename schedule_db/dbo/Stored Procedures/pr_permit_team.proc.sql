﻿CREATE PROCEDURE [dbo].[pr_permit_team] (@team_id INT)
AS 
BEGIN
		SELECT
			p.permit_id
			,p.permit_date
			,permit_date_desc = CONVERT(VARCHAR(10),p.permit_date,101)
			,permit_date_time = 
				CASE 
					WHEN DATEPART(HH,p.permit_date) = 0
					THEN '12'
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
				+' '+
				CASE 
					WHEN DATEPART(HH,p.permit_date) >= 12
					THEN 'PM'
					ELSE 'AM'
				END
			,p.field_id
			,f.field_name
		FROM 
			dbo.permit p
			INNER JOIN dbo.field f ON p.field_id = f.field_id
		WHERE p.home_team_id = @team_id
END