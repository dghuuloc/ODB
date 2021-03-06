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
		EXIT WHEN c_customers%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(C_ID || ' ' || c_name || ' '  || c_addr);
	END LOOP;
	CLOSE c_customers;
END;

--------------------------------------------------------------------
-- Table-Based Records --
--------------------------------------------------------------------

DECLARE 
	customer_rec customers%ROWTYPE;
BEGIN
	SELECT * INTO customer_rec
	FROM customers
	WHERE id = 5;
	DBMS_OUTPUT.PUT_LINE('Customer ID: ' || customer_rec.id);
	DBMS_OUTPUT.PUT_LINE('Customer Name: ' || customer_rec.name);
	DBMS_OUTPUT.PUT_LINE('Customer Address: ' || customer_rec.address);
	DBMS_OUTPUT.PUT_LINE('Customer Salary: ' || customer_rec.salary);
END;

--------------------------------------------------------------------
-- Cursor-Based Records --
--------------------------------------------------------------------

DECLARE 
	CURSOR customer_cur IS
		SELECT id, name, address
		FROM customers;
	customer_rec customer_cur%ROWTYPE;
BEGIN
	OPEN customer_cur;
	LOOP
		FETCH customer_cur INTO customer_rec; 
		EXIT WHEN  customer_cur%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(customer_rec.id || ' ' || customer_rec.name);
	END LOOP;
END;


--------------------------------------------------------------------
-- User-defined Records --
--------------------------------------------------------------------

-- Defining a Record
DECLARE 
	TYPE books IS RECORD (
		title VARCHAR(50),
		author VARCHAR(50),
		subject VARCHAR(100),
		book_id NUMBER
	);
book1 books;
book2 books;

-- Accessing Fields
DECLARE 
	TYPE books IS RECORD (
		title VARCHAR(50),
		author VARCHAR(50),
		subject VARCHAR(100),
		book_id NUMBER
	);
book1 books;
book2 books;
BEGIN
	-- Book 1 Specification
	book1.title := 'C programming';
	book1.author := 'Nuha Ali';
	book1.subject := 'C Programming Tutorial';
	book1.book_id := 6495407;
	
	--- Book 2 specification
	book2.title := 'Telecom Billing';
	book2.author := 'Zara Ali';
	book2.subject := 'Telecom Billing Tutorial';
	book2.book_id := 6495700;
	
	-- Print book 1 record
	DBMS_OUTPUT.PUT_LINE('Book 1 title: ' || book1.title);
	DBMS_OUTPUT.PUT_LINE('Book 1 author: ' || book1.author);
	DBMS_OUTPUT.PUT_LINE('Book 1 subject: ' || book1.subject);
	DBMS_OUTPUT.PUT_LINE('Book 1 book_id: ' || book1.book_id);
	
	-- Print book 2 record
	DBMS_OUTPUT.PUT_LINE('Book 2 title: ' || book2.title);
	DBMS_OUTPUT.PUT_LINE('Book 2 author: ' || book2.author);
	DBMS_OUTPUT.PUT_LINE('Book 2 subject: ' || book2.subject);
	DBMS_OUTPUT.PUT_LINE('Book 2 book_id: ' || book2.book_id);
END;

-- Using Procedure for printing book records
DECLARE 
	TYPE books IS RECORD (
		title VARCHAR(50),
		author VARCHAR(50),
		subject VARCHAR(100),
		book_id NUMBER
	);
	book1 books;
	book2 books;

	PROCEDURE printbook(book books) IS
		BEGIN
			DBMS_OUTPUT.PUT_LINE('Book title: ' || book.title);
			DBMS_OUTPUT.PUT_LINE('Book author: ' || book.author);
			DBMS_OUTPUT.PUT_LINE('Book subject: ' || book.subject);
			DBMS_OUTPUT.PUT_LINE('Book book_id: ' || book.book_id);
		END;
