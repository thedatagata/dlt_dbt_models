


SELECT 
     s.user_id
    , MIN(IF(s.session_is_first_visit = True, s.session_date, null)) AS user_first_session_date
    , MIN(IF(s.session_is_first_visit = True, s.session_marketing_channel, null)) AS user_first_session_marketing_channel 
    , MIN(IF(s.session_is_first_visit = True, s.session_source, null)) AS user_first_session_source
    , MIN(IF(s.session_is_first_visit = True, s.session_medium, null)) AS user_first_session_medium 
    , MAX(s.session_date) AS user_last_session_date 
    , DATE_DIFF('day', MAX(s.session_date), CURRENT_DATE) AS user_recency_days
    , COUNT(DISTINCT s.session_id) AS user_session_cnt 
    , SUM(IF(s.session_is_mobile = True, 1, 0)) AS user_mobile_session_cnt
    , SUM(IF(s.session_is_mobile = False, 1, 0)) AS user_browser_session_cnt
    , SUM(s.session_pageview_cnt) AS user_pageview_cnt
    , SUM(s.session_order_cnt) AS user_order_cnt
    , SUM(s.session_revenue) AS user_order_revenue
    , SUM(s.session_total_revenue) AS user_total_revenue
    , SUM(s.session_duration) AS user_total_time_on_site
    , AVG(s.session_duration) AS user_avg_time_on_site
    
FROM {{ ref('src_sessions_fct') }} s 
GROUP BY 1 

