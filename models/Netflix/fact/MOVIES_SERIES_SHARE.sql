{{ config(
    pre_hook="ALTER SESSION SET QUOTED_IDENTIFIERS_IGNORE_CASE = true",
    post_hook="GRANT SELECT ON TABLE {{ this }} TO ROLE ACCOUNTADMIN"  
) }}


SELECT GENRES,ROUND((TOTAL_MOVIES/TOTAL_CONTENT)*100) AS MOVIE_PERCENTAGE_SHARE
,ROUND((TOTAL_SHOWS/TOTAL_CONTENT)*100) AS SERIES_PERCENTAGE_SHARE FROM
(SELECT
REPLACE(REPLACE(UPPER(GENRES),'[',''),']','') AS GENRES
,TYPE
,SUM(CASE WHEN TITLE IS NOT NULL AND GENRES IS NOT NULL AND TYPE='MOVIE' 
    THEN 1 ELSE 0 END) AS TOTAL_MOVIES
,SUM(CASE WHEN TITLE IS NOT NULL AND GENRES IS NOT NULL AND TYPE='SHOW' 
    THEN 1 ELSE 0 END) AS TOTAL_SHOWS
,TOTAL_MOVIES+TOTAL_SHOWS AS TOTAL_CONTENT    
FROM
NETFLIX.DBT_TRANSFORM.SHOW_DETAILS_DIM
WHERE GENRES IS NOT NULL AND TYPE IS NOT NULL
GROUP BY 1,2) SUBQ

