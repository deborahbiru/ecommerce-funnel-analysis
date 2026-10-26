-- Repeat purchase rate and average days between a customer's 1st and 2nd order
WITH user_orders AS (
  SELECT
    user_id,
    created_at,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at) AS order_num,
    LAG(created_at) OVER (PARTITION BY user_id ORDER BY created_at) AS prev_order_at
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  WHERE status NOT IN ('Cancelled', 'Returned')
)
SELECT
  COUNT(DISTINCT user_id) AS buyers,
  COUNT(DISTINCT IF(order_num = 2, user_id, NULL)) AS repeat_buyers,
  ROUND(COUNT(DISTINCT IF(order_num = 2, user_id, NULL)) / COUNT(DISTINCT user_id) * 100, 1) AS repeat_rate_pct,
  ROUND(AVG(IF(order_num = 2, TIMESTAMP_DIFF(created_at, prev_order_at, DAY), NULL)), 0) AS avg_days_to_2nd_order
FROM user_orders;
