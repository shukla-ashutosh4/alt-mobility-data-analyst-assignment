-- 1. order_sales_analysis.sql
-- Purpose: See how many orders we have in each status, 
--          and how much revenue each status represents.

-- a) Breakdown by order status
SELECT
  order_status                              AS "Order Status",       -- e.g. 'completed', 'cancelled'
  COUNT(*)                                  AS "Number of Orders",   -- total orders in that status
  SUM(order_amount)                         AS "Total Revenue"       -- sum of money from those orders
FROM customer_orders
GROUP BY order_status
ORDER BY "Total Revenue" DESC;                                     -- highest‐revenue statuses first


-- b) Month‐by‐month revenue trend
SELECT
  DATE_TRUNC('month', order_date)           AS "Month",               -- first day of each month
  COUNT(*)                                  AS "Orders Placed",       -- how many orders that month
  SUM(order_amount)                         AS "Revenue"              -- total sales that month
FROM customer_orders
GROUP BY 1
ORDER BY 1;                                                       -- chronological order
