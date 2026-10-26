-- Monthly orders and revenue, excluding cancelled and returned items
SELECT
  DATE_TRUNC(DATE(created_at), MONTH) AS month,
  COUNT(DISTINCT order_id) AS orders,
  ROUND(SUM(sale_price), 2) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status NOT IN ('Cancelled', 'Returned')
GROUP BY month
ORDER BY month;
