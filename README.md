# <p align="center"> PL/SQL Training Certification </p>

<p><img src="https://brightsec.com/wp-content/uploads/2022/02/SQL-Injection-in-Oracle.png"/></p>

## Introduction to PL/SQL
---

### What is PL/SQL?

PL/SQL is a block structured language. The programs of PL/SQL are logical block that contains any number of nested sub-blocks. Pl/SQL stands for "Procedural Language extension of SQL" that is used in Oracle. PL/SQL is integrated with Oracle database

### PL/SQL Functionalities

PL/SQL includes procedural language elements like conditions statements and iterative statements, arrays, string, handling exception (runtime errors), collections, records. It allows declaration of constants and variables, procedures and functions, types and variable of those types and triggers.

## How to declare variable in PL/SQL

You must declare the PL/SQL variable in the declaration section or in a package as a global variable. After the declaration, PL/SQL allocates memory for the variable's value and the storage location is indeitified by the variable name.

__The syntax for declaring variable:__

```
variable_name [CONSTANT] datatype [NOT NULL] [:= | DEFAULT initial_value];
```

### Variable Scope in PL/SQL

PL/SQL allows the nesting of blocks, i.e., each program block may contain another inner block. If a variable is declared within an inner block, it is not accessible to the outer block. However, if a variable is declared and accessible to an outer block, it is also accessible to all nested inner blocks. There are two types of variable scope −

- Local variables − Variables declared in an inner block and not accessible to outer blocks.

- Global variables − Variables declared in the outermost block or a package.

For example, 

```
DECLARE
	-- Global variables 
	num1 NUMBER := 95;
	num2 NUMBER := 85;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Outer Variable num1: ' || num1);
	DBMS_OUTPUT.PUT_LINE('Outer Variable num2: ' || num2);
	
	DECLARE
		-- Local variables
		num1 NUMBER := 195
		num2 NUMBER := 185;
	BEGIN
		DBMS_OUTPUT.PUT_LINE('Outer Variable num1: ' || num1);
		DBMS_OUTPUT.PUT_LINE('Outer Variable num2: ' || num2);
	
	END;
END;
```

## Data Types
---

The major datatypes in PL/SQL include NUMBER, CHAR, VARCHAR2, DATE and TIMESTAMP.

__Numeric Variables__

```
variable_name NUMBER([P, S]) := 0;

```

In there,

`Precision` (P)- refer to the number of digits the variable can hold
`Scale` (S)- refer to the number of digits that cna follow the decimal point. 

__Character Variables__

```
variable_name VARCHAR2(20) := 'Text';

-- for example
address VARCHAR2(20) := 'lake view road';

```

Onter datatypes for character variables include: VARCHAR, CHAR, LONG, ROW, LONG RAW, NCHAR, NCHAR2, CLOB, BLOB, BFILE.

__Date Variables__

```
variable_name DATE := TO_DATE('02-07-2022 12:42:23', 'DD-MM-YYYY hh24:mi:ss');

```
The function converts the first quoted string into a date, usign as a definition the second quoted string, for example:

```
TO_DATE('02-07-2022', 'DD-MM-YYYY')
```
or

```
TO_DATE ('02-07-2022', 'DD-MM-YYYY', 'NLS_DATE_LANGUAGE = American')
```

To convert the dates to string one uses the function `TO_CHAR (date_string, format_string)`

### Datatypes for Secific columns

```
variable_name Table_name.Column_name%type;
```

This syntax defines a variable of the type of the referenced column on the referenced tables.

Programmers can specify user_defined datatypes with the syntax:

```

TYPE data_tpye IS RECORD 
(field_1 type_1 := xyz,
field_2 type_2 := abc,
...,
field_n type_n := nnn
);

```
For example,

```
DECLARE 
 TYPE t_address IS RECORD (
  name address.name%type,
  street address.street%type,
  street_number address.street_nubmer%type,
  postcode address.postcode%type
  );
  v_address t_address;
BEGIN
  SELECT name, stree, street_number, postcode 
  INTO v_address
  FROM address
  WHERE rownum = 1;
END;
```

This sample program defines its own datatype, called t_address, which contains the fields name, street, street_number and postcode.

So according to the example, we are able to copy the data from the database to the fields in the program.

Using this datatype the programmer has defined a variable called v_address and loaded it with data from the *ddress* table.

Programmer can address individual attributes in such a structure by means of the dot-notation, thus

```
v_address.street := 'High Street';
```

## Conditional Statement
---

The following code segment shows the __IF-THEN-ELSID-ELSE__ construct.

