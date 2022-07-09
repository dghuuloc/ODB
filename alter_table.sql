--------------------------------------------------------------------------------------
-- Name	       : (Oracle Tutorial) Sample Database
-- Version     : 1.0
-- Last Updated: July-09-2022
-- Copyright   : Copyright © 2022 by dghuuloc. All Rights Reserved.
-- Notice      : Use this sample database for the educational purpose only.

--------------------------------------------------------------------------------------

--------------------------------------------------------------------
-- Creating persons table --
--------------------------------------------------------------------

CREATE TABLE persons (
    person_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2() NOT NULL,
    last_name VARCHAR2(50) NOTT NULL,
    PRIMARY KEY(person_id)
);


--------------------------------------------------------------------
-- Describe persons table --
--------------------------------------------------------------------

DESCRIBE persons;

--------------------------------------------------------------------
-- Adding new column into persons table --
--------------------------------------------------------------------

ALTER TABLE persons
ADD (
    birthdate DATE NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);

--------------------------------------------------------------------
-- Modify persons table --
--------------------------------------------------------------------

ALTER TABLE persons MODIFY (
    phone VARCHAR2(20) NOT NULL, 
    email VARCHAR2(100) NOT NULL
);

--------------------------------------------------------------------
-- Droping column of persons table --
--------------------------------------------------------------------

ALTER TABLE persons 
    DROP COLUMN (email, phone, birthdate);

--------------------------------------------------------------------
-- Renaming column of person table --
--------------------------------------------------------------------

ALTER TABLE persons
    RENAME COLUMN first_name TO forename;

--------------------------------------------------------------------
-- Renaming table name --
--------------------------------------------------------------------

ALTER TABLE persons RENAME TO people;


--------------------------------------------------------------------
-- Using accounts table for ALTER TABLE MODIFY in details --
--------------------------------------------------------------------

CREATE TABLE accounts (
    account_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(25) NOT NULL,
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(100),
    phone VARCHAR2(12),
    full_name VARCAR2(50) GENERATED ALWAY AS (
        first_name || ' ' || last_name
    ),
    PRIMARY KEY(account_id)
);

INSERT INTO accounts(fist_name, last_name) 
    VALUES('Trinity', 'Knox', '410-555-0197');
    
INSERT INTO accounts(fist_name, last_name) 
    VALUES('Mellissa', 'Porter', '410-555-0198');
 
INSERT INTO accounts(fist_name, last_name) 
    VALUES('Leeanna', 'Bowman', '410-555-0199');

ALTER TABLE accounts
    MODIFY full_name INVISIBLE;
    
UPDATE accounts
    SET email = LOWER(first_name || ',' || last_name || '@oracletutorial.com');
    
ALTER TABLE accounts
    MODIFY email VARCHAR2(100) NOT NULL;

UPDATE 
    accounts 
SET phone = '+1- '|| phone;

UPDATE 
    accounts
SET
    phone = REPLACE(phone, '+1-', '');
    
ALTER TABLE accounts 
    ADD status NUMBER(1,0) DEFALUT 1 NOLT NULL; 
    

--------------------------------------------------------------------
-- Using SUPPLIERS table for DROP COLUMNS in details --
--------------------------------------------------------------------

-- Creating suppliers table
CREATE TABLE suppliers (
    supplier_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    contact_name VARCHAR2(255) NOT NULL,
    company_name VARCHAR2(255),
    phone VARCHAR2(100) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    fax VARCHAR2(100) NOT NULL,
    PRIMARY KEY(supplier_id)
    );
    
-- inserting data into suplier table
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Solomon F. Zamora',
        'Elit LLP',
        '1-245-616-6781',
        'enim.condimentum@pellentesqueeget.org',
        '1-593-653-6421');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Haley Franco',
        'Ante Vivamus Limited',
        '1-754-597-2827',
        'Nunc@ac.com',
        '1-167-362-9592');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Gail X. Tyson',
        'Vulputate Velit Eu Inc.',
        '1-331-448-8406',
        'sem@gravidasit.edu',
        '1-886-556-8494');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Alec N. Strickland',
        'In At Associates',
        '1-467-132-4527',
        'Lorem@sedtortor.com',
        '1-735-818-0914');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Britanni Holt',
        'Magna Cras Convallis Corp.',
        '1-842-554-5106',
        'varius@seddictumeleifend.ca',
        '1-381-532-1632');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Audra O. Ingram',
        'Commodo LLP',
        '1-934-490-5667',
        'dictum.augue.malesuada@idmagnaet.net',
        '1-225-217-4699');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Cody K. Chapman',
        'Tempor Arcu Inc.',
        '1-349-383-6623',
        'non.arcu.Vivamus@rutrumnon.co.uk',
        '1-824-229-3521');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Tobias Merritt',
        'Amet Risus Company',
        '1-457-675-2547',
        'felis@ut.net',
        '1-404-101-9940');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Ryder G. Vega',
        'Massa LLC',
        '1-655-465-4319',
        'dui.nec@convalliserateget.co.uk',
        '1-282-381-9477');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Arthur Woods',
        'Donec Elementum Lorem Foundation',
        '1-406-810-9583',
        'eros.turpis.non@anteMaecenasmi.co.uk',
        '1-462-765-8157');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Lael Snider',
        'Ultricies Adipiscing Enim Corporation',
        '1-252-634-4780',
        'natoque.penatibus@in.com',
        '1-986-508-6373');


SELECT FAX FROM suppliers;

ALTER TABLE suppliers 
    DROP UNUSED COLUMNS;


DROP TABLE suppliers;

--------------------------------------------------------------------
-- Using persons table for DROP TABLE in details --
--------------------------------------------------------------------

-- Create persons table
CREATE TABLE persons (
    person_id NUMBER,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    PRIMARY KEY(person_id)
);

DROP TABLE persons;

-- Oracle DROP TABLE CASCDE CONSTRAINTS exmaple
CREATE TABLE brands( 
    brand_id NUMBER PRIMARY KEY,
    brand_name VARCHAR2(50)
);

CREATE TABLE cars (
    car_id NUMBER PRIMARY KEY,
    make  VARCHAR2(50) NOT NULL,
    model VARCHAR2(50) NOT NULL,
    year NUMBER NOT NULL,
    plate_nuamber VARCHAR(25),
    brand_id NUMBER NOT NULL,
    
    CONSTRAINT fk_brand
        FOREIGN KEY (brand_id)
        REFERENCES brands(brand_id) ON DELETE CASCADE
);

SELECT * FROM CARS;


-- ORACLE DROP multiple TABLE PURGE example
BEGIN
  FOR rec IN
    (
      SELECT
        table_name
      FROM
        all_tables
      WHERE
        table_name LIKE 'TEST_%'
    )
  LOOP
    EXECUTE immediate 'DROP TABLE  '||rec.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;
