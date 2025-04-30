-- 3. payment_status_analysis.sql
-- Purpose: Measure how often payments succeed vs. fail, 
--          and see if failure rates change over time.

-- a) Overall success/failure breakdown
SELECT
  payment_status                      AS "Payment Status",          -- e.g. 'success', 'failed'
  COUNT(*)                            AS "Count",
  ROUND(
    100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
    2
  )                                   AS "Percent of All Payments"  -- percentage share
FROM payments
GROUP BY payment_status;


-- b) Failures by month
SELECT
  DATE_TRUNC('month', payment_date)   AS "Month",
  COUNT(*) FILTER (WHERE payment_status <> 'success')
                                      AS "Failed Payments",         -- number of failed transactions
  COUNT(*)                           AS "Total Payments"
FROM payments
GROUP BY 1
ORDER BY 1;
