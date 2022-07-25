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



