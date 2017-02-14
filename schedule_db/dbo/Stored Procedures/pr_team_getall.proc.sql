CREATE PROCEDURE [dbo].[pr_team_getall] (@league_id INT, @include_unknown INT)
AS 
BEGIN
	
		SELECT 
			t.team_id
			,t.team_name
			,c.conference_id
			,c.conference_name
		FROM
			dbo.team t
			INNER JOIN dbo.conference c ON t.conference_id = c.conference_id
		WHERE c.league_id = @league_id
		UNION
		SELECT
			-1
			,'League'
			,-1
			,''
		WHERE @include_unknown IN (1,2)
		UNION
		SELECT
			-2
			,''
			,-1
			,''
		WHERE @include_unknown = 2
END