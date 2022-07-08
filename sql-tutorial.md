## <p align="center">Oracle SQL Tutorial</p>
---

### Primary Key
---

```
CREATE TABLE table_name (
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



