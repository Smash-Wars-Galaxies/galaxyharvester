CREATE DATABASE swgresource;
USE swgresource;
CREATE TABLE tResources (spawnID INT AUTO_INCREMENT PRIMARY KEY, spawnName VARCHAR(255), galaxy SMALLINT, entered DATETIME, enteredBy VARCHAR(31), resourceType CHAR(63), unavailable DATETIME, unavailableBy VARCHAR(31), verified DATETIME, verifiedBy VARCHAR(31), CR SMALLINT, CD SMALLINT, DR SMALLINT, FL SMALLINT, HR SMALLINT, MA SMALLINT, PE SMALLINT, OQ SMALLINT, SR SMALLINT, UT SMALLINT, ER SMALLINT, INDEX IX_res_galaxy (galaxy), INDEX IX_res_restype (resourceType), INDEX IX_res_unavail (unavailable), INDEX IX_res_id_galaxy (spawnID, galaxy));
CREATE TABLE tResourcePlanet (spawnID INT, planetID SMALLINT, entered DATETIME, enteredBy VARCHAR(31), unavailable DATETIME, unavailableBy VARCHAR(31), verified DATETIME, verifiedBy VARCHAR(31), PRIMARY KEY (spawnID, planetID));
CREATE TABLE tResourceType (resourceType VARCHAR(63) PRIMARY KEY, resourceTypeName VARCHAR(255), resourceCategory VARCHAR(63), resourceGroup VARCHAR(63), enterable TINYINT, maxTypes SMALLINT, CRmin SMALLINT, CRmax SMALLINT, CDmin SMALLINT, CDmax SMALLINT, DRmin SMALLINT, DRmax SMALLINT, FLmin SMALLINT, FLmax SMALLINT, HRmin SMALLINT, HRmax SMALLINT, MAmin SMALLINT, MAmax SMALLINT, PEmin SMALLINT, PEmax SMALLINT, OQmin SMALLINT, OQmax SMALLINT, SRmin SMALLINT, SRmax SMALLINT, UTmin SMALLINT, UTmax SMALLINT, ERmin SMALLINT, ERmax SMALLINT, containerType VARCHAR(63), inventoryType VARCHAR(63), specificPlanet SMALLINT DEFAULT 0 NOT NULL, INDEX IX_res_type_cat_group (resourceCategory, resourceGroup));
CREATE TABLE tResourceGroup (resourceGroup VARCHAR(63) PRIMARY KEY, groupName VARCHAR(255), groupLevel SMALLINT, groupOrder SMALLINT, containerType VARCHAR(63));
CREATE TABLE tResourceTypeGroup (resourceType VARCHAR(63), resourceGroup VARCHAR(63), INDEX IX_res_type_group_type (resourceType), INDEX IX_res_type_group_group_type (resourceGroup, resourceType));
CREATE TABLE tResourceGroupCategory (resourceGroup VARCHAR(63), resourceCategory VARCHAR(63), INDEX IX_res_group_cat_group (resourceGroup), INDEX IX_res_group_cat_cat_group (resourceCategory, resourceGroup));
CREATE TABLE tResourceTypeCreature (resourceType VARCHAR(63), speciesName VARCHAR(63), maxAmount SMALLINT, missionLevel SMALLINT, galaxy SMALLINT DEFAULT 0 NOT NULL, enteredBy VARCHAR(31), PRIMARY KEY (resourceType, speciesName));
CREATE TABLE tPlanet (planetID SMALLINT AUTO_INCREMENT PRIMARY KEY, planetName varchar(63), galaxy INT, INDEX IX_planet_galaxy (galaxy));
CREATE TABLE tResourceEvents (galaxy SMALLINT, spawnID INT, userID VARCHAR(31), eventTime DATETIME, eventType CHAR(1), planetID SMALLINT, eventDetail VARCHAR(1023), INDEX IX_res_galaxy (galaxy), INDEX IX_res_galaxy_event_time (galaxy, eventTime), INDEX IX_res_event_time (eventTime), INDEX IX_res_event_user (userID), INDEX IX_res_event_spawn (spawnID), INDEX IX_res_event_type (eventType));
CREATE TABLE tSchematicEvents (galaxy SMALLINT, eventTime DATETIME, eventType CHAR(1), schematicID VARCHAR(127), expGroup VARCHAR(31), spawnID INT, eventDetail VARCHAR(1023), INDEX IX_schemevt_spawnschemexpgrp (spawnID, schematicID, expGroup), INDEX IX_schemevt_galaxy (galaxy), INDEX IX_schemevt_galaxy_eventtime (galaxy, eventTime), INDEX IX_schemevt_galaxy_schem (galaxy, schematicID), INDEX IX_schemevt_spawn (spawnID));
CREATE TABLE tServerBestStatus (galaxy SMALLINT, eventTime DATETIME, eventType CHAR(1), schematicID VARCHAR(127), expGroup VARCHAR(31), spawnID INT, eventDetail VARCHAR(1023), INDEX IX_sbstat_spawnschemexpgrp (spawnID, schematicID, expGroup), INDEX IX_sbstat_galaxy (galaxy), INDEX IX_sbstat_galaxy_eventtime (galaxy, eventTime), INDEX IX_sbstat_galaxy_schem (galaxy, schematicID), INDEX IX_sbstat_spawn (spawnID));
CREATE TABLE tGalaxy (galaxyID INT AUTO_INCREMENT PRIMARY KEY, galaxyName VARCHAR(127), lastExport DATETIME, galaxyState SMALLINT DEFAULT 0 NOT NULL, galaxyNGE SMALLINT DEFAULT 0, totalSpawns INT, totalWaypoints INT);
CREATE TABLE tGalaxyPlanet (galaxyID INT, planetID SMALLINT, PRIMARY KEY (galaxyID, planetID));
CREATE TABLE tUserStats (userID VARCHAR(31), galaxy SMALLINT, added INT, planet INT, edited INT, removed INT, verified INT, waypoint INT, repGood INT, repBad INT, PRIMARY KEY (userID, galaxy));
CREATE TABLE tWaypoint (waypointID INT AUTO_INCREMENT PRIMARY KEY, spawnID INT, planetID SMALLINT, owner VARCHAR(31), price INT, concentration SMALLINT, lattitude SMALLINT, longitude SMALLINT, waypointType CHAR(1), waypointName VARCHAR(254), shareLevel SMALLINT NOT NULL, entered DATETIME, unavailable DATETIME, INDEX IX_waypoint_spawnid (spawnID));
CREATE TABLE tUserWaypoints (userID VARCHAR(31), waypointID INT, unlocked DATETIME, INDEX IX_user_wp_userid (userID));
CREATE TABLE tUsers (userID VARCHAR(31) PRIMARY KEY, emailAddress VARCHAR(255), userPassword VARCHAR(40), created DATETIME, lastLogin DATETIME, lastReset DATETIME, inGameInfo VARCHAR(255), pictureName VARCHAR(255) DEFAULT 'default.jpg', themeName VARCHAR(31) DEFAULT 'crafter', paidThrough DATETIME, userStatus SMALLINT NOT NULL DEFAULT 0, verificationCode VARCHAR(32), defaultAlertTypes SMALLINT NOT NULL DEFAULT 3, emailChange VARCHAR(255));
CREATE TABLE tUserFriends (userID VARCHAR(31), friendID VARCHAR(31), added DATETIME, PRIMARY KEY (userID, friendID));
CREATE TABLE tUserEvents (userID VARCHAR(31), targetType CHAR(1), targetID INT, eventType CHAR(1), eventTime DATETIME, causeEventType CHAR(1), INDEX IX_user_event_ttype (targetType), INDEX IX_user_event_user_type (userID, eventType));
CREATE TABLE tSessions (sid VARCHAR(40) PRIMARY KEY NOT NULL, userID VARCHAR(31) NOT NULL, expires FLOAT, pushKey VARCHAR(255));
CREATE TABLE tProfession (profID SMALLINT AUTO_INCREMENT PRIMARY KEY, profName VARCHAR(31), craftingQuality SMALLINT, galaxy INT DEFAULT 0 NOT NULL);
CREATE TABLE tSkillGroup (profID SMALLINT, skillGroup VARCHAR(31) PRIMARY KEY, skillGroupName VARCHAR(63), INDEX IX_profsg_prof (profID), INDEX IX_profsg_sgname (skillGroupName));
CREATE TABLE tSchematic (schematicID VARCHAR(127) PRIMARY KEY, schematicName VARCHAR(255), craftingTab INT, skillGroup VARCHAR(31), objectType INT, complexity SMALLINT, objectSize SMALLINT, xpType VARCHAR(31), xpAmount SMALLINT, objectPath VARCHAR(255), objectGroup VARCHAR(255), galaxy INT DEFAULT 0 NOT NULL, enteredBy VARCHAR(31), INDEX IX_schem_skill (skillGroup), INDEX IX_schem_galaxy (galaxy));
CREATE TABLE tSchematicIngredients (schematicID VARCHAR(127), ingredientName VARCHAR(63), ingredientType SMALLINT, ingredientObject VARCHAR(255), ingredientQuantity SMALLINT, ingredientContribution SMALLINT, PRIMARY KEY (schematicID, ingredientName), INDEX IX_scheming_object (ingredientObject));
CREATE TABLE tSchematicQualities (expQualityID INT AUTO_INCREMENT PRIMARY KEY, schematicID VARCHAR(127), expProperty VARCHAR(31), expGroup VARCHAR(31), weightTotal SMALLINT, INDEX IX_schem_prop (schematicID, expProperty), INDEX IX_schem_id (schematicID));
CREATE TABLE tSchematicResWeights (expQualityID INT, statName CHAR(2), statWeight SMALLINT, INDEX IX_qual_res (expQualityID, statName));
CREATE TABLE tSchematicImages (schematicID VARCHAR(127), imageType SMALLINT, imageName VARCHAR(127), addedBy VARCHAR(31), INDEX IX_schem_img_schem (schematicID));
CREATE TABLE tObjectType (objectType INT PRIMARY KEY, typeName VARCHAR(63), craftingTab INT, INDEX IX_objtype_tab (craftingTab, objectType));
CREATE TABLE tFavorites (userID VARCHAR(31), favType SMALLINT, itemID INT, favGroup VARCHAR(255) NOT NULL, units INT, despawnAlert SMALLINT, galaxy INT, INDEX IX_fav_user_type (userID, favType), INDEX IX_fav_user (userID), INDEX IX_fav_group (favGroup));
CREATE TABLE tPayments (transactionID VARCHAR(32) PRIMARY KEY, completedDate DATETIME, recvEmail VARCHAR(127), recvID VARCHAR(15), payerEmail VARCHAR(127), payerID VARCHAR(15), payerStatus VARCHAR(15), firstName VARCHAR(64), lastName VARCHAR(64), paymentStatus VARCHAR(15), paymentGross DECIMAL(10,2), paymentFee DECIMAL(10,2), shippingAmount DECIMAL(10,2), handlingAmount DECIMAL(10,2), currency VARCHAR(15), paymentDate VARCHAR(31), transactionType VARCHAR(63), addressCity VARCHAR(40), addressCountryCode VARCHAR(2), addressState VARCHAR(40), addressStatus VARCHAR(15), addressStreet VARCHAR(200), addressZip VARCHAR(20), customInfo VARCHAR(255));
CREATE TABLE tFilters (userID VARCHAR(31), galaxy SMALLINT, rowOrder SMALLINT, fltType SMALLINT, fltValue VARCHAR(63), alertTypes SMALLINT, CRmin SMALLINT, CDmin SMALLINT, DRmin SMALLINT, FLmin SMALLINT, HRmin SMALLINT, MAmin SMALLINT, PEmin SMALLINT, OQmin SMALLINT, SRmin SMALLINT, UTmin SMALLINT, ERmin SMALLINT, fltGroup VARCHAR(255) NOT NULL DEFAULT '', PRIMARY KEY (userID, galaxy, rowOrder, fltType, fltValue), INDEX IX_filter_galaxy_type_value (galaxy, fltType, fltValue), INDEX IX_filter_user_group (userID, fltGroup));
CREATE TABLE tAlerts (alertID INT AUTO_INCREMENT PRIMARY KEY, userID VARCHAR(31), alertType SMALLINT, alertTime DATETIME, alertMessage VARCHAR(1023), alertLink VARCHAR(255), alertStatus CHAR(1), statusChanged DATETIME, INDEX IX_alerts_userid_type (userID, alertType), INDEX IX_alerts_status (alertStatus));
CREATE TABLE tRecipe (recipeID INT AUTO_INCREMENT PRIMARY KEY, recipeName VARCHAR(255), userID VARCHAR(31), schematicID VARCHAR(127), galaxy SMALLINT, INDEX IX_recipe_user_galaxy (userID, galaxy));
CREATE TABLE tRecipeIngredients (recipeID INT, ingredientName VARCHAR(63), ingredientResource INT, ingredientQuality SMALLINT, PRIMARY KEY (recipeID, ingredientName));
CREATE TABLE tFeedback (feedbackID INT AUTO_INCREMENT PRIMARY KEY, entered DATETIME NOT NULL, userID VARCHAR(31), feedback VARCHAR(1023), feedbackState TINYINT DEFAULT 0 NOT NULL, INDEX IX_feedback_entered (entered));
CREATE TABLE tFeedbackVotes (feedbackID INT NOT NULL, entered DATETIME NOT NULL, userID VARCHAR(31), vote TINYINT, PRIMARY KEY (feedbackID, userID));
CREATE TABLE tFeedbackComments (commentID INT AUTO_INCREMENT PRIMARY KEY, feedbackID INT NOT NULL, entered DATETIME NOT NULL, userID VARCHAR(31), comment VARCHAR(1023), INDEX IX_feedbackcomments_feedback (feedbackID));


