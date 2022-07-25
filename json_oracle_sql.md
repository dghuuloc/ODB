# <p align="center">PARSING JSON IN PL/SQL</p>

<p align="center"><img src="https://raw.githubusercontent.com/ashishtheapexian/ontoor_images/master/apex_data_parser_json/APEX_DATA_PARSOR_JSON.png"/></p>

---

## INTRODUCTION JSON 

### What data type to choose?

JSON objects are strings, and are treated like this in an Oracle database. If we want to include a column with JSON data into a table, there are several data types we can choose from:

- VARCHAR2(4000) / VARCHAR2(32767)
- CLOB
- BLOB

### Valid JSON Data Types
- String
- Number
- OBject
- Array
- Boolean
- Null

### JSON OBJECT 

JSON objects are written in key/value pairs. Keys must be strings, and values must be a valid JSON data type (string, number, object, array, boolean or null).Keys and values are separated by a colon. Each key/value pair is separated by a comma.

JSON objects are surrounded by curly braces {}

<p align="center"><img src="https://cdn.crunchify.com/wp-content/uploads/2012/10/json-object.gif"/></p>

### JSON ARRAY

Arrays in JSON are used to organize a collection of related items (Which could be JSON objects). Array values must be of type string, number, object, array, boolean or null

JSON arrays are surrounded by square brackets [].

<p align="center"><img src="https://cdn.crunchify.com/wp-content/uploads/2012/10/json-array.gif"/></p>

<p align="center"><img src="https://cdn.crunchify.com/wp-content/uploads/2012/10/json-value.gif"/></p>

### BASIC CONTRUCTS

``` JSON
{
  "actors": [
    {
      "name": "Tom Cruise",
      "age": 56,
      "Born At": "Syracuse, NY",
      "Birthdate": "July 3, 1962",
      "photo": "https://jsonformatter.org/img/tom-cruise.jpg",
      "wife": null,
      "weight": 67.5,
      "hasChildren": true,
      "hasGreyHair": false,
      "children": [
        "Suri",
        "Isabella Jane",
        "Connor"
      ]
    },
    {
      "name": "Robert Downey Jr.",
      "age": 53,
      "Born At": "New York City, NY",
      "Birthdate": "April 4, 1965",
      "photo": "https://jsonformatter.org/img/Robert-Downey-Jr.jpg",
      "wife": "Susan Downey",
      "weight": 77.1,
      "hasChildren": true,
      "hasGreyHair": false,
      "children": [
        "Indio Falconer",
        "Avri Roel",
        "Exton Elias"
      ]
    }
  ]
}
```

### Overview of JSON

In SQL, you can access JSON data stored in Oracle Database using the following:

- Function `JSON_VALUE`, `JSON_QUERY`, `JSON_TABLE`.
- Conditions `JSON_EXISTS`, `IS JSON`, `IS NOT JSON`, and `JSON_TEXTCONTAINS`

## JSON Path Expression

The `$` means start at the absolute top of the JSON structure and `.actors` means move down one level to then `actors` element.

The wildcard member accessor `'.*'` gives access to all JSON object members independent from their name.

`[*]` means search in all elements of the `actors` array.

The wildcard element accessor `'[*]'` gives access to all elements in an array.

### Example

```JSON
[
  {
    "name": "John",
    "skills": ["SQL", "C#", "Azure"]
  },
  {
    "name": "Jane",
    "surname": "Doe"
  }
]
```

| Item         | Price |
|--------------|:-----:|
| $.people[0].name |  John |
| $.people[1]      | { "name": "Jane", "surname": null, "active": true } |
| $.people[1].surname |  null |

## Oracle SQL operators

- `JSON_VALUE`:  to select one scalar value in the JSON data and return it to SQL. (JSON_VALUE is the ‘bridge’ from a JSON value to a SQL value).
- `JSON_EXISTS`: a Boolean operator typically used in the WHERE clause to filter rows based on properties in the JSON data.
- `JSON_QUERY`: an operator to select (scalar or complex) value in the JSON data. In contrast to JSON_VALUE which always returns one scalar value, JSON_QUERY returns a nested JSON fragment (object or array). With JSON_QUERY a user can also select multiple values and have them wrapped inside a JSON array.
- `JSON_TABLE`: the most powerful operator that exposes JSON data as a relational view. With JSON_TABLE you can turn your JSON data into a relational representation. 
- `IS [NOT] JSON`: checks if the document is josn or not.

### Call Parameters

```SQL
data is [not] json
```

```SQL
JSON_EXISTS(data, $path  ON_ERROR)
```

