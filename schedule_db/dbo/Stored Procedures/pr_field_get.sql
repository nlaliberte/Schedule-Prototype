CREATE PROCEDURE [dbo].[pr_field_get] (@field_id	INT)
AS 
BEGIN
		
	SELECT 
		f.field_id
		,f.field_name
		,f.addr
		,f.addr_2
		,f.addr_3
		,f.city
		,f.state_code
		,f.zip
	FROM dbo.field f
	WHERE f.field_id = @field_id

END