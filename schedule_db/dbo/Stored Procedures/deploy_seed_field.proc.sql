
--Let's add some current fields
CREATE PROCEDURE [dbo].[deploy_seed_field]
AS
BEGIN

	INSERT INTO dbo.field
	VALUES
		(1,'Braintree High School', '128 Town Street', NULL, NULL, 'Braintree', 'MA', '02184')
		,(2,'Brandeis University', '415 South Street', NULL, NULL, 'Waltham', 'MA', '02453')
		,(3,'East Boston Stadium', 'Porter St. & Orleans St.', NULL, NULL, 'East Boston', 'MA', '02228')
		,(4,'Jim Rice Field', 'Washington St. & Shawmut Ave.', NULL, NULL, 'Roxbury', 'MA', '02118')
		,(5,'Maplewood Field', 'Crystal St. & Maplewood St.', NULL, NULL, 'Malden', 'MA', '02148')
		,(6,'McConnell Park', 'Springdale St. & Denny St.', NULL, NULL, 'Dorchester', 'MA', '02125')
		,(7,'Recreation Park', '51 Gerry Court', NULL, NULL, 'Stoneham', 'MA', '02180')
		,(8,'Revere High School', 'Beach St. & School St.', NULL, NULL, 'Revere', 'MA', '02151')
		,(9,'Rogers Park', 'Lake St. & Foster St.', NULL, NULL, 'Brighton', 'MA', '02135')
		,(10,'Ronan Park', 'Mount Ida Rd. & Robinston St.', NULL, NULL, 'Dorchester', 'MA', '02122')
		,(11,'Ryan Playground', '529 Main St.', NULL, NULL, 'Charlestown', 'MA', '02129')
		,(12,'Trum Field', '560 Broadway Ave.', NULL, NULL, 'Somerville', 'MA', '02145')
		,(13,'Healy Field', 'Washington St. & Firth Rd.', NULL, NULL, 'Roslindale', 'MA', '02131')
		,(14,'English High School', '144 McBride St.', NULL, NULL, 'Jamaica Plain', 'MA', '02130')
		,(15,'Ross Field', 'Reddy Ave.', NULL, NULL, 'Hyde Park', 'MA', '02136')
		,(16,'St. Peter''s Field', '99 Sherman St.', NULL, NULL, 'Cambridge', 'MA', '02138')
		,(17,'Cunningham Park', 'Adams St. & Edge Hill Rd.', NULL, NULL, 'Milton', 'MA', '02186')
		,(18,'Cleveland Circle', '2100 Beacon St.', NULL, NULL, 'Brighton', 'MA', '02135')
	
END

