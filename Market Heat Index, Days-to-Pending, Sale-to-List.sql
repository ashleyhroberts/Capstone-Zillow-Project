-- Days-to-Pending and Heat Index

    SELECT 
      days2pending.regionid,
      days2pending.regionname AS city,
      days2pending.statename,
      EXTRACT (Year from days2pending.monthyear) as Year,
      ROUND(AVG(days2pending.days),1) AS avg_days2pending,
      ROUND(AVG(heat.tempindex),1) AS avg_temp
    FROM med_days2pending AS days2pending
    INNER JOIN temp_index AS heat
    ON days2pending.regionid = heat.regionid
    AND days2pending.monthyear = heat.monthyear
    GROUP BY days2pending.regionid, days2pending.regionname, days2pending.statename, Year
    ORDER BY statename, city, year;

/* Join Days-to-Pending table with Sale-to-List Ratio table
Use CTE to extract and average the values by YEAR. 
Exclude rows where both values are NULL*/

WITH years AS (
    SELECT  
        d2p.regionid,
        d2p.statename,
        d2p.regionname,
        EXTRACT (YEAR FROM d2p.monthyear) AS Year,
        d2p.days AS days_to_pending,
        s2l.ratio AS sale_to_list_ratio
FROM med_days2pending AS d2p 
INNER JOIN med_sale2list AS s2l 
    ON d2p.regionid = s2l.regionid
    AND d2p.monthyear = s2l.monthyear
)
SELECT  
    years.statename,
    years.regionname,
    years.Year,
    ROUND(AVG(years.days_to_pending),1) AS avg_days_to_pending,
    ROUND(AVG(years.sale_to_list_ratio),3) AS avg_sale_to_list_ratio
FROM years 
WHERE NOT(years.days_to_pending IS NULL AND years.sale_to_list_ratio IS NULL)
GROUP BY years.statename, years.regionname, years.Year
ORDER BY years.statename, years.regionname, years.year;