```SQL
JSON_TEXTCONTAINS(column, $PATH, searchstring)
```

```SQL
JSON_QUERY(data, $PATH returning query_wrapper ON_ERROR)
```

```SQL
JSON_TABLE(data, $PATH returning ON_ERROR COLUMNS columnlist)
```

```SQL
JSON_VALUE(data, $PATH returning ON_ERROR)
```

## Examples

```SQL
-- json_doc
{
    "PONumber": 2286,
    "Reference": "ABANDA-20140803",
    "Requestor": "Amit Banda",
    "User": "ABANDA",
    "CostCenter": "A80",
    "ShippingInstructions": {
        "name": "Amit Banda",
        "Address": {
            "street": "Magdalen Centre, The Isis Science Park",
            "city": "Oxford",
            "county": "Oxon.",
            "postcode": "OX9 9ZB",
            "country": "United Kingdom"
        },
        "Phone": [
            {
                "type": "Office",
                "number": "861-555-4886"
            }
        ]
    },
    "Special Instructions": "Hand Carry",
    "LineItems": [
        {
            "ItemNumber": 1,
            "Part": {
                "Description": "Cookie's Fortune",
                "UnitPrice": 19.95,
                "UPCCode": 44004499323
            },
            "Quantity": 4.0
        }, {
            "ItemNumber": 2,
            "Part": {
                "Description": "A Bright Shining Lie",
                "UnitPrice": 19.95,
                "UPCCode": 26359122026
            },
            "Quantity": 4.0
        }, {
            "ItemNumber": 3,
            "Part": {
                "Description": "Karaoke: 25 Song Country Library Vol.1 201",
                "UnitPrice": 19.95,
                "UPCCode": 13023006096
            },
            "Quantity": 7.0
        }, {
            "ItemNumber": 4,
            "Part": {
                "Description": "Red Skelton: Lost Episodes",
                "UnitPrice": 19.95,
                "UPCCode": 18713811172
            },
            "Quantity": 4.0
        }, {
            "ItemNumber": 5,
            "Part": {
                "Description": "Stealing Home",
                "UnitPrice": 19.95,
                "UPCCode": 85391181828
            },
            "Quantity": 9.0
        }
    ]
}


CREATE TABLE PURCHASEORDER_MASTER(
    PO_NUMBER        NUMBER(10),
    REQUESTOR        VARCHAR2(128 CHAR),
    USERID           VARCHAR2(10 CHAR),
    COSTCENTER       VARCHAR2(16),
    SHIP_TO_NAME     VARCHAR2(20 CHAR),
    SHIP_TO_STREET   VARCHAR2(38 CHAR),
    SHIP_TO_CITY     VARCHAR2(32 CHAR),
    SHIP_TO_COUNTY   VARCHAR2(32 CHAR),
    SHIP_TO_POSTCODE VARCHAR2(32 CHAR),
    SHIP_TO_STATE    VARCHAR2(2 CHAR),
    SHIP_TO_PROVINCE VARCHAR2(2 CHAR),
    SHIP_TO_ZIP      VARCHAR2(8 CHAR),
    SHIP_TO_COUNTRY  VARCHAR2(32 CHAR),
    SHIP_TO_PHONE    VARCHAR2(24 CHAR),
    INSTRUCTIONS     VARCHAR2(2048 CHAR)
);

CREATE TABLE PURCHASEORDER_LINEITEM(
    PO_NUMBER      NUMBER(10),
    ITEMNO         NUMBER(38),
    DESCRIPTION    VARCHAR2(256 CHAR),
    UPCCODE        VARCHAR2(14 CHAR),
    QUANTITY       NUMBER(12,4),
    UNITPRICE      NUMBER(14,2)
);

INSERT ALL 
  WHEN (SEQ# = 1) -- Only for the first row output by JSON_TABLE
  THEN INTO PURCHASEORDER_MASTER(
      PO_NUMBER,
      REQUESTOR,
      USERID,
      COSTCENTER,
      SHIP_TO_NAME,
      SHIP_TO_STREET,
      SHIP_TO_CITY,
      SHIP_TO_COUNTY,
      SHIP_TO_POSTCODE,
      SHIP_TO_STATE,
      SHIP_TO_PROVINCE,
      SHIP_TO_ZIP,
      SHIP_TO_COUNTRY,
      SHIP_TO_PHONE,
      INSTRUCTIONS) VALUES (
      PO_NUMBER,
      REQUESTOR,
      USERID,
      COSTCENTER,
      SHIP_TO_NAME,
      SHIP_TO_STREET,
      SHIP_TO_CITY,
      SHIP_TO_COUNTY,
      SHIP_TO_POSTCODE,
      SHIP_TO_STATE,
      SHIP_TO_PROVINCE,
      SHIP_TO_ZIP,
      SHIP_TO_COUNTRY,
      SHIP_TO_PHONE,
      INSTRUCTIONS)
  WHEN (1=1) -- For all rows output by JSON_TABLE
  THEN INTO PURCHASEORDER_LINEITEM(
      PO_NUMBER,
      ITEMNO,
      DESCRIPTION,
      UPCCODE,
      QUANTITY,
      UNITPRICE) VALUES(
      PO_NUMBER,
      ITEMNO,
      DESCRIPTION,
      UPCCODE,
      QUANTITY,
      UNITPRICE
      )
  SELECT *
    FROM JSON_TABLE(BFILENAME(json_doc, '$' 
      COLUMNS(
          PO_NUMBER        NUMBER(10)           path '$.PONumber',
          REFERENCE        VARCHAR2(30 CHAR)    path '$.Reference',
          REQUESTOR        VARCHAR2(128 CHAR)   path '$.Requestor',
          USERID           VARCHAR2(10 CHAR)    path '$.User',
          COSTCENTER       VARCHAR2(16)         path '$.CostCenter',
          SHIP_TO_NAME     VARCHAR2(20 CHAR)    path '$.ShippingInstructions.name',
          SHIP_TO_STREET   VARCHAR2(32 CHAR)    path '$.ShippingInstructions.Address.street',
          SHIP_TO_CITY     VARCHAR2(32 CHAR)    path '$.ShippingInstructions.Address.city',
          SHIP_TO_COUNTY   VARCHAR2(32 CHAR)    path '$.ShippingInstructions.Address.county',
          SHIP_TO_POSTCODE VARCHAR2(10 CHAR)    path '$.ShippingInstructions.Address.postcode',
          SHIP_TO_STATE    VARCHAR2(2 CHAR)     path '$.ShippingInstructions.Address.state',
          SHIP_TO_PROVINCE VARCHAR2(2 CHAR)     path '$.ShippingInstructions.Address.province',
          SHIP_TO_ZIP      VARCHAR2(8 CHAR)     path '$.ShippingInstructions.Address.zipCode',
          SHIP_TO_COUNTRY  VARCHAR2(32 CHAR)    path '$.ShippingInstructions.Address.country',
          SHIP_TO_PHONE    VARCHAR2(24 CHAR)    path '$.ShippingInstructions.Phones[0].number',
          INSTRUCTIONS     VARCHAR2(2048 CHAR)  path '$.SpecialInstructions',
          NESTED PATH '$.LineItems[*]'
          COLUMNS(
              SEQ#             for ordinality,
              ITEMNO         NUMBER(38)           path '$.ItemNumber',
              DESCRIPTION    VARCHAR2(256 CHAR)   path '$.Part.Description',
              UPCCODE        VARCHAR2(14 CHAR)    path '$.Part.UPCCode',
              QUANTITY       NUMBER(12,4)         path '$.Quantity',
              UNITPRICE      NUMBER(14,2)         path '$.Part.UnitPrice'
         )
     )
);

```

