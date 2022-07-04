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
SET SERVEROUTPUT ON;

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


--------------------------------------------------------------------
-- Create a customer table
--------------------------------------------------------------------

CREATE TABLE customers (
	id INT NOT NULL,
	name VARCHAR2 (20) NOT NULL,
	age INT NOT NULL,
	address CHAR (25),
	salary DECIMAL (18,2),
	PRIMARY KEY (id)
);

-- Insert some values into customer table

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );  

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );  

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );
  
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 ); 
 
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 );  

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (6, 'Komal', 22, 'MP', 4500.00 );

-- Drop customers table

DROP TABLE customers;

--------------------------------------------------------------------
-- Using SELECT INTO clause of SQL
--------------------------------------------------------------------

DECLARE 
   c_id customers.id%TYPE := 1; 
   c_name  customers.name%TYPE; 
   c_addr customers.address%TYPE; 
   c_sal  customers.salary%TYPE; 
BEGIN 
   SELECT name, address, salary INTO c_name, c_addr, c_sal 
   FROM customers 
   WHERE id = c_id;  
   dbms_output.put_line 
   ('Customer ' ||c_name || ' from ' || c_addr || ' earns ' || c_sal); 
END;

--------------------------------------------------------------------
-- the following program illustrates the use of varrays --
--------------------------------------------------------------------

DECLARE
	TYPE namesarray IS VARRAY(5) OF VARCHAR2(10);
	TYPE grades IS VARRAY(5) OF INTEGER;
	names namesarray;
	marks grades;
	total INTEGER;
BEGIN
	names := namesarray('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
	marks := grades(98, 97, 78, 87, 92);
	total := names.COUNT;
	DBMS_OUTPUT.PUT_LINE('Total ' || total || ' Students');
	FOR i IN 1..total LOOP
		DBMS_OUTPUT.PUT_LINE('Student ' || names(i) || 'Marks: ' || marks(i));
	END LOOP;
END;

--------------------------------------------------------------------
-- Folowing example makes the use of curssor with varray --
--------------------------------------------------------------------

-- quering customer table
SELECT * FROM customers;

-- using cursor
DECLARE 
	CURSOR c_customers IS
	SELECT name FROM customers;
	TYPE c_list IS VARRAY(6) OF customers.name%TYPE;
	name_list c_list := c_list();
	counter INTEGER := 0;
BEGIN
	FOR n IN c_customers LOOP
		counter := counter + 1;
		name_list.extend;
		name_list(counter) := n.name;
		DBMS_OUTPUT.PUT_LINE('Customer('||counter||'): ' || name_list(counter));
	END LOOP;
END;

--------------------------------------------------------------------
-- Simple Procedure for displaying the string 'Hello World' --
--------------------------------------------------------------------

-- Creatind greeting Procedure
CREATE OR REPLACE PROCEDURE greetings AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello world');
END;

-- Executing a stanalone Procedure
EXECUTE greetings;

-- The procedure can also call from another PL/SQL anonymous block
BEGIN
	greetings;
END;

-- Deleting a Standalone Procedure
DROP PROCEDURE greetings;

--------------------------------------------------------------------
-- Finding Minium number using Procedure --
--------------------------------------------------------------------

-- Using IN and OUT Mode 1
DECLARE
	a NUMBER;
	b NUMBER;
	c NUMBER;
    PROCEDURE findMin(x IN NUMBER, y IN NUMBER, z OUT NUMBER) IS
        BEGIN
            IF x < y THEN
                z := x;
            ELSE
                z := y;
            END IF;
        END;
BEGIN
	a := 23;
	b :=  45;
	findMin(a, b, c);
	DBMS_OUTPUT.PUT_LINE('Minium of (23, 45) is: ' || c);
END;

-- Using IN and OUT Mode 2
DECLARE 
	a NUMBER;
	PROCEDURE squareNum(x IN OUT NUMBER) IS
		BEGIN
			x := x * x;
		END;
BEGIN
	a := 23;
	squareNum(a);
	DBMS_OUTPUT.PUT_LINE('Square of (23): ' || a);
END;

--------------------------------------------------------------------
-- Creating a function --
--------------------------------------------------------------------

-- Crating a totalcustomer function
SELECT * FROM customers;

CREATE OR REPLACE FUNCTION totalCustomers
	RETURN NUMBER IS
		total NUMBER(2) := 0;
	BEGIN
		SELECT COUNT(*) INTO total
		FROM customers;
		
		RETURN total;
	END;

-- Calling a totalCustomers function
DECLARE
	c NUMBER(2);
BEGIN
	c := totalCustomers();
	DBMS_OUTPUT.PUT_LINE('Total no. of Customer: ' || c);
	
END;

-- drop function
DROP FUNCTION totalCustomers;

--------------------------------------------------------------------
-- Finding Maximum number using Function --
--------------------------------------------------------------------

DECLARE
	a NUMBER; 
	b NUMBER;
	c NUMBER;
	FUNCTION findMax(x IN NUMBER, y IN NUMBER)
		RETURN NUMBER IS
			z NUMBER;
		BEGIN
			IF x > y THEN
				z := x;
			ELSE
				z := y;
			END IF;
			
			RETURN z;
		END;
BEGIN
	a := 23;
	b := 45;
	c := findMax(a, b);
	DBMS_OUTPUT.PUT_LINE('Maximum of (23, 45): ' || c);
END;

--------------------------------------------------------------------
-- PL/SQL Recursive Function to find factorial of Numbers --
--------------------------------------------------------------------

DECLARE
	num NUMBER;
	factorial NUMBER;
	FUNCTION fact(x NUMBER) 
		RETURN NUMBER IS
			f NUMBER;
	BEGIN
		IF x=0 THEN
			f := 1;
		ELSE
			f := x * fact(x-1);
		END IF;
		
		RETURN f;
	END;
BEGIN
	num := 6;
	factorial := fact(num);
	DBMS_OUTPUT.PUT_LINE('Factorial ' || num || ' is ' || factorial);
END;


--------------------------------------------------------------------
-- Implicit Cursors --
--------------------------------------------------------------------

DECALRE 
	total_rows NUMBER(2);
BEGIN
	UPDATE customers
	SET salary =  salary + 500;
	IF sql%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('no customers selected');
	ELSIF
		total_rows := sql%ROWCOUNT;
		DBMS_OUTPUT.PUT_LINE(total_rows || ' customers selected ');
	END IF;
END;

--------------------------------------------------------------------
-- Explicit Cursors --
--------------------------------------------------------------------

DECLARE
	c_id customers.id%TYPE;
	c_name customers.name%TYPE;
	c_addr customers.address%TYPE;
	
	CURSOR c_customers IS
		SELECT id, name, address FROM customers;
BEGIN
	OPEN c_customers;
	LOOP
		FETCH c_customers INTO c_id, c_name, c_addr;
		EXIT WHEN c_customers.%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(C_ID || ' ' || c_name || ' '  || c_addr);
	END LOOP;
	CLOSE c_customers;
END;
