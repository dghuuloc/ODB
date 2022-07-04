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

DECLARE 
   -- Global variables  
   num1 number := 95;  
   num2 number := 85;  
BEGIN  
   dbms_output.put_line('Outer Variable num1: ' || num1); 
   dbms_output.put_line('Outer Variable num2: ' || num2); 
   DECLARE  
      -- Local variables 
      num1 number := 195;  
      num2 number := 185;  
   BEGIN  
      dbms_output.put_line('Inner Variable num1: ' || num1); 
      dbms_output.put_line('Inner Variable num2: ' || num2); 
   END;  
END; 
