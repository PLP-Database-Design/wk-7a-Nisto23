-- Create a new table to hold the normalized data
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Insert normalized data into the new table
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM (
    SELECT
        OrderID,
        CustomerName,
        STRING_SPLIT(Products, ',') AS value
    FROM ProductDetail
) AS SplitData;

-- Query the transformed data
SELECT * FROM ProductDetail_1NF;

| OrderID | CustomerName | Product  |
| ------- | ------------ | -------- |
| 101     | John Doe     | Laptop   |
| 101     | John Doe     | Mouse    |
| 102     | Jane Smith   | Tablet   |
| 102     | Jane Smith   | Keyboard |
| 102     | Jane Smith   | Mouse    |
| 103     | Emily Clark  | Phone    |


-- Create a new table for orders and customer details
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Populate the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create a new table for order-product relationships
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate the OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Query data from normalized tables
SELECT * FROM Orders;
SELECT * FROM OrderProducts;

| OrderID | CustomerName |
| ------- | ------------ |
| 101     | John Doe     |
| 102     | Jane Smith   |
| 103     | Emily Clark  |


| OrderID | Product  | Quantity |
| ------- | -------- | -------- |
| 101     | Laptop   | 2        |
| 101     | Mouse    | 1        |
| 102     | Tablet   | 3        |
| 102     | Keyboard | 1        |
| 102     | Mouse    | 2        |
| 103     | Phone    | 1        |




















