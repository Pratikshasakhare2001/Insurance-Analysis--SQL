create database ProjectIA ;
use projectia;


-- KPI 1

SELECT 
    Account_Executive, COUNT(invoice_number) AS 'Invoice Count'
FROM
    invoice
GROUP BY Account_Executive
ORDER BY COUNT(invoice_number) DESC;

-- KPI 2 

SELECT 
    RIGHT(meeting_date, 4) AS 'Year',
    COUNT(meeting_date) AS 'Meetings Count'
FROM
    meeting
GROUP BY RIGHT(meeting_date, 4)
ORDER BY COUNT(meeting_date);


-- KPI 3

SELECT 
    CONCAT(CAST(ROUND((SELECT 
                                SUM(amount)
                            FROM
                                brokerage
                            WHERE
                                income_class = 'Cross Sell') + (SELECT 
                                SUM(amount)
                            FROM
                                fees
                            WHERE
                                income_class = 'Cross Sell')) / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Achieved Cross Sell',
    CONCAT(CAST((SELECT 
                        SUM(amount)
                    FROM
                        invoice
                    WHERE
                        income_class = 'Cross Sell') / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Invoice Cross Sell',
    CONCAT(CAST((SELECT 
                        SUM(Cross_Sell_budget)
                    FROM
                        individual_budgets) / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Target Cross Sell';

-- New

SELECT 
    CONCAT(CAST(ROUND((SELECT 
                                SUM(amount)
                            FROM
                                brokerage
                            WHERE
                                income_class = 'New') + (SELECT 
                                SUM(amount)
                            FROM
                                fees
                            WHERE
                                income_class = 'New')) / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Achieved New',
    CONCAT(CAST((SELECT 
                        SUM(amount)
                    FROM
                        invoice
                    WHERE
                        income_class = 'New') / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Invoice New',
    CONCAT(CAST((SELECT 
                        SUM(New_budget)
                    FROM
                        individual_budgets) / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Target New';
    
-- Renewal

SELECT 
    CONCAT(CAST(ROUND((SELECT 
                                SUM(amount)
                            FROM
                                brokerage
                            WHERE
                                income_class = 'Renewal') + (SELECT 
                                SUM(amount)
                            FROM
                                fees
                            WHERE
                                income_class = 'Renewal')) / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Achieved Renewal',
    CONCAT(CAST((SELECT 
                        SUM(amount)
                    FROM
                        invoice
                    WHERE
                        income_class = 'Renewal') / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Invoice Renewal',
    CONCAT(CAST((SELECT 
                        SUM(Renewal_budget)
                    FROM
                        individual_budgets) / 1000000
                AS DECIMAL (10 , 2 )),
            'M') AS 'Target Renewal';
     
    
-- KPI 4

SELECT 
    stage AS Stage,
    CONCAT(CAST(SUM(revenue_amount) / 1000000 AS DECIMAL (10 , 2 )),
            'M') AS Revenue
FROM
    opportunity
GROUP BY Stage
ORDER BY SUM(revenue_amount) DESC;


-- KPI 5

SELECT 
    Account_Executive, COUNT(meeting_date)
FROM
    meeting
GROUP BY Account_Executive
ORDER BY COUNT(meeting_date) DESC;


-- KPI 6

SELECT 
    opportunity_name, SUM(revenue_amount) AS Revenue
FROM
    opportunity
WHERE
    stage = 'Qualify Opportunity'
        OR 'Purpose Solution'
GROUP BY opportunity_name
ORDER BY SUM(revenue_amount) DESC
LIMIT 4;

-- TOP 4 Opportunity by Revenue

SELECT 
    opportunity_name, SUM(revenue_amount) AS Revenue
FROM
    opportunity
GROUP BY opportunity_name
ORDER BY SUM(revenue_amount) DESC
LIMIT 4;

-- Opportunity by Product Distribution

SELECT 
    *
FROM
    opportunity;
SELECT 
    product_group, COUNT(opportunity_id) AS 'Oppty Count'
FROM
    opportunity
GROUP BY product_group
ORDER BY COUNT(opportunity_id) DESC;


