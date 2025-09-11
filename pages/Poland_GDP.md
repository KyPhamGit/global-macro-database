---
title: Is Poland Really Europes Next Power House?
description: Analysis of Poland GDP metrics to see if they are really the up and coming EU leader.
queries:
  - eu_gdp_data: eur_gdp_by_year.sql
  - distinct_countries: distinct_countries.sql
---
<LastRefreshed prefix="Data last updated"/>



# EU GDP Trends
This dashboard analyzes European GDP data from the Global Macro Database, showing aggregate GDP trends across all EU from a specific year of choice.


## Total Countries GDP in USD (Trillions)

<Slider
    data={eu_gdp_data}
    range=year
    title="Year Range" 
    name=year_slider
    size=full
    fmt='yyyy'
    min=1960
    showMaxMin=false
/>

<LineChart 
    data={eu_gdp_data.where(`year >= ${inputs.year_slider} `)}
    x=year
    y=total_gdp_usd_billions
    series=countries
    title="EU GDP in USD (Billions)"
    yAxisTitle="GDP (Trillions USD)"
    xAxisTitle="Year"
    yFmt="#,##0,,"
/>

```sql total_gdp_data
select 
    year,
    countries,
    total_gdp_usd_billions
from ${eu_gdp_data}
where year = 2025
order by total_gdp_usd_billions desc
limit ${inputs.limit_button}
```



## Top Ranking Countries in EU by Total GDP

<ButtonGroup name=limit_button>
    <ButtonGroupItem valueLabel="Top 5" value="5" />
    <ButtonGroupItem valueLabel="Top 10" value="10" default />
    <ButtonGroupItem valueLabel="Top 20" value="20" />
</ButtonGroup>

<DataTable 
    data={total_gdp_data}
    rows=20
>
    <Column id=year title="Year"/>
    <Column id=countries title="Countries"/>
    <Column id=total_gdp_usd_billions title="Total GDP Nominal USD (Billions)" fmt="#,##0,"/>
</DataTable>


```sql pol_gdp_comparison
with base_year as (
     select
        distinct
        year
    from gmd 
    where year <= 2025 and year >= 2005
    order by year desc
),

country_data as (
    select
        lower(iso3) as country_code,
        countryname as country,
        year,
        ngdp_usd as nominal_gdp,
        lead(ngdp_usd) over ( partition by country_code order by year desc) as prev_year_gdp,
        (nominal_gdp - prev_year_gdp) / prev_year_gdp as perc_growth
    from gmd 
    where year <= 2025 and year >= 2004
    order by year desc
),

main_tbl as (
    select
        base_year.year as year,
        poland.perc_growth as poland_perc,
        other.perc_growth as other_perc
    from base_year
    left join country_data poland
        on base_year.year = poland.year
        and poland.country_code = 'pol'
    left join country_data other
        on base_year.year = other.year
        and other.country = '${inputs.select_countries.value}'
)
    select
        year,
        poland_perc,
        other_perc,
        case 
            when other_perc < 0
            then (poland_perc/other_perc)*-1
            else (poland_perc/other_perc)
        end as pg_perc
    from main_tbl 
    order by year desc
```
## Rate of Poland Vs Another Country's GDP Growth

<Dropdown
    title="Select a Country" 
    name=select_countries
    data={distinct_countries}
    value=countryname
    defaultValue="Germany"
/>

<DataTable 
    data={pol_gdp_comparison}
    rows=21
>
    <Column id=year title="Year"/>
    <Column id=poland_perc title="Poland's GDP Growth in %" fmt="#,##0.0%" contentType=delta/>
    <Column id=other_perc title="Selected Country's GDP Growth in %" fmt="#,##0.0%" contentType=delta/>
    <Column id=pg_perc title="Polands Multiplier" fmt="#,##0.0x" contentType=delta/>
</DataTable>
