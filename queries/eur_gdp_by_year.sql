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
)

select
    countryname as countries,
    year,
    sum(ngdp_usd) as total_gdp_usd_billions
from europe 
where 1=1
    and ngdp_usd is not null 
    and ngdp_usd > 0
group by 1,2
order by year