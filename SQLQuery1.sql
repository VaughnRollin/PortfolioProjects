/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [order_id]
      ,[order_date]
      ,[region]
      ,[product_id]
      ,[category]
      ,[sub_category]
      ,[product_name]
      ,[sales]
      ,[quantity]
      ,[discount]
      ,[profit]
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]


  /* finding the most sold product in the dataframe */
  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  /* breaking down the above query to each 4 regions for graphical comparisson */
  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region = 'East'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region = 'West'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region = 'South'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region = 'Central'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC


  /* shows least sold products first per region */

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region = 'Central'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region = 'South'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region = 'West'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region = 'East'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod


  /* showing products not sold in each specific region */
    SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE product_id NOT IN(
	 SELECT product_id
	FROM [PortfolioProject].[dbo].[clean_office_supplies$]
	WHERE region = 'West'
	)
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE product_id NOT IN(
	 SELECT product_id
	FROM [PortfolioProject].[dbo].[clean_office_supplies$]
	WHERE region = 'North'
	)
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE product_id NOT IN(
	 SELECT product_id
	FROM [PortfolioProject].[dbo].[clean_office_supplies$]
	WHERE region = 'South'
	)
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE product_id NOT IN(
	 SELECT product_id
	FROM [PortfolioProject].[dbo].[clean_office_supplies$]
	WHERE region = 'Central'
	)
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC



  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2014-01-01' AND '2014-12-31'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

 
 SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2015-01-01' AND '2015-12-31'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2016-01-01' AND '2016-12-31'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31' 
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

/* same code as above but breaking it down by year and each of the three categories */

SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2014-01-01' AND '2014-12-31' AND category = 'Technology'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2015-01-01' AND '2015-12-31' AND category = 'Technology'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2016-01-01' AND '2016-12-31' AND category = 'Technology'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31' AND category = 'Technology' 
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  /* Office supplies now */ 

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2014-01-01' AND '2014-12-31' AND category = 'Office Supplies'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2015-01-01' AND '2015-12-31' AND category = 'Office Supplies'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2016-01-01' AND '2016-12-31' AND category = 'Office Supplies'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31' AND category = 'Office Supplies' 
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  /* now furniture */

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2014-01-01' AND '2014-12-31' AND category = 'Furniture'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

   SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2015-01-01' AND '2015-12-31' AND category = 'Furniture'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2016-01-01' AND '2016-12-31' AND category = 'Furniture'
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC

  
  SELECT region, product_id, COUNT(product_id) AS count_prod, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31' AND category = 'Furniture' 
  GROUP BY region, product_id, product_name
  ORDER BY count_prod DESC


  SELECT TOP (10) region, category, product_id, COUNT(product_id) as product_count, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region ='East' 
  GROUP BY region, category, product_id, product_name
  ORDER BY product_count DESC

 SELECT TOP (10) region, category, product_id, COUNT(product_id) as product_count, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region ='South'
  GROUP BY region, category, product_id, product_name
  ORDER BY product_count DESC

   SELECT TOP (10) region, category, product_id, COUNT(product_id) as product_count, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region ='West'
  GROUP BY region, category, product_id, product_name
  ORDER BY product_count DESC

   SELECT TOP (10) region, category, product_id, COUNT(product_id) as product_count, product_name
  FROM [PortfolioProject].[dbo].[clean_office_supplies$]
  WHERE region ='Central'
  GROUP BY region, category, product_id, product_name
  ORDER BY product_count DESC
  
  
