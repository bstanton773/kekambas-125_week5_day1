-- Select all columns from the actor table
SELECT * -- * means ALL COLUMNS
FROM actor;

-- Syntax for a simple query
-- SELECT columns you'd like FROM table


SELECT * FROM actor;

-- Query for specific columns - SELECT col_1, col_2, etc. FROM table_name
SELECT first_name, last_name
FROM actor;


-- Filter rows - use WHERE clause - always comes after the FROM 
SELECT *
FROM actor
WHERE first_name = 'Dan';

SELECT first_name, last_update
FROM actor
WHERE first_name = 'Penelope';


-- use wildcards with LIKE clause - % acts as a multi-character wildcard
-- can be any number of characters (0-infinity) - zero or many [\w\s]*
SELECT *
FROM actor a 
WHERE first_name LIKE 'M%';

SELECT *
FROM actor 
WHERE last_name LIKE '%r%';

SELECT *
FROM actor 
WHERE last_name = '%r%'; -- WILL LITERALLY LOOK FOR '%r%' - need the LIKE FOR wildcard

-- Underscore (_) - represents 1 and only 1 character
SELECT *
FROM actor
WHERE first_name LIKE '_i_';

SELECT *
FROM actor 
WHERE first_name LIKE '_i%';


-- using AND and OR in the WHERE clause
-- OR - only one needs to be TRUE 
SELECT *
FROM actor 
WHERE first_name LIKE 'N%' OR last_name LIKE 'W%';

-- AND -- all conditions need to be TRUE
SELECT *
FROM actor 
WHERE first_name LIKE 'N%' AND last_name LIKE 'W%';


-- Comparing Operators in SQL:
-- Greater Than >   -- Less Than <
-- Greater Than or Equal >=  -- Less Than or Equal <=
-- Equal =   -- Not Equal <>

SELECT *
FROM payment;


-- Query all of the payments of more than $7.00
SELECT customer_id, amount
FROM payment
WHERE amount > 7.00;

SELECT customer_id, amount 
FROM payment 
WHERE amount > '7';


SELECT *
FROM customer
WHERE store_id <> 2; -- NOT EQUAL

SELECT *
FROM actor 
WHERE first_name NOT LIKE 'P%';

SELECT *
FROM actor
WHERE actor_id != 1; -- NOT EQUAL


-- Get all of the payments between $3 and $8 (inclusive)
SELECT *
FROM payment p 
WHERE amount >= 3 AND amount <= 8;

-- BETWEEN/AND clause
SELECT *
FROM payment 
WHERE amount BETWEEN 3 AND 8;


-- Ordering the rows of data - Order By
-- ORDER BY col_name (default ASC, add DESC for descending)

SELECT *
FROM film
ORDER BY rental_duration;

SELECT *
FROM category
ORDER BY name DESC;


-- ORDER BY comes after the WHERE (if present)

SELECT *
FROM payment
WHERE customer_id = 453
ORDER BY amount;

-- Exercise 1 - Write a query that will return all of the films that have an 'h' in the title and order it by rental_duration (ASC)

SELECT title, rental_duration
FROM film 
WHERE title ILIKE '%h%' -- ILIKE IS a CASE-INSENSITIVE LIKE
ORDER BY rental_duration;


SELECT *
FROM film;
--title                      |rental_duration|
-----------------------------+---------------+
--Vanishing Rocky            |              3|
--Idaho Love                 |              3|
--Reunion Witches            |              3|
--Creatures Shakespeare      |              3|
--Sweet Brotherhood          |              3|
--Daughter Madigan           |              3|
--Day Unfaithful             |              3|
--Squad Fish                 |              3|
--Disciple Mother            |              3|



-- SQL Aggregations => SUM(), AVG(), COUNT(), MIN(), MAX()
-- take in a column_name as an argument and return a single value

SELECT SUM(amount)
FROM payment;

SELECT SUM(amount)
FROM payment 
WHERE amount > 5;

SELECT SUM(amount)
FROM payment 
WHERE customer_id = 345;

-- AVG -- Average of the column
SELECT AVG(amount)
FROM payment;


-- Get the minimum and maximum of payments -- also alias the column name - col_name AS alias_name
SELECT MIN(amount) AS lowest_amount_paid, MAX(amount) AS greatest_amount_paid
FROM payment;


