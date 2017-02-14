
CREATE PROCEDURE [dbo].[deploy_seed_home_field]
AS
BEGIN
	INSERT INTO dbo.home_field
	VALUES
		(1, 1) --Al Thomas, Braintree High
		,(1,2) --Al Thomas, Brandies
		,(1,9) --Al Thomas, Rogers
		,(1, 13) --Al Thomas, Healy
		,(1,15) --Al Thomas, Ross
		,(1,17) --Al Thomas, Cunningham
		,(2,2) --Black Sox, Brandies
		,(2,9) --Black Sox, Rogers
		,(3,2) --Braves, Brandies
		,(3,9) --Braves, Rogers
		,(4, 5) --Charlestown, Maplewood
		,(4, 9) --Charlestown, Rogers
		,(4, 11) --Charlestown, Ryan
		,(5,3) --EBK, East Boston Stadium
		,(5,5) --EBK, Maplewood Field
		,(5,9) --EBK, Rogers
		,(5,15) --EBK, Ross
		,(5,18) --EBK, Cleveland Circle
		,(6,5) --Malden, Maplewood
		,(6,10) --Malden, Ronan
		,(7,6) --McKay, McConnel
		,(7,10) --McKay, Ronan
		,(7,14) --McKay, English High
		,(8,8) --Revere, Revere
		,(8,9) --Revere, Rogers
		,(8,13) --Revere, Healy
		,(9,6) --Savin Hill, McConnel
		,(9,8) --Savin Hill, Revere
		,(9,10) --Savin Hill, Ronan
		,(10,2) --Somerville, Brandies
		,(10,12) --Somerville, Trum
		,(10,16) --Somerville, St. Peters Field
		,(11,5) --South Boston, Maplewood
		,(11,9) --South Boston, Rogers
		,(11,10) --South Boston, Ronan
		,(12,4) --Astros, Jim Rice
		,(13,7) --Stoneham, Rec Park

END

