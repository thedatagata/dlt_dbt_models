WITH 
    raw_sessions_deduped
      AS 
        (
          {{ dbt_utils.deduplicate(
            relation=source('src_google_analytics', 'src_ga_sessions_fct'),
            partition_by='user_id, session_id',
            order_by="session_start_time desc",
            )
          }}
        ) 
SELECT 
    s.session_id 
  , s.session_start_time 
  , s.session_sequence_number 
  , s.user_id 
  , CAST(s.session_date AS DATE) AS session_date
  , s.session_pageview_cnt
  , s.session_order_cnt 
  , s.session_revenue 
  , s.session_total_revenue
  , s.session_is_first_visit
  , s.session_duration
  , s.session_browser
  , s.session_os 
  , s.session_is_mobile 
  , s.session_device_category
  , s.session_source 
  , s.session_medium 
  , s.session_marketing_channel 
  , s.session_city 
  , s.session_region 
  , s.session_country
FROM raw_sessions_deduped s