--------------------------------------------------------------------------------------
-- Name	       : (Oracle Tutorial) Sample Database
-- Version     : 1.0
-- Last Updated: July-04-2022
-- Copyright   : Copyright © 2022 by dghuuloc. All Rights Reserved.
-- Notice      : Use this sample database for the educational purpose only.

--------------------------------------------------------------------------------------
--------------------------------------------------------------------
-- Create Table
--------------------------------------------------------------------

CREATE TABLE members (
    member_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL, 
    last_name VARCHAR2(50) NOT NULL,
    rank VARCHAR2(20)
);

CREATE TABLE member_staging AS
    SELECT * FROM members;
    
    
 --------------------------------------------------------------------
-- Insert into members table 
--------------------------------------------------------------------
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(1,'Abel','Wolf','Gold');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(2,'Clarita','Franco','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(3,'Darryl','Giles','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(4,'Dorthea','Suarez','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(5,'Katrina','Wheeler','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(6,'Lilian','Garza','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(7,'Ossie','Summers','Gold');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(8,'Paige','Mcfarland','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(9,'Ronna','Britt','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(10,'Tressie','Short','Bronze');

-- insert into member_staging table
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(1,'Abel','Wolf','Silver');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(2,'Clarita','Franco','Platinum');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(3,'Darryl','Giles','Bronze');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(4,'Dorthea','Gate','Gold');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(5,'Katrina','Wheeler','Silver');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(6,'Lilian','Stark','Silver');

--------------------------------------------------------------------
-- Retrieving the data from both tables 
--------------------------------------------------------------------

SELECT * FROM members;

SELECT * FROM member_staging;

--------------------------------------------------------------------
-- MERGE statement for merging data from both tables
--------------------------------------------------------------------
MERGE INTO member_staging x
USING (SELECT member_id, first_name, last_name, rank FROM members) y
ON (x.member_id  = y.member_id)
WHEN MATCHED THEN
    UPDATE SET x.first_name = y.first_name, 
                        x.last_name = y.last_name, 
                        x.rank = y.rank
    WHERE x.first_name <> y.first_name OR 
           x.last_name <> y.last_name OR 
           x.rank <> y.rank 
WHEN NOT MATCHED THEN
    INSERT(x.member_id, x.first_name, x.last_name, x.rank)  
    VALUES(y.member_id, y.first_name, y.last_name, y.rank);


