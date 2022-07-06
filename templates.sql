--------------------------------------------------------------------------------------
-- Name	       : (Oracle Tutorial) Sample Database
-- Version     : 1.0
-- Last Updated: July-04-2022
-- Copyright   : Copyright © 2022 by dghuuloc. All Rights Reserved.
-- Notice      : Use this sample database for the educational purpose only.

--------------------------------------------------------------------------------------
--------------------------------------------------------------------
-- PACKAGES --
--------------------------------------------------------------------

-- create package specification
CREATE OR REPLACE PACKAGE package_name AS
    FUNCTION function_name (list_variable) RETURN data_type;
    
    PROCEDURE procedure_name (list_variable);
    
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name AS
    
    FUNCTION function_name (list_variable) IS
        -- declaration statements
        BEGIN
            -- executive statements
        END function_name;
    
    
    PROCEDURE procedure_name (list_variable) IS
        -- declaration statements
        BEGIN
            -- executive statements
        END procedure_name;
END package_name;


