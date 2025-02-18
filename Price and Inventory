/* Join Inventory-for-sale (listings) table with Median Sales Price table. 
Add columns for percent changes in listings and prices.
2 CTEs and LAG Window Functions */

WITH years AS (
    SELECT
        inv.RegionID,
        inv.Regionname,
        inv.Statename,
        EXTRACT (YEAR FROM inv.Monthyear) AS Year,
        inv.num_listings,
        eip.median_existing_inv_price AS med_price
    FROM inventory AS inv
    INNER JOIN median_existing_inv_price AS eip
    ON inv.regionid = eip.regionid
    AND inv.monthyear = eip.monthyear
),
sumlistings_and_avgprices AS (
    SELECT 
        Statename,
        Year,
        SUM(num_listings) AS sum_num_listings,
        AVG(med_price) AS avg_med_price
    FROM years
    GROUP BY Statename, Year  
)
SELECT
    Statename,
    Year,
    ROUND(LAG(sum_num_listings) OVER (PARTITION BY Statename ORDER BY YEAR),1) AS previous_year_listings,
    ROUND(sum_num_listings,1) AS sum_num_listings_rounded,
    ROUND(
        (sum_num_listings - LAG(sum_num_listings) OVER (PARTITION BY Statename ORDER BY YEAR)) *100 /
        LAG(sum_num_listings) OVER (PARTITION BY Statename ORDER BY YEAR),2
        ) AS listings_percent_change,
    ROUND(LAG(avg_med_price) OVER (PARTITION BY Statename ORDER BY YEAR),1) AS previous_med_price,
    ROUND(avg_med_price,1) AS avg_med_price_rounded,
    ROUND(
        (avg_med_price - LAG(avg_med_price) OVER (PARTITION BY Statename ORDER BY YEAR)) *100 /
        LAG(avg_med_price) OVER (PARTITION BY Statename ORDER BY YEAR),2
        ) AS price_percent_change
FROM sumlistings_and_avgprices
ORDER BY Statename, Year;

