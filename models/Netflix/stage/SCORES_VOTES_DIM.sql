{{ config(
    pre_hook="ALTER SESSION SET QUOTED_IDENTIFIERS_IGNORE_CASE = true",
    post_hook="GRANT SELECT ON TABLE {{ this }} TO ROLE ACCOUNTADMIN"
    
) }}

SELECT
ID
,IMDB_ID
,IMDB_SCORE
,IMDB_VOTES
,TMDB_POPULARITY
,TMDB_SCORE
FROM
{{ source('Netflix','TITLES')}}
