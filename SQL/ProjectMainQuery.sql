-- Use database

USE mydb;

-- Retrieving useful data

-- 1st Hypotheses - Find best selling Aisle

SELECT 
    a.aisle AS aisle, d.department as department_name, COUNT(po.order_id) as number_of_orders
FROM
    aisles a
        JOIN
    products p ON a.aisle_id = p.aisle_id
		JOIN
	product_orders po ON p.product_id = po.product_id
		JOIN
	departments d ON p.department_id = d.department_id
GROUP BY a.aisle, d.department
ORDER BY number_of_orders desc
LIMIT 10;

-- Changing department "produce" into "agriculture"

UPDATE departments 
SET 
    department = 'agriculture'
WHERE
    department = 'produce';
    
-- Changing department "dairy eggs" into "dairy products"

UPDATE departments 
SET 
    department = 'dairy products'
WHERE
    department = 'dairy eggs';

-- 2nd Hypothesis - Confirm if customers do more orders on the weekends

SELECT 
    order_dow AS day_of_week, COUNT(order_id) AS number_orders
FROM
    customers_orders
GROUP BY order_dow
ORDER BY order_dow DESC;


-- Changing the DOW numbers into words

SELECT 
    CASE
        WHEN order_dow = 0 THEN 'Saturday'
        WHEN order_dow = 1 THEN 'Sunday'
        WHEN order_dow = 2 THEN 'Monday'
        WHEN order_dow = 3 THEN 'Tuesday'
        WHEN order_dow = 4 THEN 'Wednesday'
        WHEN order_dow = 5 THEN 'Thursday'
        WHEN order_dow = 6 THEN 'Friday'
    END AS day_of_week,
    COUNT(order_id) AS number_orders
FROM
    customers_orders
GROUP BY 
    order_dow
ORDER BY 
    number_orders DESC;

-- See the most used hour of Saturday

SELECT 
    order_hour_of_day AS hours, COUNT(order_id) AS number_orders
FROM
    customers_orders
WHERE
    order_dow = 0
GROUP BY hours
ORDER BY number_orders DESC;

-- See the most used hour of Sunday

SELECT 
    order_hour_of_day AS hours, COUNT(order_id) AS number_orders
FROM
    customers_orders
WHERE
    order_dow = 1
GROUP BY hours
ORDER BY number_orders DESC;

-- 3rd Hypothesis - Loyalty Customers, business opportunities

SELECT 
    user_id, sum(order_number) as total_products_ordered, AVG(days_since_prior_order) as days_since_prior_order
FROM
    Customers_orders
GROUP BY user_id
ORDER BY total_products_ordered DESC;

