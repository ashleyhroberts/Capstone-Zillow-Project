/* Join Median Sales Price table for existing inventory 
with Median New Construction Price table and add a 
column showing the difference (new const - existing) */

SELECT
    ei.RegionID,
    ei.StateName,
    ei.RegionName,
    ei.MonthYear,
    ROUND(AVG(ei.median_existing_inv_price),0) AS avg_existinginv_price,
    ROUND(AVG(ncon.median_price),0) AS avg_newconst_price,
    ROUND(AVG(ncon.median_price) - AVG(ei.median_existing_inv_price),0) AS difference
FROM median_existing_inv_price AS ei 
INNER JOIN new_const_price AS ncon 
    ON ei.regionid = ncon.regionid
    AND ei.monthyear = ncon.monthyear
GROUP BY ei.MonthYear, ei.StateName, ei.RegionName, ei.RegionID
ORDER BY ei.MonthYear, ei.StateName, ei.RegionName;