BEGIN
	-- Book 1 Specification
	book1.title := 'C programming';
	book1.author := 'Nuha Ali';
	book1.subject := 'C Programming Tutorial';
	book1.book_id := 6495407;
	
	--- Book 2 specification
	book2.title := 'Telecom Billing';
	book2.author := 'Zara Ali';
	book2.subject := 'Telecom Billing Tutorial';
	book2.book_id := 6495700;
	
	-- Use procedure to print book information
	printbook(book1);
	printbook(book2);
END;

--------------------------------------------------------------------
-- Exception Handling --
--------------------------------------------------------------------
DECLARE 
    c_id customers.id%TYPE := 8;
    c_name customers.name%TYPE;
    c_addr customers.address%TYPE;
BEGIN
    SELECT name, address INTO c_name, c_addr
    FROM customers
    WHERE  id = c_id;
    DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
    DBMS_OUTPUT.PUT_LINE('Address: ' || c_addr);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No Such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error!');
END;

-- User-defined Exceptions
DECLARE 
    c_id customers.id%TYPE := &cc_id;
    c_name customers.name%TYPE;
    c_addr customers.address%TYPE;
    -- User define Exception
    ex_invalid_id EXCEPTION;
BEGIN
    IF c_id <= 0 THEN
        RAISE ex_invalid_id;
    ELSE
        SELECT name, address INTO c_name, c_addr
        FROM customers
        WHERE id = c_id;
        DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
        DBMS_OUTPUT.PUT_LINE('Address: ' || c_addr);
    END IF;
    
EXCEPTION 
    WHEN ex_invalid_id THEN
        DBMS_OUTPUT.PUT_LINE('ID must be greater than zero!');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error!');
END;

--------------------------------------------------------------------
-- Trigger --
--------------------------------------------------------------------

CREATE OR REPLACE TRIGGER display_salary_changes
BEFORE
DELETE OR INSERT OR UPDATE
ON customers
FOR EACH ROW
WHEN (NEW.id > 0)
DECLARE 
	sal_diff NUMBER;
BEGIN
	sal_diff := :NEW.salary - : OLD.salary;
	DBMS_OUTPUT.PUT_LINE('Old salary: ' || :OLD.salary);
	DBMS_OUTPUT.PUT_LINE('New salary: ' || :NEW.salary);
	DBMS_OUTPUT.PUT_LINE('Salary Difference: ' || sal_diff);
END;

-- Triggering Trigger
INSERT INTO customers (id, name, age, address, salary)
VALUES (7, 'Kriti', 22, 'HP', 7500.00);

UPDATE customers 
SET salary = salary + 500
WHERE id = 7;

--------------------------------------------------------------------
-- PL/SQL Packages --
--------------------------------------------------------------------

-- Creating a package
CREATE PACKAGE cust_sal	AS
	PROCEDURE find(c_id customers.id%TYPE);
END cust_sal;

-- creating package body
CREATE OR REPLACE PACKAGE BODY cust_sal	AS
	PROCEDURE find_sal(c_id customers.id%TYPE) IS
		c_sal customers.salary%TYPE;
	BEGIN
		SELECT salary INTO c_sal
		FROM customers
		WHERE id = c_id;
		DBMS_OUTPUT.PUT_LINE('Salary: ' || c_sal);
	END find_sal;;
END cust_sal;

-- Calling find_sal method and cust_sal package
DECLARE
	code customers.id%TYPE := &cc_id;
BEGIN
	cust_sal.find_sal(code);
END;

--------------------------------------------------------------------
-- PL/SQL Packages in specific example--
--------------------------------------------------------------------

-- The package Specification
CREATE OR REPLACE PACKAGE c_package AS
	-- Adds a custome
	PROCEDURE addCustomer(
		c_id customers.id%TYPE,
		c_name customers.name%TYPE,
		c_age customers.age%TYPE,
		c_addr customers.address%TYPE,
		c_sal customers.salary%TYPE
	);
	
	-- Removes a customer
	PROCEDURE delCustomer(c_id customers.id%TYPE);
	
	-- List all customers
	PROCEDURE listCustomer;
END c_package;

