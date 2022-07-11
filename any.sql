--------------------------------------------------------------------------------------
-- Name	       : (Oracle Tutorial) Sample Database
-- Version     : 1.0
-- Last Updated: July-04-2022
-- Copyright   : Copyright © 2022 by dghuuloc. All Rights Reserved.
-- Notice      : Use this sample database for the educational purpose only.

--------------------------------------------------------------------------------------
--------------------------------------------------------------------
-- Using ANY
--------------------------------------------------------------------

SELECT
  product_name,
  list_price
FROM
  products
WHERE
  list_price > ANY (
    SELECT
      list_price
    FROM
      products
    WHERE
      category_id = 1
  )
ORDER BY product_name;

--------------------------------------------------------------------
-- Transform ANY to EXITS
--------------------------------------------------------------------
SELECT
  product_name,
  list_price
FROM
  products p1
WHERE
  EXISTS(
    SELECT
      list_price
    FROM
      products p2    
    WHERE
      category_id = 1 AND p1.list_price > p2.list_price
  )

ORDER BY product_name;
