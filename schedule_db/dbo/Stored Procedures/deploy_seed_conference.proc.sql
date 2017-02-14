
CREATE PROCEDURE [dbo].[deploy_seed_conference]
AS
BEGIN

	INSERT INTO dbo.conference
	VALUES
		(1,1,'Ted Williams Division')
		,(1,2,'Carl Yastrzemski Division')
			
END

