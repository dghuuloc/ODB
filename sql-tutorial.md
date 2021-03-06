# <p align="center">Oracle Database Intro to SQL</p>
---

<p align="center"><img src="https://flexagon.com/wp-content/uploads/2022/05/Oracle-APEX_illustration-01.svg"/></p>

---

<!--## <img src="https://pdjmaster.files.wordpress.com/2020/04/oracle-database.png" width="80" height="80"> Introduction to Oracle Database -->

## 💡 Introduction to SQL

### What is Table?
A table consists of rows and columns used to organize data to store and display records in a structured format. It is similar to worksheets in the spreadsheet application. It occupies space on our systems. We need three things to create a table:

- Table name
- Columns/Fields name
- Definitions for each field

<p align="center"><img src="https://www.w3resource.com/w3r_images/component-of-a-database-table.gif"/></p>

__The component of table__

- `fields [columns]` - The information of a table stored in some heads, those are fields or columns. Columns show vertically in a table.
- `column name` - Each field or column has an individual name. A table cannot contain the same name of two different columns.
- `record [row]` - All the columns in a table make a row. Each row contains all the information of individual topics.
- `column value` - The value of each field makes a row is the column value.
- `key field` - Each table should contain a field which can create a link with another one or more table is the key field of a table.

### Command Description
Here are some commads that we will be learning about, and later practicing as well.

- `CREATE` - Creates anew table, a view of atable, or another object in the database.
- `ALTER` - Modifies an existing database object, such as a table. 
- `DROP` - Deletes an entire table, a view of a table or other objects in the database.
- `SELECT` - Retrieves certain records from one or more tables.
- `INSERT` - Creates a record.
- `UPDATE` - Modifies a record.
- `DELETE` - Deletes a record.
- `GRANT` - Gives a privilege to users
- `REVOKE` - Takes back privileges granted from users.

### SELECT Statement
---
To retrieve data from one or more columns of a table, yuou use the `SELECT` statement with the following syntax:

```
SELECT
  column_list
FROM
  table_name;
```
In this `SELECT` statement:

- First, specify the table name from which you want to query the data.
- Second, indicate the columns from which you want to return the data. If you have more than one column, you need to separate each by a comma (,).

Note that the `SELECT` statement is very complex that consists of many clauses such as `ORDER BY`, `GROUP BY`, `HAVING`, `JOIN`. To make it simple, in this tutorial, we are focusing on the SELECT and FROM clauses only.

### ORDER BY clause
---

To sort dat in either ascending or descending order, we can add the `ORDER BY` clause to the `SELECT` statement as follows:

```
SELECT
  column_list
  ...
FROM
  table_name
ORDER BY
  column [ASC | DESC] [NULLS FIRST | NULLS LAST]
```
To sort the result set by a column, you list that column after the `ORDER BY` clause.

Following the column name is a sort order that can be:

- `ASC` for sorting in ascending order
- `DESC` for sorting in descending order

By default, the `ORDER BY` clause sorts rows in ascending order whether you specify `ASC` or not. If you want to sort rows in descending order, you use `DESC` explicitly.

`NULLS FIRST` places NULL values before non-NULL values and `NULLS LAST` puts the NULL values after non-NULL values.

### SELECT DISTINCT statement
---

The `DISTINCT` clause is used in a `SELECT` statement to filter duplicate rows in the result set. It ensures that rows returned are unique for the column or columns specified in the `SELECT` clause.

The following illustrates the syntax of the `SELECT DISTINCT` statement:

```
SELECT DISTRINCT column_list
FROM table_name;
```

### WHERE clause
---

The WHERE clause specifies a search condition for rows returned by the `SELECT` statement. The following illustrates the syntax of the `WHERE` clause:

```
SELECT 
  select_list
FROM
  table_name
WHERE
  search_condition
ORDER BY
  sort_expression;
```

The `WHERE` clause appears after the `FROM` clause but before the `ORDER BY` clause. Following the `WHERE` keyword is the search_condition that defines a condition that returned rows must satisfy.

Besides the `SELECT` statement, you can use the `WHERE` clause in the `DELETE` or `UPDATE` statement to specify which rows to update or delete.

### FETCH clause
---

The following illustrates the syntax of the row limiting clause:

