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

## JSON Path Expression

The `$` means start at the absolute top of the JSON structure and `.actors` means move down one level to then `actors` element.

The wildcard member accessor `'.*'` gives access to all JSON object members independent from their name.

`[*]` means search in all elements of the `actors` array.

The wildcard element accessor `'[*]'` gives access to all elements in an array.

## Oracle SQL operators

- `JSON_VALUE`:  to select one scalar value in the JSON data and return it to SQL. (JSON_VALUE is the ‘bridge’ from a JSON value to a SQL value).
- `JSON_EXISTS`: a Boolean operator typically used in the WHERE clause to filter rows based on properties in the JSON data.
- `JSON_QUERY`: an operator to select (scalar or complex) value in the JSON data. In contrast to JSON_VALUE which always returns one scalar value, JSON_QUERY returns a nested JSON fragment (object or array). With JSON_QUERY a user can also select multiple values and have them wrapped inside a JSON array.
- `JSON_TABLE`: the most powerful operator that exposes JSON data as a relational view. With JSON_TABLE you can turn your JSON data into a relational representation. 
