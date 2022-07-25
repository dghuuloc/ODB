# <p align="center">PARSING JSON IN PL/SQL</p>

<p align="center"><img src="https://raw.githubusercontent.com/ashishtheapexian/ontoor_images/master/apex_data_parser_json/APEX_DATA_PARSOR_JSON.png"/></p>

---

## Oracle SQL operators

- `JSON_VALUE`:  to select one scalar value in the JSON data and return it to SQL. (JSON_VALUE is the ‘bridge’ from a JSON value to a SQL value).
- `JSON_EXISTS`: a Boolean operator typically used in the WHERE clause to filter rows based on properties in the JSON data.
- `JSON_QUERY`: an operator to select (scalar or complex) value in the JSON data. In contrast to JSON_VALUE which always returns one scalar value, JSON_QUERY returns a nested JSON fragment (object or array). With JSON_QUERY a user can also select multiple values and have them wrapped inside a JSON array.
- `JSON_TABLE`: the most powerful operator that exposes JSON data as a relational view. With JSON_TABLE you can turn your JSON data into a relational representation. 
