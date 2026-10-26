-- Purchase funnel: how many sessions reach each step?
SELECT
  COUNT(DISTINCT session_id) AS all_sessions,
  COUNT(DISTINCT IF(event_type = 'product',  session_id, NULL)) AS viewed_product,
  COUNT(DISTINCT IF(event_type = 'cart',     session_id, NULL)) AS added_to_cart,
  COUNT(DISTINCT IF(event_type = 'purchase', session_id, NULL)) AS purchased
FROM `bigquery-public-data.thelook_ecommerce.events`;
