/* Join Affordable Price table and Median Sales Price table.
Add a column that calculates the difference between the average
Affordable Price and the Sales Price per year */

 WITH years AS (
    SELECT
        aff_price.regionid,
        aff_price.statename,
        aff_price.regionname,
        aff_price.monthyear,
        EXTRACT (YEAR FROM aff_price.MonthYear) AS Year,
        aff_price.affordable_price AS ap,
        inv_price.median_existing_inv_price AS eip
    FROM affordable_price AS aff_price
    INNER JOIN median_existing_inv_price AS inv_price 
        ON aff_price.regionid = inv_price.regionID
        AND aff_price.monthyear = inv_price.monthyear
 )
SELECT
    statename,
    regionname,
    Year,
    ROUND(AVG(ap),0) AS avg_affordable_price,
    ROUND(AVG(eip),0) AS avg_med_sales_price,
    ROUND(AVG(ap) - AVG(eip),0) AS difference
FROM years
GROUP BY Year, statename, regionname
HAVING AVG(ap) IS NOT NULL
ORDER BY Year, difference;

/* Income Needed by State and Year */

WITH yearly_values AS (
    SELECT
        Statename,
        EXTRACT (YEAR FROM Monthyear) AS Year,
        Annual_Income
    FROM income_needed
    WHERE annual_income IS NOT NULL
)
SELECT
    Statename,
    Year,
    ROUND(AVG(Annual_income),0) AS avg_income 
FROM yearly_values
GROUP BY Statename, Year
ORDER BY Statename, Year;

-- Years to Save Query including City and State

WITH yearly_values AS (
    SELECT
        regionname,
        statename,
        EXTRACT (Year from Monthyear) AS Year,
        AVG(num_years) AS avg_num_years
    FROM yrs_to_save
    GROUP BY statename, regionname, Year
)
SELECT 
    regionname,
    statename,
    Year,
    ROUND((avg_num_years),2) AS avg_years_to_save
FROM yearly_values
ORDER BY statename, regionname;
