-- 2. customer_analysis.sql
-- Purpose: Understand one-time vs. repeat buying behavior,
--          and see how each group contributes to monthly orders.

-- a) Classify customers by whether they ordered more than once
WITH customer_order_counts AS (
  SELECT
    customer_id,
    COUNT(*)   AS order_count
  FROM customer_orders
  GROUP BY customer_id
)
SELECT
  CASE
    WHEN order_count > 1 THEN 'repeat'
    ELSE 'one-time'
  END                                 AS "Customer Segment",
  COUNT(*)                            AS "Number of Customers"
FROM customer_order_counts
GROUP BY 1;


-- b) Track monthly orders for each segment
WITH customer_segments AS (
  SELECT
    customer_id,
    CASE
      WHEN COUNT(*) > 1 THEN 'repeat'
      ELSE 'one-time'
    END                                AS segment
  FROM customer_orders
  GROUP BY customer_id
)
SELECT
  DATE_TRUNC('month', o.order_date)   AS "Month",
  s.segment                           AS "Customer Segment",
  COUNT(*)                            AS "Orders This Month"
FROM customer_orders o
JOIN customer_segments s
  ON o.customer_id = s.customer_id
GROUP BY 1, 2
ORDER BY 1, 2;