-- MIN() and MAX() can work on strings as well!
SELECT MIN(title), MAX(title)
FROM film;


-- COUNT() -> Takes in either the column name OR * for all COLUMNS 
-- If column name, will count how many NON-NULL rows, if * will count all rows
SELECT COUNT(amount)
FROM payment;

SELECT COUNT(*)
FROM payment;

SELECT *
FROM staff;

-- GET THE total number of staff members
SELECT COUNT(*)
FROM staff; -- RETURNS 2 because there ARE 2 ROWS


-- Get the total number of staff members with a picture
SELECT COUNT(picture)
FROM staff; -- RETURNS 1 because ONLY one ROW has a picture, the other IS NULL!


-- Count how many unique first names there are in the actors
-- use the DISTINCT in the COUNT() -- COUNT(DISCINCT col_name)
SELECT COUNT(DISTINCT first_name)
FROM actor;


-- Calculate a new column based on other COLUMNS 
SELECT payment_id, rental_id, payment_id - rental_id AS difference
FROM payment;

-- CONCAT -- will concatenate two strings together
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customer;



-- GROUP BY Clause
-- Used with aggregations 

SELECT COUNT(*)
FROM payment 
WHERE amount = 1.99; 
-- 580

SELECT COUNT(*)
FROM payment 
WHERE amount = 2.99;
-- 3233

SELECT *
FROM payment 
ORDER BY amount;

SELECT amount, COUNT(*), SUM(amount), AVG(amount)
FROM payment
GROUP BY amount;


-- columns selected from the table must also be used in the group by
SELECT amount, customer_id, COUNT(*)
FROM payment 
GROUP BY amount; -- ERROR: column "payment.customer_id" must appear in the GROUP BY clause or be used in an aggregate function


SELECT amount, customer_id, COUNT(*)
FROM payment 
GROUP BY amount, customer_id
ORDER BY customer_id;


-- Use Aggregations in the ORDER BY clause
-- Query the payment table to display the customer (by id) who has spent the most
SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- Alias our aggregated column and use in the ORDER BY 
SELECT customer_id, SUM(amount) AS total_spent
FROM payment 
GROUP BY customer_id
ORDER BY total_spent DESC;


-- HAVING Clause => HAVING is to GROUP BY/Aggreations as WHERE is to SELECT 
SELECT customer_id, SUM(amount) AS total_spent
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) < 150
ORDER BY total_spent DESC;

-- customers who have made between 20 and 30 individual payments
SELECT customer_id, COUNT(*)
FROM payment 
GROUP BY customer_id 
HAVING COUNT(*) BETWEEN 20 AND 30;


-- LIMIT and OFFSET clause

-- LIMIT - limit the number of rows that are returned
SELECT *
FROM film
LIMIT 10;

--SELECT *
--FROM staff
--LIMIT 10;


-- OFFSET - start your rows after a certain number of rows using OFFSET
SELECT *
FROM film
OFFSET 10; -- SKIP OVER the FIRST 10 rows

-- Can be used together
SELECT *
FROM film 
LIMIT 10
--OFFSET 5;



-- Putting all of the clauses together
-- Of all customer who have made less than 20 payments and  have a customer_id > 350, display those who have spent 11-20th most

SELECT customer_id, COUNT(*), SUM(amount) AS total_spend
FROM payment
WHERE customer_id > 350
GROUP BY customer_id
HAVING COUNT(*) < 20
ORDER BY total_spend DESC
OFFSET 10
LIMIT 10;

-- SYNTAX ORDER: (SELECT and FROM are the only mandatory)

-- SELECT (columns from table)
-- FROM (table name)

-- WHERE (row filter)
-- GROUP BY (aggregations)
-- HAVING (filter aggregations)
-- ORDER BY (column value ASC or DESC)
-- OFFSET (number of rows to skip)
-- LIMIT (max number of rows to display)


SELECT customer_id, COUNT(*), SUM(amount) AS total_spend FROM payment WHERE customer_id > 350 GROUP BY customer_id HAVING COUNT(*) < 20 ORDER BY total_spend DESC OFFSET 10 LIMIT 10;