```SQL
-- json_doc
{
   "page_count":2,
   "page_number":1,
   "page_size":30,
   "total_records":35,
   "meetings":[
      {
         "uuid":"c7v0ox8sT8+u33386prZjg==",
         "id":465763888,
         "host_id":"P6vsOBBd333nEC-X58lE7w",
         "topic":"PL/SQL Office Hours",
         "type":2,
         "start_time":"2018-01-19T17:38:11Z",
         "duration":30,
         "timezone":"America/Chicago",
         "created_at":"2018-01-19T17:38:11Z",
         "join_url":"https://oracle.zoom.us/j/111222333"
      },
      ...
      {
         "uuid":"dn7myRyBTd555t1+2GMsQA==",
         "id":389814840,
         "host_id":"P6vsOBBd555nEC-X58lE7w",
         "topic":"Real Application Clusters Office Hours",
         "type":2,
         "start_time":"2018-03-28T19:00:00Z",
         "duration":60,
         "timezone":"UTC",
         "created_at":"2018-01-24T16:33:46Z",
         "join_url":"https://oracle.zoom.us/j/444555666"
      }
   ]
}

-- create table 
CREATE TABLE dg_zoom_meetings
(
   account_name   VARCHAR2 (100),
   uuid           VARCHAR2 (100),
   id             VARCHAR2 (100),
   host_id        VARCHAR2 (100),
   topic          VARCHAR2 (100),
   TYPE           VARCHAR2 (100),
   start_time     VARCHAR2 (100),
   duration       VARCHAR2 (100),
   timezone       VARCHAR2 (100),
   created_at     VARCHAR2 (100),
   join_url       VARCHAR2 (100),
   created_on     DATE
);

-- Insert table
INSERT INTO dg_zoom_meetings (account_name,
                              uuid,
                              id,
                              host_id,
                              topic,
                              TYPE,
                              start_time,
                              duration,
                              timezone,
                              created_at,
                              join_url,
                              created_on)
   SELECT account_in,
          uuid,
          id,
          host_id,
          topic,
          TYPE,
          start_time,
          duration,
          timezone,
          created_at,
          join_url,
          SYSDATE
    FROM DUAL, 
    JSON_TABLE (json_doc,'$.meetings[*]'
    COLUMNS (
        uuid VARCHAR2 ( 100 ) PATH '$.uuid',
        id VARCHAR2 ( 100 ) PATH '$.id',
        host_id VARCHAR2 ( 100 ) PATH '$.host_id',
        topic VARCHAR2 ( 100 ) PATH '$.topic',
        type VARCHAR2 ( 100 ) PATH '$.type',
        start_time VARCHAR2 ( 100 ) PATH '$.start_time',
        duration VARCHAR2 ( 100 ) PATH '$.duration',
        timezone VARCHAR2 ( 100 ) PATH '$.timezone',
        created_at VARCHAR2 ( 100 ) PATH '$.created_at',
        join_url VARCHAR2 ( 100 ) PATH '$.join_url'
    )
);
```

