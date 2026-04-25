-- Create zip_zhvi table
CREATE TABLE zip_zhvi
(
    RegionID INT,
    SizeRank INT,
    RegionName TEXT,
    RegionType TEXT,
    StateName TEXT,
    State TEXT,
    City TEXT,
    Metro TEXT,
    CountyName TEXT,
    MonthYear DATE,
    HomeValue NUMERIC,
    PRIMARY KEY (RegionID, MonthYear)
);

COPY zip_zhvi
FROM 'C:\Program Files\PostgreSQL\17\data\zip_ZHVI.csv'
DELIMITER ',' 
CSV HEADER;

-- Create zip_growth table
CREATE TABLE zip_growth
(
    RegionID INT PRIMARY KEY,
    SizeRank INT,
    RegionName TEXT,
    RegionType TEXT,
    StateName TEXT,
    State TEXT,
    City TEXT,
    Metro TEXT,
    CountyName TEXT,
    BaseDate DATE,
    "1/31/2025" NUMERIC,
    "3/31/2025" NUMERIC,
    "12/31/2025" NUMERIC
    );

COPY zip_growth
FROM 'C:\Program Files\PostgreSQL\17\data\Zip_zhvf_GROWTH.csv'
DELIMITER ',' 
CSV HEADER;

-- Create years-to-save table
CREATE TABLE yrs_to_save
(
 RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 num_years NUMERIC,
 PRIMARY KEY (RegionID, MonthYear)   
);

COPY yrs_to_save
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_years_to_save.csv'
DELIMITER ','
CSV HEADER;

-- CREATE total transaction value table
CREATE TABLE total_transactions
(
RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 Total_Transaction_Value NUMERIC,
 PRIMARY KEY (RegionID, MonthYear) 
);

COPY total_transactions
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_total_transaction_value.csv'
DELIMITER ','
CSV HEADER;

-- Create New Construction table
CREATE TABLE new_const_price
(
 RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 Median_Price NUMERIC,
 PRIMARY KEY (RegionID, MonthYear)     
);

COPY new_const_price
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_new_con_median_price.csv'
DELIMITER ','
CSV HEADER;

-- Create Median Sales Price (existing inventory) table
CREATE TABLE median_existing_inv_price
(
   RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 Median_Existing_Inv_Price NUMERIC,
 PRIMARY KEY (RegionID, MonthYear)  
);

COPY median_existing_inv_price
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_median_sale_price.csv'
DELIMITER ','
CSV HEADER;


/* Create Median Days to Pending table after dropping Mean Days to Pending table */
DROP TABLE IF EXISTS days2pending;

CREATE TABLE med_days2pending
(
 RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 Days INT,
 PRIMARY KEY (RegionID, MonthYear)    
);

COPY med_days2pending
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_med_days2pending.csv'
DELIMITER ','
CSV HEADER;

-- Create Median Sale-to-List Ratio table
CREATE TABLE med_sale2list
(
 RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 Ratio NUMERIC,
 PRIMARY KEY (RegionID, MonthYear)
);

COPY med_sale2list
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_med_sale2list.csv'
DELIMITER ','
CSV HEADER;

-- Create Market Temperature Index table
CREATE TABLE temp_index 
(
 RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 TempIndex INT,
 PRIMARY KEY (RegionID, MonthYear)
);

COPY temp_index
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_market_temp.csv'
DELIMITER ','
CSV HEADER;

-- CREATE Metro Inventory For Sale table
CREATE TABLE inventory
(
 RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 num_listings INT,
 PRIMARY KEY (RegionID, MonthYear)  
);

COPY inventory
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_invt.csv'
DELIMITER ','
CSV HEADER;

/* Create metro income needed table:  annual household income 
required to spend less than 30% of monthly income on the total 
monthly payment after newly purchasing the typical home 
with a 20% down payment. */

CREATE TABLE income_needed
( 
 RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 Annual_Income NUMERIC,
 PRIMARY KEY (RegionID, MonthYear)  
);

COPY income_needed
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_income_needed.csv'
DELIMITER ','
CSV HEADER;

/* Create Affordable Price table: home price 
such that the total monthly payment on such a 
home would not exceed 30% of the median household’s 
monthly income with a 20% down payment. */

CREATE TABLE affordable_price
( 
 RegionID INT,
 SizeRank INT,
 RegionName TEXT,
 RegionType TEXT,
 StateName TEXT,
 MonthYear DATE,
 affordable_price NUMERIC,
 PRIMARY KEY (RegionID, MonthYear)
);

COPY affordable_price
FROM 'C:\Program Files\PostgreSQL\17\data\Metro_affordable_price.csv'
DELIMITER ','
CSV HEADER;




