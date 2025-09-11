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
order by year