CREATE PROCEDURE [dbo].[pr_team_getall] (@league_id INT, @include_unknown INT)
AS 
BEGIN
	
		SELECT
			x.team_id
			,x.team_name
			,x.conference_id
			,x.conference_name
		FROM
		(
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
		) x
		ORDER BY
			CASE
				WHEN x.team_id > 0 THEN 0
				ELSE x.team_id
			END
			,x.team_name
END