The ELSIF and ELSE parts are optional so it is possible to create simpler IF-THEN or, IF-THEN-ELSE constructs.

```
IF condition_1 THEN
  sequence_of_statements_1;
ELSIF condition_2 THEN
  sequence_of_statements_2;
....

ELSE
  sequence_of_statements_n;
END IF;
```

The __CASE__ statement simplifies some large __IF-THEN-ELSIF-ELSE__ structures

```
CASE
  WHEN condition_1 THEN sequence_of_statements_1;
  WHEN condition_2 THEN sequence_of_statements_2;
  ....
  
  ELSE sequence_of_statements_n;
END CASE;
```

CASE statement can be used with predefined selector:

```
CASE variable
   WHEN value_1 THEN sequence_of_statements_1;
   WHEN value_2 THEN sequence_of_statements_2;
   ...
   
   ELSE sequence_of_statements_n;
END CASE;
```

## Array Handling

 A varray is used to store an ordered collection of data, however it is often better to think of an array as a collection of variables of the same type.
 
### Creating a VARRAY at the schema level

```
CREATE OR REPLACE TYPE varray_type_name IS | AS VARRAY(n) OF <element_type>;
```

Where,

- varray_type_name is a valid attribute name,
- n is the number of elements (maximum) in the varray,
- element_type is the data type of the elements of the array.

For example,

```
CREATE OR REPLACE TYPE namearray AS VARRAY(3) OF VARCHAR2(10);
```
### Creating a VARRAY type within a PL/SQL block

```
TYPE varray_name IS | AS VARRAY(n) OF <element-type>;
```
For example -

```
TYPE namearray IS VARRAY(5) OF VARCHAR2(10);
TYPE grades IS VARRAY(5) OF INTEGER;
```

### Associative arrays (index-by tables)

### Nested Tables

### Varrays (Variable-size arrays)

## Iterative Statements
---

As a procedural language by definition, PL/SQL provides several iteration constructs, including basic LOOP statements, WHILE loops, FOR loops, and Cursor FOR loops.

### LOOP Statements

```
<<parent_loop>>

LOOP
	statements

	<<child_loop>>
	LOOP
		statements
		EXIT parent_loop WHEN <condition>; -- Terminates both loops
		EXIT WHEN <condition>; -- Returns control to parent_loop
	END LOOP child_loop;
        IF <condition> THEN
           CONTINUE; -- continue to next iteration
        END IF;

	EXIT WHEN <condition>;
END LOOP parent_loop;
```

### FOR loops

```
DECLARE
    var NUMBER;
BEGIN
    /* N.B. for loop variables in PL/SQL are new 
    declarations, with scope only inside the loop */
    FOR var IN 0 ... 10 LOOP
        DBMS_OUTPUT.PUT_LINE(var);
    END LOOP;

    IF var IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('var is null');
    ELSE
        DBMS_OUTPUT.PUT_LINE('var is not null');
    END IF;
END;
```

### Cursor FOR loops

```
FOR RecordIndex IN
(
  SELECT person_code 
  FROM people_table
)
LOOP
  DMNS_OUTPUT.PUT_LINE(RecordIndex.person_code);
END LOOP;
```

As an alternative, the PL/SQL programmer can pre-define the cursor's SELECT-statement in advance to (for example) allow re-use or make the code more understandable (especially useful in the case of long or complex queries).

```
DECLARE
  CURSOR cursor_person IS
    SELECT person_code FROM people_table;

BEGIN
  FOR RecordIndex IN cursor_person
  LOOP
    DBMS_OUTPUT.PUT_LINE(ReordIndex.person_code);
  END LOOP;
END
```
The concept of the person_code within the FOR-loop gets expressed with dot-notation (".")

```
RecordIndex.person_code
```

## PL/SQL Cursors
---

Oracle creates a memory area, known as the context area, for processing an SQL statement, which contains all the information needed for processing the statement; for example, the number of rows processed, etc.

A cursor is a pointer to this context area. PL/SQL controls the context area through a cursor. A cursor holds the rows (one or more) returned by a SQL statement.

There are two types of cursors −
- Implicit cursors
- Explicit cursors

### ___Implicit Cursors___

Implicit cursors are automatically created by Oracle whenever an SQL statement is executed, when there is no explicit cursor for the statement. Programmers cannot control the implicit cursors and the information in it.

Whenever a DML statement (INSERT, UPDATE and DELETE) is issued, an implicit cursor is associated with this statement. For INSERT operations, the cursor holds the data that needs to be inserted. For UPDATE and DELETE operations, the cursor identifies the rows that would be affected.

