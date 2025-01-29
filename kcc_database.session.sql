/*
1. What is the total amount of products sold?
2. Who is the top paying customer?
3. What is the revenue in the month of January?
4. What is the lowest selling product in 2024?
5. What is the highest selling product in 2024?
6. How much did customers in the city of Onne spend in 2024?
7. How much did customers in cities bearing 'GRA' spend in 2024?
8. How many products sold more than 250,000?
9. How many products sold above the average total revenue?
10. How many products sold below the average total revenue?
*/

-- 1. Total amount of products sold

SELECT
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    product
INNER JOIN public.order ON product.product_id = public.order.product_id;
-- ANSWER = 2,616,109.55

-- 2. Top paying customer

SELECT
    sales.customer_id,
    total_revenue,
    customer_name
FROM
(SELECT
    customer_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    product
INNER JOIN public.order ON product.product_id = public.order.product_id
GROUP BY
    public.order.customer_id) AS sales
INNER JOIN customers ON sales.customer_id = customers.customer_id
ORDER BY
    total_revenue DESC;
-- ANSWER = QRT with a total revenue of 894,592.98

-- 3. Total Revenue for January

CREATE TABLE january_sales AS
SELECT *
FROM public.order
WHERE EXTRACT (MONTH FROM order_date) = 1;

SELECT
   SUM(quantity * price_per_kg) AS total_revenue
FROM
    january_sales
INNER JOIN product ON january_sales.product_id = product.product_id;
-- ANSWER = 950,062.42

-- 4. Lowest selling product in 2024

SELECT
    product.product_id,
    total_revenue,
    product_name
FROM
(
SELECT
    public.order.product_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    public.order
INNER JOIN product ON product.product_id = public.order.product_id
GROUP BY
    public.order.product_id
) AS product_sales
INNER JOIN product ON product_sales.product_id = product.product_id
ORDER BY
    total_revenue ASC;
-- ANSWER = Avocado with a total_revenue of 600.00

-- 5. Highest selling product in 2024

SELECT
    product.product_id,
    total_revenue,
    product_name
FROM
(
SELECT
    public.order.product_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    public.order
INNER JOIN product ON product.product_id = public.order.product_id
GROUP BY
    public.order.product_id
) AS product_sales
INNER JOIN product ON product_sales.product_id = product.product_id
ORDER BY
    total_revenue DESC;
-- ANSWER = Plantain with a TR of 511,308.00

-- 6. Amount spent by customers in the city of Onne

SELECT
    SUM(total_revenue)
FROM
(
SELECT
    public.order.customer_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    public.order
INNER JOIN product ON public.order.product_id = product.product_id
GROUP BY
    public.order.customer_id
) AS revenue
INNER JOIN customers ON revenue.customer_id = customers.customer_id
WHERE 
    city LIKE 'Onne Port';
-- ANSWER = 1,319,741.60

-- 7. Amount spent by customers in cities having GRA

SELECT
    SUM(total_revenue)
FROM
(
SELECT
    public.order.customer_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    public.order
INNER JOIN product ON public.order.product_id = product.product_id
GROUP BY
    public.order.customer_id
) AS revenue
INNER JOIN customers ON revenue.customer_id = customers.customer_id
WHERE 
    city LIKE '%GRA%';
-- ANSWER = 427,410.28

-- 8. Products that sold over 250,000 in 2024

SELECT
    product.product_id,
    total_revenue,
    product_name
FROM
(
SELECT
    public.order.product_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    public.order
INNER JOIN product ON product.product_id = public.order.product_id
GROUP BY
    public.order.product_id
) AS product_sales
INNER JOIN product ON product_sales.product_id = product.product_id
WHERE
    total_revenue > 250000
ORDER BY
    total_revenue DESC;
-- ANSWER = Plantain (511,308.00), Tomato (384,522.38) and Potato (368,260.20)

-- 9. Products that sold above ATR

SELECT
    ROUND(AVG(total_revenue),2) AS ATR
FROM
(SELECT
    public.order.product_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    public.order
INNER JOIN product ON public.order.product_id = product.product_id
GROUP BY
    public.order.product_id
ORDER BY
    product_id) AS revenue

-- ATR = 67,079.73

SELECT
    product_name,
    total_revenue
FROM
(
    SELECT
    public.order.product_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    public.order
INNER JOIN product ON public.order.product_id = product.product_id
GROUP BY
    public.order.product_id
) AS product_revenue
INNER JOIN product ON product_revenue.product_id = product.product_id
WHERE
    total_revenue > 67079.73
ORDER BY
    total_revenue DESC;
-- ANSWER = Plantain, Tomato, Potato, Watermelon, Pineapple, Pawpaw, Onion, Cucumber, Carrot, Orange and Green Pepper.

-- 10. Products that sold below ATR

SELECT
    product_name,
    total_revenue
FROM
(
    SELECT
    public.order.product_id,
    SUM(quantity * price_per_kg) AS total_revenue
FROM
    public.order
INNER JOIN product ON public.order.product_id = product.product_id
GROUP BY
    public.order.product_id
) AS product_revenue
INNER JOIN product ON product_revenue.product_id = product.product_id
WHERE
    total_revenue < 67079.73
ORDER BY
    total_revenue DESC;
-- ANSWER = From 'Hot Pepper' to 'Avacado', Sweet Potato did not sell at all.