```SQL
-- create table
CREATE TABLE XXGT_DEPARTMENTS
 (
   department_id   NUMBER(4) not null,
   department_name VARCHAR2(30) not null,
   manager_id      NUMBER(6),
   location_id     NUMBER(4)
 );
 
 -- Insert data
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (10, 'Administration', 200, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (20, 'Marketing', 201, 1800);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (30, 'Purchasing', 114, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (40, 'Human Resources', 203, 2400);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (50, 'Shipping', 121, 1500);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (60, 'IT', 103, 1400);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (70, 'Public Relations', 204, 2700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (80, 'Sales', 145, 2500);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (90, 'Executive', 100, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (100, 'Finance', 108, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (110, 'Accounting', 205, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (120, 'Treasury', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (130, 'Corporate Tax', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (140, 'Control And Credit', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (150, 'Shareholder Services', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (160, 'Benefits', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (170, 'Manufacturing', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (180, 'Construction', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (190, 'Contracting', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (200, 'Operations', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (210, 'IT Support', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (220, 'NOC', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (230, 'IT Helpdesk', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (240, 'Government Sales', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (250, 'Retail Sales', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (260, 'Recruiting', null, 1700);
 insert into XXGT_DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 values (270, 'Payroll', null, 1700);
 COMMIT;

-- script PL/SQL
DECLARE
   l_query VARCHAR2(4000);
   l_json  CLOB;
 BEGIN
 l_query := 'SELECT department_id   AS "departmentId",
                      department_name as "departmentName",
                      manager_id      as "managerId",
                      location_id     as "locationId"
                 FROM DEPARTMENTS';
 l_json := json_util_pkg.sql_to_json(l_query);
 dbms_output.put_line(l_json);
 END;

-- json_doc result set
{
    "ROWSET":[
       {
          "departmentId":10,
          "departmentName":"Administration",
          "managerId":200,
          "locationId":1700
       },
       {
          "departmentId":20,
          "departmentName":"Marketing",
          "managerId":201,
          "locationId":1800
       },
       {
          "departmentId":30,
          "departmentName":"Purchasing",
          "managerId":114,
          "locationId":1700
       },
       {
          "departmentId":40,
          "departmentName":"Human Resources",
          "managerId":203,
          "locationId":2400
       },
       {
          "departmentId":50,
          "departmentName":"Shipping",
          "managerId":121,
          "locationId":1500
       },
       {
          "departmentId":60,
          "departmentName":"IT",
          "managerId":103,
          "locationId":1400
       },
       {
          "departmentId":70,
          "departmentName":"Public Relations",
          "managerId":204,
          "locationId":2700
       },
       {
          "departmentId":80,
          "departmentName":"Sales",
          "managerId":145,
          "locationId":2500
       },
       {
          "departmentId":90,
          "departmentName":"Executive",
          "managerId":100,
          "locationId":1700
       },
       {
          "departmentId":100,
          "departmentName":"Finance",
          "managerId":108,
          "locationId":1700
       },
       {
          "departmentId":110,
          "departmentName":"Accounting",
          "managerId":205,
          "locationId":1700
       },
       {
          "departmentId":120,
          "departmentName":"Treasury",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":130,
          "departmentName":"Corporate Tax",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":140,
          "departmentName":"Control And Credit",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":150,
          "departmentName":"Shareholder Services",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":160,
          "departmentName":"Benefits",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":170,
          "departmentName":"Manufacturing",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":180,
          "departmentName":"Construction",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":190,
          "departmentName":"Contracting",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":200,
          "departmentName":"Operations",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":210,
          "departmentName":"IT Support",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":220,
          "departmentName":"NOC",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":230,
          "departmentName":"IT Helpdesk",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":240,
          "departmentName":"Government Sales",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":250,
          "departmentName":"Retail Sales",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":260,
          "departmentName":"Recruiting",
          "managerId":null,
          "locationId":1700
       },
       {
          "departmentId":270,
          "departmentName":"Payroll",
          "managerId":null,
          "locationId":1700
       }
    ]
 }
```