In PL/SQL, you can refer to the most recent implicit cursor as the SQL cursor, which always has attributes such as %FOUND, %ISOPEN, %NOTFOUND, and %ROWCOUNT. The SQL cursor has additional attributes, %BULK_ROWCOUNT and %BULK_EXCEPTIONS, designed for use with the FORALL statement.

### ___Explicit Cursors___

Explicit cursors are programmer-defined cursors for gaining more control over the context area. An explicit cursor should be defined in the declaration section of the PL/SQL Block. It is created on a SELECT Statement which returns more than one row.

The syntax for creating an explicit cursor is −

```
CURSOR cursor_name IS seclect_statement;
```

Working with an explicit cursor includes the following steps −

- Declaring the cursor for initializing the memory
- Opening the cursor for allocating the memory
- Fetching the cursor for retrieving the data
- Closing the cursor to release the allocated memory

__Declaring the Cursor__ - Declaring the cursor defines the cursor with a name and the associated SELECT statement.

__Opening the Cursor__ - Opening the cursor allocates the memory for the cursor and makes it ready for fetching the rows returned by the SQL statement into it.

__Fetching the Cursor__ - Fetching the cursor involves accessing one row at a time.

__Closing the Cursor__ - closing the cursor means releasing the allocated memory.

## PL/SQL Records

A __record__ is a data structure that can hold data items of different kinds. Records consist of different fields, similar to a row of a database table.

PL/SQL can handle the following types of records - 
- Table-based
- Cursor-based records
- User-defined records

### __User-Defined Records__

PL/SQL provides a user-defined record type that allows you to define the different record structures.

- ___Defining a Record___

The record type is defined as -

```
TYPE type_name Is RECORD
	(field_name1 datatype1 [NOT NULL] [:= DEFAULT EXPRESSION],
	 field_name2 datatype2 [NOT NULL] [:= DEFAULT EXPRESSION],
	 ...
	 field_nameN datatypeN [NOT NULL] [:= DEFAULT EXPRESSION],
	);
record_name type_name;
```
- ___Accessing Fields___

To access any field of a record, we use the dot (.) operator. The member access operator is coded as a period between the record variable name and the field that we wish to access.

- ___Records as Subprogram Parameters___

A record can be passed as a subprogram parameter just as you pass any other variable.

## PL/SQL Exception Handling

There are two types of exceptions −

- System-defined exceptions
- User-defined exceptions

__Syntax for Eception Handling__

```
DECLARE 
   <declarations section> 
BEGIN 
   <executable command(s)> 
EXCEPTION 
   <exception handling goes here > 
   WHEN exception1 THEN  
      exception1-handling-statements  
   WHEN exception2  THEN  
      exception2-handling-statements  
   WHEN exception3 THEN  
      exception3-handling-statements 
   ........ 
   WHEN others THEN 
      exception3-handling-statements 
END;
```

__Raising Exceptions__

```
DECLARE 
   exception_name EXCEPTION; 
BEGIN 
   IF condition THEN 
      RAISE exception_name; 
   END IF; 
EXCEPTION 
   WHEN exception_name THEN 
   statement; 
END; 
```

__User-defined Exceptions__

```
DECLARE
my_exception EXCEPTION;
```

## PL/SQL Triggers

Triggers are stored programs, which are automatically executed or fired when some events occur. Triggers are, in fact, written to be executed in response to any of the following events −

- A database manipulation (DML) statement (DELETE, INSERT, or UPDATE)
- A database definition (DDL) statement (CREATE, ALTER, or DROP)
- A databse operation (SERVERERROR, LOGON, LOGOFF, STARTUP, or SHUTDOWN).

### Creating Triggers
---

```
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFOR | AFTER | INSTEAD OF}
{INSERT [OR] | UPDATE [OR] | DELETE}
[OF col_name] 
ON table_name
[REFERENCING OLD AS o NEW AS n]
[FOR EACH ROW]
WHEN (condition)

DECLARE
	-- declaration statements
BEGIN
	-- Executable statements
EXCEPTION
	-- Exception handling statements
END;
```
Where,

- CREATE [OR REPLACE] TRIGGER trigger_name − Creates or replaces an existing trigger with the trigger_name.

- {BEFORE | AFTER | INSTEAD OF} − This specifies when the trigger will be executed. The INSTEAD OF clause is used for creating trigger on a view.

- {INSERT [OR] | UPDATE [OR] | DELETE} − This specifies the DML operation.

- [OF col_name] − This specifies the column name that will be updated.

- [ON table_name] − This specifies the name of the table associated with the trigger.

- [REFERENCING OLD AS o NEW AS n] − This allows you to refer new and old values for various DML statements, such as INSERT, UPDATE, and DELETE.

