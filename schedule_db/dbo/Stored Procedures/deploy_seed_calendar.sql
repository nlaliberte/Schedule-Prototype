CREATE PROCEDURE [dbo].[deploy_seed_calendar]
AS
BEGIN
	TRUNCATE TABLE dbo.calendar

	DECLARE @StartDate DATE = '20000101', @NumberOfYears INT = 30;

	-- prevent set or regional settings from interfering with 
	-- interpretation of dates / literals

	SET DATEFIRST 7;
	SET DATEFORMAT mdy;
	SET LANGUAGE US_ENGLISH;

	DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);

	INSERT INTO dbo.calendar
	SELECT d
	FROM
	(
	  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
	  FROM 
	  (
		SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
		  rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
		FROM sys.all_objects AS s1
		CROSS JOIN sys.all_objects AS s2
		-- on my system this would support > 5 million days
		ORDER BY s1.[object_id]
	  ) AS x
	) AS y
		
END