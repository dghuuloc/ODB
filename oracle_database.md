# <p align="center">ORACLE DATABASE</p>
---
## INSERT INTO SELECT


```SQL
INSERT INTO table_name (column1, column2, ... column_n )
SELECT expression1, 
       expression2, 
       
       ... expression_n
FROM source_table
[WHERE conditions];
```
For Example,

```SQL
-- CREATING TABLE
CREATE TABLE members (
    member_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    rank VARCHAR2(20)
);

-- LOAD DATA INTO TABLE
DECLARE 
    json_doc CLOB := '{
        "members":[{
            "member_id":1,
            "first_name":"Abel",
            "last_name":"Wolf",
            "rank":"Gold"
        }, {
            "member_id":2,
            "first_name":"Clarita",
            "last_name":"Fanco",
            "rank":"Platinum"
        }, {
            "member_id":3,
            "first_name":"Darrly",
            "last_name":"Giles",
            "rank":"Silver"
        }, {
            "member_id":4,
            "first_name":"Dorthea",
            "last_name":"Suarez",
            "rank":"Silver"
        }, {
            "member_id":5,
            "first_name":"Katrina",
            "last_name":"Wheeler",
            "rank":"Silver"
        }, {
            "member_id":6,
            "first_name":"Lilian",
            "last_name":"Garza",
            "rank":"Silver"
        }, {
            "member_id":7,
            "first_name":"Ossie",
            "last_name":"Summers",
            "rank":"Gold"
        }, {
            "member_id":8,
            "first_name":"Paige",
            "last_name":"Mcfarland",
            "rank":"Platium"
        }, {
            "member_id":9,
            "first_name":"Ronna",
            "last_name":"Britt",
            "rank":"Platinum"
        }, {
            "member_id":10,
            "first_name":"Tressie",
            "last_name":"Short",
            "rank":"Bronze"
        }]
    }';
BEGIN
    INSERT INTO members (
        member_id,
        first_name,
        last_name,
        rank)
    SELECT 
        member_id, 
        first_name, 
        last_name, 
        rank
    FROM JSON_TABLE(json_doc,
        '$.members[*]'          -- selects all the items in the array
        COLUMNS(
            member_id PATH '$.member_id',
            first_name PATH '$.first_name',
            last_name PATH '$.last_name',
            rank PATH '$.rank')
        );
END;

-- QUERING TABLE
SELECT * FROM members;
```
