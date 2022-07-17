--------------------------------------------------------------------------------------
-- Name	       : (Oracle Tutorial) Sample Database
-- Version     : 1.0
-- Last Updated: July-04-2022
-- Copyright   : Copyright © 2022 by dghuuloc. All Rights Reserved.
-- Notice      : Use this sample database for the educational purpose only.

--------------------------------------------------------------------------------------
--------------------------------------------------------------------
-- CREATE TABLE --
--------------------------------------------------------------------

CREATE TABLE APP_PROJECT_GROUP ( 
  group_id      NUMBER   (15)    NOT NULL /*PRIMARY KEY*/, 
  group_name    VARCHAR2 (150)   NOT NULL, 
  project_id    NUMBER   (15)    NOT NULL, 
  user_id       NUMBER   (15)    NOT NULL
 );
 
--------------------------------------------------------------------
-- INSERT DATA USING JSON_TABLE FUNCTION --
--------------------------------------------------------------------
 
 DECLARE
  -- DB<>Fiddle does not support bind variables.
  -- So we declare a PL/SQL variable instead of the bind variable.
  your_json CLOB := '{
    "group_name" : "Grupo 1",
    "user_id" : 12345,
    "group_id": 10001,
    "projects": 
    [
        {
            "project" : {
                "id" : "721"
            }
        },
        {
            "project" : {
                "id" : "722"
            }
        },
        {
            "project" : {
                "id" : "723"
            }
        },
        {
            "project" : {
                "id" : "724"
            }
        }
    ]
}';
BEGIN
  INSERT INTO app_project_group (group_id, group_name, project_id, user_id)
  SELECT group_id, group_name, TO_NUMBER(project_id), user_id
  FROM   JSON_TABLE(
           your_json,
           '$'
           COLUMNS(
             group_name VARCHAR2(150) PATH '$.group_name',
             group_id   NUMBER(15)    PATH '$.group_id',
             user_id    NUMBER(15)    PATH '$.user_id',
             NESTED PATH '$.projects[*]'
             COLUMNS (
               project_id VARCHAR2(15)  PATH '$.project.id'
             )
           )
         );
END;

SELECT * FROM APP_PROJECT_GROUP;

DROP TABLE APP_PROJECT_GROUP;
