-- 4. order_details_report.sql
-- Purpose: A single, flat report combining order info with its payment details

SELECT
  o.order_id                          AS "Order ID",
  o.customer_id                       AS "Customer ID",
  o.order_date                        AS "Order Date",
  o.order_status                      AS "Order Status",
  o.order_amount                      AS "Order Amount",
  p.payment_status                    AS "Payment Status",
  p.payment_method                    AS "Payment Method",
  p.payment_date                      AS "Payment Date",
  p.payment_amount                    AS "Payment Amount"
FROM customer_orders o
LEFT JOIN payments p
  USING (order_id)                   -- brings in payment rows if they exist
ORDER BY o.order_date DESC;          -- newest orders at the top