## JSON Templates

```JSON
    "income": "15Rs",
    "country": "India",
    "area": "abc",
    "day": "Monday",
    "month": "april"
  },
  {
    "name": "Ram",
    "email": "ram@gmail.com",
    "age": 23,
    "income": "10Rs",
    "country": "India",
    "area": "abc",
    "day": "Monday",
    "month": "april"
  },
  {
    "name": "Shyam",
    "email": "shyam23@gmail.com",
    "age": 28,
    "income": "30Rs",
    "country": "India",
    "area": "abc",
    "day": "Monday",
    "month": "april"
  },
  {
    "name": "John",
    "email": "john@gmail.com",
    "age": 33,
    "income": "15Rs",
    "country": "India",
    "area": "abc",
    "day": "Monday",
    "month": "april"
  }
]
```

```JSON
{  
   "root":[  
      {  
         "kind":"person",
         "fullName":"John Doe",
         "age":22,
         "gender":"Male",
         "phoneNumber":{  
            "areaCode":"206",
            "number":"1234567"
         },
         "children":[  
            {  
               "name":"Jane",
               "gender":"Female",
               "age":"6"
            },
            {  
               "name":"John",
               "gender":"Male",
               "age":"15"
            }
         ],
         "citiesLived":[  
            {  
               "place":"Seattle",
               "yearsLived":[  
                  "1995"
               ]
            },
            {  
               "place":"Stockholm",
               "yearsLived":[  
                  "2005"
               ]
            }
         ]
      },
      {  
         "kind":"person",
         "fullName":"Mike Jones",
         "age":35,
         "gender":"Male",
         "phoneNumber":{  
            "areaCode":"622",
            "number":"1567845"
         },
         "children":[  
            {  
               "name":"Earl",
               "gender":"Male",
               "age":"10"
            },
            {  
               "name":"Sam",
               "gender":"Male",
               "age":"6"
            },
            {  
               "name":"Kit",
               "gender":"Male",
               "age":"8"
            }
         ],
         "citiesLived":[  
            {  
               "place":"Los Angeles",
               "yearsLived":[  
                  "1989",
                  "1993",
                  "1998",
                  "2002"
               ]
            },
            {  
               "place":"Washington DC",
               "yearsLived":[  
                  "1990",
                  "1993",
                  "1998",
                  "2008"
               ]
            },
            {  
               "place":"Portland",
               "yearsLived":[  
                  "1993",
                  "1998",
                  "2003",
                  "2005"
               ]
            },
            {  
               "place":"Austin",
               "yearsLived":[  
                  "1973",
                  "1998",
                  "2001",
                  "2005"
               ]
            }
         ]
      },
      {  
         "kind":"person",
         "fullName":"Anna Karenina",
         "age":45,
         "gender":"Female",
         "phoneNumber":{  
            "areaCode":"425",
            "number":"1984783"
         },
         "citiesLived":[  
            {  
               "place":"Stockholm",
               "yearsLived":[  
                  "1992",
                  "1998",
                  "2000",
                  "2010"
               ]
            },
            {  
               "place":"Russia",
               "yearsLived":[  
                  "1998",
                  "2001",
                  "2005"
               ]
            },
            {  
               "place":"Austin",
               "yearsLived":[  
                  "1995",
                  "1999"
               ]
            }
         ]
      }
   ]
}
```



