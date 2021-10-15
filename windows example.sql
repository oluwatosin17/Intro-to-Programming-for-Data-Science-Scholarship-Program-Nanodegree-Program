#https://www.mysqltutorial.org/mysql-window-functions/

create database s;
use s;
CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales;

SELECT SUM(sale)
FROM sales;

SELECT fiscal_year, SUM(sale)
FROM sales
GROUP BY fiscal_year;

SELECT 
    fiscal_year, 
    sales_employee,
    sale,
    SUM(sale) OVER (PARTITION BY fiscal_year) total_sales
FROM sales;

#window_function_name(expression) OVER ( 
 #  [partition_defintion]
 #  [order_definition]
 #  [frame_definition])

