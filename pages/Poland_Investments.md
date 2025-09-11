---
title: What Drives This Kind of Growth?
description: Analysis of Polands Investments and Financial Descisions.
queries:
  - eu_20yrs_data: eur_20yrs_data.sql
  - distinct_countries: distinct_countries.sql
---
<LastRefreshed prefix="Data last updated"/>


# This page analyzes Poland Government Decisions.

## Exports Comparison

<Dropdown
    title="Select a Country" 
    name=select_countries
    data={distinct_countries}
    value=countryname
    defaultValue="Germany"
/>

<BarChart
  data={eu_20yrs_data.where(`
    year = 2025
    and country_code in ('pol', '${inputs.select_countries}')
    `)}
  x=countryname
  y:[exports_GDP, imports_GDP]
  title="Percentage of GDP from Imports and Exports"
  xAxisTitle="Countries"
  yAxisTitle="% of GDP"
/>

<LineChart 
    data={eu_20yrs_data}
    x=year
    y=CA_GDP
    series = countryname
    title="Curent Account"
    yAxisTitle="%"
    xAxisTitle="Year"
/>

```sql sum_data_inv_finv
select
    countryname,
    lower(iso3) as country_code,
    avg(inv_GDP) as inv_GDP,
    avg(finv_GDP) as finv_GDP
from gmd 
where year = 2025
    and country_code in ('pol', 'deu', 'gbr')
group by 1,2
```

<BarChart 
    data={sum_data_inv_finv}
    x=countryname
    y:[inv_GDP, finv_GDP]
    title="Percentage of GDP Used for Investments"
    yAxisTitle="% of GDP"
    xAxisTitle="Country"
/>


```sql sum_eu_20yrs_data
select
    countryname,
    lower(iso3) as country_code,
    sum(govdebt_GDP) as Gov_Debt,
    sum(govdef_GDP) as Gov_Defic,
    sum(govexp_GDP) as Gov_Exp,
    sum(govrev_GDP) as Gov_Rev
from gmd 
where year = 2025
    and country_code in ('pol', 'deu', 'gbr')
group by 1,2
```

<BarChart
  data={sum_eu_20yrs_data}
  x=countryname
  y:[Gov_Debt, Gov_Defic, Gov_Exp, Gov_Rev]
  title="Government Financial Metrics by Country"
  xAxisTitle="Country"
  yAxisTitle="GDP (Billions)"
/>
