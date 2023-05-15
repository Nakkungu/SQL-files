CREATE TABLE Categories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Regions (
  region_id INT PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category_id INT,
  cost DECIMAL(10, 2),
  FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Sales (
  sale_id INT PRIMARY KEY,
  product_id INT,
  region_id INT,
  sale_date DATE,
  sale_price DECIMAL(10, 2),
  discount DECIMAL(5, 2),
  profit DECIMAL(10, 2),
  FOREIGN KEY (product_id) REFERENCES Products(product_id),
  FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

-- inserting categories into the categories table
INSERT INTO Categories (category_id, category_name)
VALUES
  (1, 'Category1'),
  (2, 'Category2'),
  (3, 'Category3'),
  (4, 'Category4'),
  (5, 'Category5'),
  (6, 'Category6'),
  (7, 'Category7'),
  (8, 'Category8'),
  (9, 'Category9'),
  (10, 'Category10');
  
 -- Insrting regions into the regions table
 INSERT INTO Regions (region_id, region_name)
VALUES
  (1, 'Region1'),
  (2, 'Region2'),
  (3, 'Region3'),
  (4, 'Region4'),
  (5, 'Region5'),
  (6, 'Region6'),
  (7, 'Region7'),
  (8, 'Region8'),
  (9, 'Region9'),
  (10, 'Region10');
  
  
-- Populating the products table with random data

INSERT INTO Products (product_id, product_name, category_id, cost)
SELECT
    (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS product_id,
    CONCAT('Product', (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) % 1000 + 1) AS product_name,
    (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) % 10 + 1 AS category_id,
    ROUND(RAND() * 1000, 2) AS cost
FROM
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS numbers
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS numbers2
LIMIT 1000;



-- Populating the sales table with 1000 random entries

INSERT INTO Sales (sale_id, product_id, region_id, sale_date, sale_price, discount, profit)
SELECT
    (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS sale_id,
    p.product_id,
    (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) % 10 + 1 AS region_id,
    CURRENT_DATE() - INTERVAL (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) DAY AS sale_date,
    ROUND(RAND() * 1000, 2) AS sale_price,
    ROUND(RAND() * 0.5, 2) AS discount,
    ROUND(RAND() * 500, 2) AS profit
FROM
    Products p
JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS numbers
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS numbers2
LIMIT 1000;




