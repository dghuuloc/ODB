## <p align="center"> PL/SQL Training Certification </p>


### Introduction to PL/SQL
---

#### What us PL/SQL?

PL/SQL is a block structured language. The programs of PL/SQL are logical block that contains any number of nested sub-blocks. Pl/SQL stands for "Procedural Language extension of SQL" that is used in Oracle. PL/SQL is integrated with Oracle database

#### PL/SQL Functionalities

PL/SQL includes procedural language elements like conditions statements and iterative statements, arrays, string, handling exception (runtime errors), collections, records. It allows declaration of constants and variables, procedures and functions, types and variable of those types and triggers.

### How to declare variable in PL/SQL

You must declare the PL/SQL variable in the declaration section or in a package as a global variable. After the declaration, PL/SQL allocates memory for the variable's value and the storage location is indeitified by the variable name.

__The syntax for declaring variable:__

```
variable_name [CONSTANT] datatype [NOT NULL] [:= | DEFAULT initial_value];
```

#### Variable Scope in PL/SQL

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

### Data Types
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

### Conditional Statement
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

### Array Handling

 A varray is used to store an ordered collection of data, however it is often better to think of an array as a collection of variables of the same type.
 
#### Creating a VARRAY at the schema level

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
#### Creating a VARRAY type within a PL/SQL block

```
TYPE varray_name IS | AS VARRAY(n) OF <element-type>;
```
For example -

```
TYPE namearray IS VARRAY(5) OF VARCHAR2(10);
TYPE grades IS VARRAY(5) OF INTEGER;
```

#### Associative arrays (index-by tables)

#### Nested Tables

#### Varrays (Variable-size arrays)

### Cursors

A cursor is a pointer to a private SQL area that stores information coming from a SELECT or data manipulation language (DML) statement (INSERT, UPDATE, DELETE, or MERGE). A cursor holds the rows (one or more) returned by a SQL statement. The set of rows the cursor holds is referred to as the active set.[12]

A cursor can be explicit or implicit. In a FOR loop, an explicit cursor shall be used if the query will be reused, otherwise an implicit cursor is preferred. If using a cursor inside a loop, use a FETCH is recommended when needing to bulk collect or when needing dynamic SQL.


### Iterative Statements
---

As a procedural language by definition, PL/SQL provides several iteration constructs, including basic LOOP statements, WHILE loops, FOR loops, and Cursor FOR loops.

#### LOOP Statements

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

#### FOR loops

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

#### Cursor FOR loops

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
Teh concept of the person_code within the FOR-loop gets expressed with dot-notation (".")

```
RecordIndex.person_code
```

### PL/SQL Cursors
---

#### Implicit Cursors



#### Explicit Cursors


### PL/SQL Stored Procedure
---

#### Syntax for creating procedure:

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

#### Executing a PL/SQL Procedure

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

#### Drop procedure syntax

```
DROP PROCEDURE procedure_name;
```

### PL/SQL Function
---

#### Creating a PL/SQL Function

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
#### Calling a PL/SQL Function

You can use a function anywhere that you use an expression of the same type. You can call a function in various places such as:

```
DECLARE 
BEGIN
	-- calling function in this execution
END;
```

#### Removing a function

The `DROP FUNCTION` deletes a function from the Oracle Database. The syntax for removing a function is straightforward:

```
DROP FUNCTION  function_name;
```

### PL/SQL Package
---
#### What is a PL/SQL package?

In PL/SQL, a package is a schema object that contains definitions for a group of ralated functionalities. A package include `variables, constants, cursors, exceptions, procedures, functions,  and subprograms`. It is compiled and stored in the Oracle Database.

Typically, a package has a specification and a body. A package specification is mandatory while the package body can be required or optional, depending on the package specification.

The following picture illustrates PL/SQL packages:

<p align="center"><img src="https://www.oracletutorial.com/wp-content/uploads/2017/12/plsql-package.jpg" /></p>

#### Package Specification

A package specification contains the following intems:

- Procedures
- Functions
- Cursors
- Types, Variables, and Constants
- Records
- Collections

To create a new packages specifications, we can use the `CREATE PACKAGE` statement

```
CREATE [OR REPLACE] PACKAGE [schema_name.] package_name
IS | AS
	declarations;
END package_name;
```

In thgis syntax, between the `AS` and `END` keywords, you declare the public items of the package specifiction.

To refer to an item using the following syntax:

```
package_name.item_name
```
#### Package body

To create a package body, we use the `CREATE PACKAGE BODY` as shown below:

```
CREATE [OR REPLACE] PACKAGE BODY [schema_name.] package_name 
IS | AS

[BEGIN
EXCEPTION]
END package_name;
```
Between the `AS` and `ENd` keywords are the declarations of private items and the implementations of the public items declared in the package specification.. Note that we can use either `IS` or `AS` keyword.

Calling functions from a package

```
package_name.function_name(arguments)
```

#### Drop Package

To drop a package, you use the `drop package` statement with the following syntax:

````
DROP PACKAGE [BODY] schema_name.package.name;
````
If you want to drop only the body of the package, you need to specify the `BODY` keyword. If you omit the `BODY` keyword, then the statement drops both the body and specification of the package.

Oracle does not invalidate dependent objects when you drop only the body of a package but not the package specification. However, you will not be able to call one of the procedures or function declared in the package specification till you recreate the package body.