```
[ OFFSET offset ROWS]
FETCH NEXT [row_count | percent PERCENT] ROWS [ONLY | WITH TIES] 
```

__OFFSET clause__

The OFFSET clause specifies the number of rows to skip before the row limiting starts. The OFFSET clause is optional. If you skip it, then offset is 0 and row limiting starts with the first row.

The offset must be a number or an expression that evaluates to a number. The offset is subjected to the following rules:

- If the offset is negative, then it is treated as 0.
- If the offset is NULL or greater than the number of rows returned by the query, then no row is returned.
- If the offset includes a fraction, then the fractional portion is truncated.

__FETCH clause__

The FETCH clause specifies the number of rows or percentage of rows to return.

For the semantic clarity purpose, you can use the keyword ROW instead of ROWS, FIRST instead of  NEXT. For example, the following clauses behavior the same

```
FETCH NEXT 1 ROWS
FETCH FIRST 1 ROW
```

__ONLY | WITH TIES__

The ONLY returns exactly the number of rows or percentage of rows after FETCH NEXT (or FIRST).

The WITH TIES returns additional rows with the same sort key as the last row fetched. Note that if you use WITH TIES, you must specify an ORDER BY clause in the query. If you don’t, the query will not return the additional rows.

### Primary Key
---

```
CREATE TABLE table_name (
  id NUMBER GENERATED BY DEFAULT AS IDENTITY,
  id NUMBER PRIMARY KEY,
  ---or
  
  PRIMARY KEY (id, ...)
  
  --- or 
  
  CONTRAINT pk_table_name PRIMARY KEY (id)
  
);

```

### Foreign key

```
CREATE TABLE table_name (
  FOREIGN KEY(id) REFERENCES parent_table_name(id)
);
```

#### __Create foreign key constraint__

```
CREATE TABLE child_table (
  ,,,
  
  CONSTRAINT fk_name
  FOREIGN KEY(col1, col2,...) REFERENCES parent_table(col1, col2,...)
  ON DELETE [CASCADE | SET NULL]
);
```

### Check Constraint

```
CREATE TABLE table_name (

column_name data_type CONSTRAINT check_constraint_name CHECK (expression)
);
```

### HAVING clause

The following illustrates the syntax of the Oracle `HAVING` clause:

```
SEELCT 
  column_list
FROM
  table_name
GROUP BY
  column_name
HAVING
  group_condition;
```

> **_NOTE:_**  The `HAVING` clause filters groups of rows while the `WHERE` clause filers rows.


### Data Manipulation Language (DML)

#### __INSERT Statement__

To insert a new row into a tablem you use the Oracle `INSERT` statement as follows:

```
INSERT INTO table_name (column_list)
  VALUES (value_list);
```

#### __INSERT INTO SELECT__

Sometimes, you waant to select data from a table and insert it into another table. To do it, you use the Oracle INSERT INTO SELECT statement as follows:

```
INSERT INTO target_table (column_list)
SELECT column_list
FROM source_table
WHERE condition;
```

The Oracle INSERT INTO SELECTstatement requires the data type of the source and target tables match.

### Oracle JOIN

Oracle join is used to combine columns from two or more tables based on values of the related columns.

Oracle supports `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN` and `CROSS JOIN`.

#### __INNER JOIN__

```
SELECT 
  *
FROM
  lef_table
INNER JOIN right_table ON join_predicate;
```
- __INNER JOIN__ with USING clause

```
SELECT 
  *
FROM
  lef_table
INNER JOIN right_table USING (column_list);
```

> **_NOTE THAT:_**  For the innner join, the condition placed in the `ON` has the same effect as it is placed in the `WHERE` clause.

#### __LEFT JOIN__

```
SELECT 
  column_list
FROM
  left_table
LEFT JOIN right_table ON 
  left_table.column_1 = right_table.column_1
  AND left_table.column_2 = right_table.column_2
  AND left_table.column_3 = right_table.column_3
  AND ...;
```

- __LEFT JOIN__ with USING clause
```
SELECT 
  column_list
FROM
  left_table
LEFT JOIN right_table USING (column_1, column_2, column_3,...);
```

#### __RIGHT JOIN__

```
SELECT 
  column_list
FROM
  left_table
RIGHT JOIN right_table ON 
  left_table.column_1 = right_table.column_1
  AND left_table.column_2 = right_table.column_2
  AND left_table.column_3 = right_table.column_3
  AND ...;
```

