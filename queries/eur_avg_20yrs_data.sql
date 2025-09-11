select
    countryname,
    lower(iso3) as country_code,
    year,
    avg(exports_GDP) as exports_GDP,
    avg(imports_GDP) as imports_GDP,
    avg(CA_GDP) as CA_GDP,
    avg(inv_GDP) as inv_GDP,
    avg(finv_GDP) as finv_GDP,
    avg(govdebt_GDP) as govdebt_GDP,
    avg(govdef_GDP) as govdef_GDP,
    avg(govexp_GDP) as govexp_GDP,
    avg(govrev_GDP) as govrev_GDP,
    avg(govtax_GDP) as govtax_GDP
from gmd 
where year >= 2004 and year <=2025
group by 1,2,3
order by year