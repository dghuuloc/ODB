--------------------------------------------------------------------------------------
-- Name	       : (Oracle Tutorial) Sample Database
-- Version     : 1.0
-- Last Updated: July-04-2022
-- Copyright   : Copyright © 2022 by dghuuloc. All Rights Reserved.
-- Notice      : Use this sample database for the educational purpose only.

--------------------------------------------------------------------------------------
--------------------------------------------------------------------
-- The 'Hello World!' Example
--------------------------------------------------------------------

-- create anonymous block 


DECALRE
	-- Variable Declaration
	message VARCHAR2(50) := 'Hello, World!';
BEGIN
	/* 
   	*  PL/SQL executable statement(s) 
   	*/
	DBMS_OUTPUT.PUT_LINE(message);
END;


--------------------------------------------------------------------
-- Variable Scope in PL/SQL
--------------------------------------------------------------------

