use da8;

show tables;
drop table sales;
-- Create the following table and insert the given records before answering the questions.

CREATE TABLE sales ( sale_id INT PRIMARY KEY, product VARCHAR(50),
category VARCHAR(50), units_sold INT, unit_price INT, region VARCHAR(50)
);

INSERT INTO sales (sale_id, product, category, units_sold, unit_price, region)
VALUES
(1, 'Keyboard', 'Electronics', 10, 1200, 'North'),
(2, 'Monitor', 'Electronics', 5, 7000, 'South'),
(3, 'Chair', 'Furniture', 15, 2500, 'North'),
(4, 'Desk', 'Furniture', 7, 4500, 'West'),
(5, 'Mouse', 'Electronics', 20, 800, 'East'),
(6, 'Sofa', 'Furniture', 3, 15000, 'South'),
(7, 'Headphones', 'Electronics', 8, 1800, 'North'),
(8, 'Laptop', 'Electronics', 6, 55000, 'West'),
(9, 'Table', 'Furniture', 12, 6000, 'East'),
(10, 'Fan', 'HomeAppliance', 18, 3000, 'South'),
(11, 'AC', 'HomeAppliance', 4, 35000, 'North'),
(12, 'Cupboard', 'Furniture', 5, 12000, 'West'),
(13, 'Printer', 'Electronics', 9, 9000, 'East'),
(14, 'Bed', 'Furniture', 2, 25000, 'South'),
(15, 'Mobile', 'Electronics', 14, 20000, 'North');

