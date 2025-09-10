---
title: What Drives This Kind of Growth?
description: Analysis of Polands Investments and Financial Descisions.
---


#
<LastRefreshed prefix="Data last updated"/>

This dashboard analyzes Poland Government Decisions.

```sql data_pol_deu_gbr
select
    countryname,
    lower(iso3) as country_code,
    year,
    exports_GDP,
    imports_GDP,
    CA_GDP,
    inv_GDP,
    finv_GDP,
    govdebt_GDP,
    govdef_GDP,
    govexp_GDP,
    govrev_GDP,
    govtax_GDP
from gmd 
where year >= 2004 and year <=2025
    and country_code in ('pol', 'deu', 'gbr')
order by year
```

## Exports Comparison

```sql imp_and_exp
select
    countryname,
    lower(iso3) as country_code,
    exports_GDP,
    imports_GDP
from gmd 
where year = 2025
    and country_code in ('pol', 'deu', 'gbr')
```

<BarChart
  data={imp_and_exp}
  x=countryname
  y:[exports_GDP, imports_GDP]
  title="Percentage of GDP from Imports and Exports"
  xAxisTitle="Countries"
  yAxisTitle="% of GDP"
/>

<LineChart 
    data={data_pol_deu_gbr}
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
    xAxisTitle="Year"
/>


```sql sum_data_pol_deu_gbr
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
  data={sum_data_pol_deu_gbr}
  x=countryname
  y:[Gov_Debt, Gov_Defic, Gov_Exp, Gov_Rev]
  title="Government Financial Metrics by Country"
  xAxisTitle="Country"
  yAxisTitle="GDP (Billions)"
/>
