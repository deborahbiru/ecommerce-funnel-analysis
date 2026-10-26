-- Orders, revenue, and return rate by product category
SELECT
  p.category,
  COUNT(DISTINCT oi.order_id) AS orders,
  ROUND(SUM(IF(oi.status NOT IN ('Cancelled', 'Returned'), oi.sale_price, 0)), 0) AS revenue,
  ROUND(COUNTIF(oi.status = 'Returned') / COUNT(*) * 100, 1) AS return_rate_pct
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
GROUP BY p.category
ORDER BY revenue DESC;
