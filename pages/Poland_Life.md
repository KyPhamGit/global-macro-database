---
title: Great Growth, But Hows Life There?
description: Analysis of Poland metrics to see what the expected quality of life.
---


#
<LastRefreshed prefix="Data last updated"/>

This dashboard analyzes Polands QoL metrics in Comparison to Germany (and UK for relativity).

```sql data_pol_deu_gbr
select
    lower(iso3) as country_code,
    year,
    pop as population,
    ngdp_usd as nominal_gdp,
    round(ngdp_usd/population, 2) as real_gdp_per_capita,
    infl,
    unemp,
    "CPI" as cpi,
    rcons/rGDP as RCR,
    "HPI" as hpi,
    lag(hpi) over ( partition by country_code order by year asc) as prev_hpi,
    coalesce(hpi, prev_hpi) as hpi_imp
from gmd 
where year >= 2004 and year <=2025
    and country_code in ('pol', 'deu', 'gbr')
order by year
```

## Polands GDP Per Capita Since 2005

<LineChart 
    data={data_pol_deu_gbr}
    x=year
    y=real_gdp_per_capita
    series = country_code
    title="GDP Per Capita in USD"
    yAxisTitle="GDP per Capita (USD)"
    xAxisTitle="Year"
/>


<LineChart 
    data={data_pol_deu_gbr}
    x=year
    y=infl
    series = country_code
    title="Inflation"
    yAxisTitle="Rate in %"
    xAxisTitle="Year"
/>

<LineChart 
    data={data_pol_deu_gbr}
    x=year
    y=cpi
    series = country_code
    title="Consumer Price Index"
    yAxisTitle="Index"
    xAxisTitle="Year"
/>

<LineChart 
    data={data_pol_deu_gbr}
    x=year
    y=RCR
    series = country_code
    title="Real Consumption Ratio"
    yAxisTitle="Ratio"
    xAxisTitle="Year"
/>
<LineChart 
    data={data_pol_deu_gbr}
    x=year
    y=unemp
    series = country_code
    title="Unemployement Rate"
    yAxisTitle="Rate in %"
    xAxisTitle="Year"
/>

<LineChart 
    data={data_pol_deu_gbr}
    x=year
    y=hpi_imp
    series = country_code
    title="House Price Index"
    yAxisTitle="Index"
    xAxisTitle="Year"
/>