- [FOR EACH ROW] − This specifies a row-level trigger, i.e., the trigger will be executed for each row being affected. Otherwise the trigger will execute just once when the SQL statement is executed, which is called a table level trigger.

- WHEN (condition) − This provides a condition for rows for which the trigger would fire. This clause is valid only for row-level triggers.

## Subprogram
---
A subprogram can be invoked by another subprogram or program which is called the __calling program__.

A Subprogram can be created - 
- At the schema level
- Inside a package
- Inside a PL/SQL block
 
PL/SQL provides two kinds of subprograms - 
- __Function__ - These subprograms return a single value; mainly used to compute and return a value.
- __Procedure__ − These subprograms do not return a value directly; mainly used to perform an action.

### Methods for Passing Parameters

- __Positional Notation__
In positional notation, the first actual parameter is substituted for the first formal parameter; the second actual parameter is substituted for the second formal parameter, and so on.

```
findMin(a, b, c, d);
```
- __Named Notations__
In named notation, the actual parameter is associated with the formal parameter using the arrow symbol __( => )__. 

```
findMin(x => a, y => b, z = > c, m => d);
```

- __Mixed Notation__
In mixed notation, you can mix both notations in procedure call; however, the positional notation should precede the named notation.

```
findMin(a, b, c, m => d);
```

or 

```
findMin(x => a, b, c, d);
```

## PL/SQL Stored Procedure
---

### Syntax for creating procedure:

```
CREATE [OR REPLACE] PROCEDURE procedure_name [(parameter_name [IN | OUT | INOUT] data_type [, ...])]

IS | AS
  -- Declarative part (optional)
BEGIN -- Executable part (required)
  -- SQL statements
  -- PL/SQL statements
EXCEPTION -- Exception-handling part (optional)
  -- Exception handlers for exceptions (errors) raised in executable part
END [procedure_name]; -- End of executable part (required)
```

### Executing a PL/SQL Procedure

We can call procedure using PL/SQL  anonymous block.

```
DECLARE
BEGIN
	-- calling function in this execution
END;
```

Also, the following shows the syntax for executing a procedure:

```
EXECUTE procedure_name(arguments);
```

### Drop procedure syntax

```
DROP PROCEDURE procedure_name;
```

## PL/SQL Function
---

### Creating a PL/SQL Function

```
CREATE [OR REPLACE] FUNCTION function_name [(parameter_name [IN |OUT | INOUT] data_type [, ...])]
  RETURN return_data_type
IS | AS -- declarative part (optional)
  -- Declarations of local types, variable, subprograms
BEGIN -- Executable part (required)
  -- SQL statements
  -- PL/SQL statements
EXCEPTION --Exception-handling part (optional)
  -- Exception handlers for exceptions (errors) raised in executable part
END [function_name]; --End of executable part (required)
```

Where,

- function-name specifies the name of the function.
- [OR REPLACE] option allows the modification of an existing function.
- The optional parameter list contains name, mode and types of the parameters. IN represents the value that will be passed from outside and OUT represents the parameter that will be used to return a value outside of the procedure.
- The function must contain a return statement.
- The RETURN clause specifies the data type you are going to return from the function.
- function-body contains the executable part.
- The AS keyword is used instead of the IS keyword for creating a standalone function.

### Calling a PL/SQL Function

To call a function, you simply need to pass the required parameters along with the function name and if the function returns a value, then you can store the returned value.

```
DECLARE 
BEGIN
	-- calling function in this execution
END;
```

### Removing a function

The `DROP FUNCTION` deletes a function from the Oracle Database. The syntax for removing a function is straightforward:

```
DROP FUNCTION  function_name;
```

## PL/SQL Package
---
### What is a PL/SQL package?

In PL/SQL, a package is a schema object that contains definitions for a group of ralated functionalities. A package include `variables, constants, cursors, exceptions, procedures, functions,  and subprograms`. It is compiled and stored in the Oracle Database.

Typically, a package has a specification and a body. A package specification is mandatory while the package body can be required or optional, depending on the package specification.

The following picture illustrates PL/SQL packages:

<p align="center"><img src="https://www.oracletutorial.com/wp-content/uploads/2017/12/plsql-package.jpg" /></p>

### Package Specification

A package specification contains the following intems:

- Procedures
- Functions
- Cursors
- Types, Variables, and Constants
- Records
- Collections

To create a new packages specifications, we can use the `CREATE PACKAGE` statement

