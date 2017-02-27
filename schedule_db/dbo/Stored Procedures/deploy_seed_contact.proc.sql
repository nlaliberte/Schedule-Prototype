
-- ===============================================
-- Author:		Nate Laliberte
-- Create date: 09/27/2012
-- Description:	Will insert existing league contacts into contact table as seed data
-- ===============================================
CREATE PROCEDURE [dbo].[deploy_seed_contact]
AS
BEGIN
	TRUNCATE TABLE dbo.contact

	INSERT INTO dbo.contact
	VALUES
		(1, 1, 'Dave', 'Treska', 'yblSchedule2015@gmail.com', NULL)
		,(2, 1,'Angelo', 'Colucci', 'redsoxpower2@yahoo.com', NULL)
		,(3, 1,'Nate', 'Laliberte', 'nathan.laliberte@gmail.com', '207-229-8489')
		,(4, 1,'Anthony', 'Bucciarelli', 'anthony.bucciarelli@gmail.com', NULL)
		,(5, 1,'Ben', 'Mendelson', 'benjamin.mendelson@gmail.com', NULL)
		,(6, 1,'Bernie', 'Driscoll', 'bdriscoll@bentley.edu', NULL)
		,(7, 1,'Brian', 'Mylett', 'bmylett@rcn.com', NULL)
		,(8, 1,'Brian', 'Rizzo', 'rizzo.brian@gmail.com', NULL)
		,(9, 1,'Cam', 'Lynch', 'camlynch@hotmail.com', NULL)
		,(10, 1,'Carl', 'Rodriguez', 'carlangel88@yahoo.com', NULL)
		,(11, 1,'Christopher', 'Deane', 'cdeano33@gmail.com', NULL)
		,(12, 1,'Dave', 'McKay', 'bostonbaseballhead@gmail.com', NULL)
		,(13, 1,'Devin', 'Santilli', 'devin.santilli@gmail.com', NULL)
		,(14, 1,'Eduardo', 'Lee', 'eduardolee@hotmail.com', NULL)
		,(15, 1,'Eric', 'Bellavia', 'ebellavia@yahoo.com', NULL)
		,(16, 1,'Geoff', 'Harris', 'geoffharris3434@yahoo.com', NULL)
		,(17, 1,'Jack', 'Owens', 'jkowensjr@gmail.com', NULL)
		,(18, 1,'Joe', 'O''Hara', 'joeohara@hotmail.com', NULL)
		,(19, 1,'John', 'Griffith', 'jlgrif26@comcast.net', NULL)
		,(20, 1,'John', 'Kostas', 'Al.Thomas.Baseball.Club@gmail.com', NULL)
		,(21, 1,'Jon', 'Tenney', 'jtenney2002@yahoo.com', NULL)
		,(22, 1,'Marc', 'Desroches', 'marc.desroches@comcast.net', NULL)
		,(23, 1,'Matt', 'Grimes', 'matthewgrimes@yahoo.com', NULL)
		,(24, 1,'Nick', 'Vennochi', 'nicholas.vennochi@gmail.com', NULL)
		,(25, 1,'Owen', 'Carlson', 'owencarlson@hotmail.com', NULL)
		,(26, 1,'Patrick', 'McGrath', 'pmcgrathnd@yahoo.com', NULL)
		,(27, 1,'Pete', 'Lankarge', 'pflankarge@gmail.com', NULL)
		,(28, 1,'Ted', 'Tracy', 'tt3120@yahoo.com', NULL)
		,(29, 1,'Travis', 'Adams', 'travis.adams0@gmail.com', NULL)
		,(30, 1,'John', 'Moore', 'jmoore1967@aol.com', NULL)
	
END