-- Creating the package Body
CREATE OR REPLACE PACKAGE BODY c_package AS

	PROCEDURE addCustomer(
		c_id customers.id%TYPE,
		c_name customers.name%TYPE,
		c_age customers.age%TYPE,
		c_addr customers.address%TYPE,
		c_sal customers.salary%TYPE
		) 
	IS
	BEGIN
		INSERT INTO customers (id, name, age, address, salary)
		VALUES(c_id, c_name, c_age, c_addr, c_sal);
	END addCustomer;
	
	PROCEDURE delCustomer(c_id customers.id%TYPE) 
	IS 
	BEGIN
		DELETE FROM customers
		WHERE id = c_id;
	END delCustomer;
	
	PROCEDURE listCustomer IS
		CURSOR c_customers IS
			SELECT name 
			FROM customers;
		TYPE c_list IS TABLE OF customers.name%TYPE;
		name_list c_list := c_list();
		counter INTEGER := 0;
	BEGIN
		FOR n IN c_customers LOOP
			counter := counter + 1;
			name_list.extend;
			name_list(counter) := n.name;
			DBMS_OUTPUT.PUT_LINE('Customer(' || counter|| ')' || name_list(counter));
		END LOOP;
	END listCustomer;

END c_package;

--- Using the c_package
DECLARE
	code customers.id%TYPE;
BEGIN
	c_package.addCustomer(8, 'Rajnish', 25, 'Chennai', 3500);
	c_package.addCustomer(9, 'Subham', 32, 'Delhi', 7500);
	c_package.listCustomer;
	c_package.delcustomer(code);
	c_package.listCustomer;
END;

--------------------------------------------------------------------
-- PL/SQL Collections--
--------------------------------------------------------------------

-- Index-By Table Example
DECLARE
	TYPE salary IS TABLE OF NUMBER INDEX BY VARCHAR2(20);
	salary_list salary;
	name VARCHAR2(20);
BEGIN
	-- adding elements to the table
	salary_list('Rajnish') := 62000;
	salary_list('Minakshi') := 75000;
	salary_list('Martin') := 100000;
	salary_list('James') := 78000;
	
	-- printing the table
	name := salary_list.FIRST;
	WHILE name IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE('Salary of ' || name || ' is: ' || TO_CHAR(salary_list(name)));
		name := salary_list.NEXT(name);
	END LOOP;
END;

-- Element of Index-By table is also customers Databse Table
DECLARE
	CURSOR c_customers IS
		SELECT name FROM customers;
	TYPE c_list IS TABLE OF customers.name%TYPE INDEX BY BINARY_INTEGER;
	name_list c_list;
	counter INTEGER := 0;
BEGIN
	FOR n IN c_customers LOOP
		counter := counter + 1;
		name_list(counter) := n.name;
		DBMS_OUTPUT.PUT_LINE('Customer(' || counter || '): ' || name_list(counter));
	END LOOP;
END;

-- Nested Table in example
DECLARE
	TYPE names_table IS TABLE OF VARCHAR2(10);
	TYPE grades IS TABLE OF INTEGER;
	names names_table;
	marks grades;
	total INTEGER;
BEGIN
	names := names_table('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
	marks := grades(98, 97, 78, 87, 92);
	total := names.COUNT;
	DBMS_OUTPUT.PUT_LINE('Total ' || total || ' Students');
	FOR i IN 1..total LOOP
		DBMS_OUTPUT.PUT_LINE('Student:' || names(i) || ', Marks: ' || marks(i));
	END LOOP;
END;

-- Element of nested table is also customers Databse Table
DECLARE
	CURSOR c_customers IS
		SELECT name FROM customers;
	TYPE c_list IS TABLE OF customers.name%TYPE;
	name_list c_list := c_list();
	counter INTEGER := 0;
BEGIN
	FOR n IN c_customers LOOP
		counter := counter + 1;
		name_list.extend;
		name_list(counter) := n.name;
		DBMS_OUTPUT.PUT_LINE('Customer(' || counter || '): ' || name_list(counter));
	END LOOP;
END;
