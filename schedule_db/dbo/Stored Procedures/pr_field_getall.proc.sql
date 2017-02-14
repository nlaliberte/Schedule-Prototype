CREATE PROCEDURE [dbo].[pr_field_getall] (@include_unknown INT)
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
		UNION
		SELECT
			-1
			,''
			,''
			,''
			,''
			,''
			,''
			,''
		WHERE @include_unknown = 1
END