```
CREATE [OR REPLACE] PACKAGE [schema_name.]<package_name>
IS | AS
	-- declarations of variables and type;
	-- declarations of cursors;
	-- declarations of modules;
END [<package_name>];
```

In this syntax, between the `AS` and `END` keywords, you declare the public items of the package specifiction.

To refer to an item using the following syntax:

```
package_name.item_name
```
### Package body

To create a package body, we use the `CREATE PACKAGE BODY` as shown below:

```
CREATE [OR REPLACE] PACKAGE BODY [schema_name.]<package_name> 
IS | AS
	-- declarations of variables and types
	-- specification and SELECT statement of cursors
	-- specification and body of modules
	
[BEGIN executable statements]
[EXCEPTION exception handlers]
END [<package_name>];
```

Between the `AS` and `ENd` keywords are the declarations of private items and the implementations of the public items declared in the package specification.. Note that we can use either `IS` or `AS` keyword.

Calling functions from a package

```
package_name.function_name(arguments)
```

### Drop Package

To drop a package, you use the `drop package` statement with the following syntax:

````
DROP PACKAGE [BODY] schema_name.package.name;
````
If you want to drop only the body of the package, you need to specify the `BODY` keyword. If you omit the `BODY` keyword, then the statement drops both the body and specification of the package.

Oracle does not invalidate dependent objects when you drop only the body of a package but not the package specification. However, you will not be able to call one of the procedures or function declared in the package specification till you recreate the package body.

## PL/SQL Collections

A collection is an ordered group of elements having the same data type. Each element is identified by a unique subscript that represents its position in the collection.

PL/SQL provides three collection types -
 - Index-by  tables or Associative array
 - Nested table
 - Variable-size array or Varray

### __Index-By Table__

An index-by table (also called an associative array) is a set of __key-value__ pairs. Each key is unique and is used to locate the corresponding value. The key can be either an integer or a string.

```
TYPE type_name IS TABLE OF element_type [NOT NULL] INDEX BY subscript_type;

table_name type_name;
```

### __Nested Tables__

A nested table is like a one-dimensional array with an arbitrary number of elements. However, a nested table differs from an array in the following aspects −

- An array has a declared nunmber of element, but a nested table does not. The size of a nested table can increase dynamically
- An array is always dense, i.e., it always has consecutive subscripts. A nested array is dense initially, but it can become sparse when elements are deleted from it.

A nested table is created using the following syntax -

```
TYPE type_name IS TABLE OF element_type [NOT NULL];

table_name type_name;
```

This declaration is similar to the declaration of an index-by table, but there is no INDEX BY clause.

A nested table can be stored in a database column. It can further be used for simplifying SQL operations where you join a single-column table with a larger table. An associative array cannot be stored in the database.

## PL/SQL Object

An object type allows you to create composite types. Using objects allow you to implement real world objects with specific structure of data and methods for operating it. Objects have attributes and methods. Attributes are properties of an object and are used for storing an object's state; and methods are used for modeling its behavior.

Objects are creatted using the CREATE [OR REPLACE] TYPE statement.

```
CREATE OR REPLACE TYPE object_name AS OBJECT (
	-- Declaring Attributes (String, Numeric, Object, ...)
	-- Declaring Methods (Functions, Procedures, ...). Note that we use MEMBER keyword
);[NOT FINAL | NOT INSTANTIABLE NOT FINAL]
```

The object body is created using the CREATE TYPE BODY statement.

```
CREATE OR REPLACE TYPE BODY object_name AS 
	--- Defining the code for the menmber methods
END;
```

#### __Instantianting an Object__

Defining an object type provides a blueprint for the object. To use this object, you need to create instances of this object. 

```
instance_name object_name;
```

#### __Member Methods__

Member methods are used for manipulating the attributes of the object. You provide the declaration of a member method while declaring the object type. The object body defines the code for the member methods. The object body is created using the CREATE TYPE BODY statement.

___Constructors___ are functions that return a new object as its value. Every object has a system defined constructor method.

- __Map Method__

The Map method is a function implemented in such a way that its value depends upon the value of the attributes.

- __Order Method__

The Order method implements some internal logic for comparing two objects.

#### __Inheritance for PL/SQL Objects__

PL/SQL allows creating object from the existing base objects. To implement inheritance, the base objects should be declared as NOT FINAL. The default is FINAL.

To inherite an existing Object, We can use UNDER keyword.

```
CREATE OR REPLACE child_object UNDER parent_object AS (
	...
);
```

#### __Abstract Objects in PL/SQL__

The NOT INSTANTIABLE clause allows you to declare an abstract object. You cannot use an abstract object as it is; you will have to create a subtype or child type of such objects to use its functionalities.