GRANT SELECT,INSERT,UPDATE,DELETE ON swgresource.* TO 'webusr'@'localhost';
INSERT INTO tGalaxy (galaxyName, galaxyState) VALUES ('Test Galaxy', 1);
INSERT INTO tUsers (userID) VALUES ('default');
LOAD DATA LOCAL INFILE '/var/www/database/seedData/planet.csv' INTO TABLE tPlanet FIELDS ENCLOSED BY '"' (planetName);
LOAD DATA LOCAL INFILE '/var/www/database/seedData/waypointcity.csv' INTO TABLE tWaypoint FIELDS TERMINATED BY ',' (planetID, waypointName, waypointType, lattitude, longitude, concentration, shareLevel, entered);
LOAD DATA LOCAL INFILE '/var/www/database/seedData/waypointpoi.csv' INTO TABLE tWaypoint FIELDS TERMINATED BY ',' (planetID, waypointName, waypointType, lattitude, longitude, concentration, shareLevel, entered);
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tResourceType.txt' INTO TABLE tResourceType;
LOAD DATA LOCAL INFILE '/var/www/database/seedData/groups.csv' INTO TABLE tResourceGroup FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE '/var/www/database/seedData/typegroup.csv' INTO TABLE tResourceTypeGroup FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE '/var/www/database/seedData/professions.csv' INTO TABLE tProfession  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' (profID, profName, craftingQuality, galaxy);
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tSkillGroup.txt' INTO TABLE tSkillGroup;
INSERT INTO tSkillGroup (profID, skillGroup, skillGroupName) VALUES (0,'variableLooted','Looted Schematics');
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tObjectType.txt' INTO TABLE tObjectType;
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tSchematic.txt' INTO TABLE tSchematic;
UPDATE tSchematic SET skillGroup='variableLooted' WHERE skillGroup='';
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tSchematicIngredients.txt' INTO TABLE tSchematicIngredients;
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tSchematicQualities.txt' INTO TABLE tSchematicQualities;
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tSchematicResWeights.txt' INTO TABLE tSchematicResWeights;
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tResourceGroupCategory.txt' INTO TABLE tResourceGroupCategory;
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tSchematicImages.txt' INTO TABLE tSchematicImages;
LOAD DATA LOCAL INFILE '/var/www/database/seedData/tResourceTypeCreature.txt' INTO TABLE tResourceTypeCreature;
