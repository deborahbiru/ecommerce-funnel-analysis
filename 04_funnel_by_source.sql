-- Funnel and conversion rate by traffic source
SELECT
  traffic_source,
  COUNT(DISTINCT session_id) AS sessions,
  COUNT(DISTINCT IF(event_type = 'cart', session_id, NULL)) AS added_to_cart,
  COUNT(DISTINCT IF(event_type = 'purchase', session_id, NULL)) AS purchased,
  ROUND(COUNT(DISTINCT IF(event_type = 'purchase', session_id, NULL))
        / COUNT(DISTINCT session_id) * 100, 1) AS conversion_pct
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY traffic_source
ORDER BY conversion_pct DESC;
