with europe as(
    select *
    from gmd
    where lower(iso3) in (
        'aut','bel','bgr','cyp','cze','deu',
        'dnk','esp','est','fin','fra','fra',
        'grc','hrv','hun','irl','ita','ita',
        'ltu','lux','lva','mlt','nld','pol',
        'prt','rou','svk','svn','swe'
        )
),

highest_gdp as (
    select
        countryname as countries,
        sum(ngdp_usd) as total_gdp_usd_billions
    from europe 
    where 1=1
        and ngdp_usd is not null 
        and ngdp_usd > 0
    group by 1
)

select *
from highest_gdp
order by total_gdp_usd_billions desc
limit ${inputs.limit_button}


