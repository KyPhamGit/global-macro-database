---
title: Is Poland Really Europes Next Power House?
description: Analysis of Poland metrics to see if they are really the up and coming EU leader.
---


# EU GDP Trends Since 2000
<LastRefreshed prefix="Data last updated"/>

This dashboard analyzes European GDP data from the Global Macro Database, showing aggregate GDP trends across all EU since 2000.

```sql global_gdp_by_year

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

SELECT
    countryname as countries,
    year,
    SUM(nGDP_USD) as total_gdp_usd_billions
FROM europe 
WHERE year >= 2000 
    AND nGDP_USD IS NOT NULL 
    AND nGDP_USD > 0
GROUP BY 1,2
ORDER BY year
```

## Total EU GDP in USD (Billions) Since 2000

<LineChart 
    data={global_gdp_by_year}
    x=year
    y=total_gdp_usd_billions
    series=countries
    title="EU GDP in USD (Billions)"
    yAxisTitle="GDP (Billions USD)"
    xAxisTitle="Year"
    yFmt="#,##0,,"
/>

```sql recent_growth
SELECT 
    year,
    countries,
    total_gdp_usd_billions
FROM ${global_gdp_by_year}
WHERE year >= 2025
ORDER BY total_gdp_usd_billions DESC
LIMIT 10
```

## Top 10 EU by GDP Growth

<DataTable 
    data={recent_growth}
    rows=10
>
    <Column id=year title="Year"/>
    <Column id=countries title="Countries"/>
    <Column id=total_gdp_usd_billions title="Total GDP Nominal USD (Millions)" fmt="#,##0,"/>
</DataTable>

## Real GDP growth for UK

```sql latin_gdp
SELECT
    iso3 as countries,
    year,
    rGDP as real_gdp,
    nGDP_USD as nominal_gdp,
    round(nGDP_USD/pop,2) as real_gdp_per_capita
FROM gmd 
WHERE year >= 1950 
and iso3 in ('MEX','COL','BRA','ARG')
ORDER BY year
```
<LineChart 
    data={latin_gdp}
    x=year
    y=nominal_gdp
    series=countries
    title="Latin GDP"
    yAxisTitle="GDP"
    xAxisTitle="Year"
/>
<LineChart 
    data={latin_gdp}
    x=year
    y=real_gdp_per_capita
    series=countries
    title="Latin GDP per capita"
    yAxisTitle="GDP"
    xAxisTitle="Year"
/>
## Unemployment Rates

```sql unemp_rates
SELECT
    iso3 as countries,
    year,
    unemp
FROM gmd 
WHERE year >= 1950 
and iso3 in ('MEX','COL','BRA','ARG')
ORDER BY year
```
<LineChart 
    data={unemp_rates}
    x=year
    y=unemp
    series=countries
    title="Unemployment Rates"
    yAxisTitle="rate"
    xAxisTitle="Year"
/>


## Real GDP growth for UK

```sql latin_gdp
SELECT
    iso3 as countries,
    year,
    rGDP as real_gdp,
    nGDP_USD as nominal_gdp,
    round(nGDP_USD/pop,2) as real_gdp_per_capita
FROM gmd 
WHERE year >= 1950 
and iso3 in ('MEX','COL','BRA','ARG')
ORDER BY year
```
<LineChart 
    data={latin_gdp}
    x=year
    y=nominal_gdp
    series=countries
    title="Latin GDP"
    yAxisTitle="GDP"
    xAxisTitle="Year"
/>
<LineChart 
    data={latin_gdp}
    x=year
    y=real_gdp_per_capita
    series=countries
    title="Latin GDP per capita"
    yAxisTitle="GDP"
    xAxisTitle="Year"
/>
## Unemployment Rates

```sql unemp_rates
SELECT
    iso3 as countries,
    year,
    unemp
FROM gmd 
WHERE year >= 1950 
and iso3 in ('MEX','COL','BRA','ARG')
ORDER BY year
```
<LineChart 
    data={unemp_rates}
    x=year
    y=unemp
    series=countries
    title="Unemployment Rates"
    yAxisTitle="rate"
    xAxisTitle="Year"
/>