- __RIGHT JOIN__ with USING clause
```
SELECT 
  column_list
FROM
  left_table
RIGHT JOIN right_table USING (column_1, column_2, column_3,...);
```

#### __FULL OUTER JOIN__

```
SELECT
    select_list
FROM
    left_table
FULL OUTER JOIN right_table ON join_condition;
```

> **_NOTE THAT:_**  the `OUTER` keyword is optional, therefore, the `FULL OUTER JOIN` and `FULL JOIN` are the same. 

#### __CROSS JOIN__

```
SELECT
  column_list
FROM
  left_table
CROSS JOIN right_table
```

> **_NOTE THAT:_**  Unlinke other joins such as `INNER JOIN` or `LEFT JOIN`, `CROSS JOIN` does not have the `ON` clause with a join predicate.

#### __SEFT JOIN__

A self join is a join that joins a table with itself. A self join is useful for comparing rows within a table or querying hierarchical data.

A self join uses other joins such as inner join and left join. In addition, it uses the table alias to assign the table different names in the same query.

```
SELECT
  column_list
FROM
  table_name alias_1
<type_join> JOIN  table_name alias_2 ON join_predicate;
```

### Subquery

#### __Subquery in the SELECT clause__



#### __Subquery in the FROM cluse__

```
SELECT * FROM (subquery) [AS] inline_view;
```

#### __Subquery with comparison operators__

#### __Subquery with IN and NOT IN operators__

The subquery that uses the `IN` operator often returns a list of zero or more values. After the subquery returns the result set, the outer query makes uses of them.


### Oracle EXISTS operator

#### EXISTS operator

The EXISTS operator returns true if the subquery returns any rows, otherwise, it returns false. In addition, the EXISTS operator terminates the processing of the subquery once the subquery returns the first row.

### Oracle ANY operator

```
SELECT
    *
FROM
    table_name
WHERE
    c > ANY (
        v1,
        v2,
        v3
    );

-- transform the ANY operator

SELECT
    *
FROM
    table_name
WHERE
    c > v1
    OR c > v2
    OR c > v3;

```

### Oracle ALL operator

```
SELECT
    *
FROM
    table_name
WHERE
    c > ALL (
        v1,
        v2,
        v3
    );

--  transform the ALL operator

SELECT
    *
FROM
    table_name
WHERE
    c > v1
    AND c > v2
    AND c > v3;

```

### The order of executionfor SQL query

__Query Process Steps__

- Getting Data (_FROM, JOIN_)
- Row Filter (_WHERE_)
- Grouping (_GROUP BY_)
- Group Filter (_HAVING_)
- Retrun Expressions (_SELECT_)
- Order & Paging (_ORDER BY & LIMIT/OFFSET_)

```
SELECT [DISTINCT] <select_list>
FROM <left_table>
<join_type> JOIN <right_table>
ON <join_condition>
WHERE <where_condition>
GROUP BY <group_by_list>
HAVING <having_condition>
ORDER BY <order_by_list> [ASC/DESC]
FETCH FIRST 1 ROWS ONLY;
```

Note that the `HAVING` clause filters groups of rows while the `WHERE` clause filters rows. If you use the `HAVING` clause without the `GROUP BY` clause, the `HAVING` clause works like the `WHERE` clause.

### Aggregate Functions

- __EXTRACT()__ function to get the `YEAR` field from the order date and compare it with 2017.

```
EXTRACT(YEAR FROM order_date) = 2017
```

## References

- [Oracle Basic](https://www.oracletutorial.com/oracle-basics/)
- [Getting Started Oracle SQL Tutorial](https://way2tutorial.com/sql/tutorial.php)
- [totn SQL](https://www.techonthenet.com/sql/index.php)
- [Oracle Tutorials ](https://www.w3schools.blog/oracle-tutorial)
- [Oracle Tutorials](https://www.wikitechy.com/tutorials/oracle/)
- [SQL Tutorials](https://www.zentut.com/sql-tutorial/)
- [SQL Interview Questions](https://www.interviewbit.com/sql-interview-questions/)
- [Othes](https://www.w3resource.com/sql/tutorials.php)
- [Basic SQL Commands](https://www.freecodecamp.org/news/basic-sql-commands/)

