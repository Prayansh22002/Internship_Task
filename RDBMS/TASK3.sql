-- Create the RetailStore database
CREATE DATABASE RetailStore;

-- Use the created database
USE RetailStore;

-- Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    join_date DATE
);

-- Create Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Create Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Create Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10, 2),
    payment_method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert Sample Data into Customers Table
INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address, join_date) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Cityville', '2022-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Elm St, Townsville', '2021-12-10');

-- Insert Sample Data into Products Table
INSERT INTO Products (product_id, product_name, category, price, stock_quantity) VALUES
(1, 'Laptop', 'Electronics', 1000.00, 50),
(2, 'Smartphone', 'Electronics', 500.00, 100),
(3, 'Headphones', 'Accessories', 100.00, 200);

-- Insert Sample Data into Orders Table
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, order_status) VALUES
(1, 1, '2023-02-15', 1500.00, 'Shipped'),
(2, 2, '2023-02-16', 500.00, 'Pending');

-- Insert Sample Data into OrderDetails Table
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 1000.00),
(2, 1, 2, 1, 500.00),
(3, 2, 2, 1, 500.00);

-- Insert Sample Data into Payments Table
INSERT INTO Payments (payment_id, order_id, payment_date, payment_amount, payment_method) VALUES
(1, 1, '2023-02-15', 1500.00, 'Credit Card'),
(2, 2, '2023-02-16', 500.00, 'PayPal');

--1
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

--2
SELECT p.product_name, SUM(od.quantity * od.unit_price) AS TotalSalesAmount
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name;

--3
SELECT TOP 1 p.product_name, MAX(od.unit_price) AS MaxPrice
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY MaxPrice DESC;

--4
SELECT DISTINCT c.first_name, c.last_name, c.email
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATEADD(DAY, -30, GETDATE());

--5
SELECT c.first_name, c.last_name, SUM(p.payment_amount) AS TotalPaid
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;

--6
SELECT p.category, SUM(od.quantity) AS TotalProductsSold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.category;

--7
SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Pending';

--8
SELECT AVG(o.total_amount) AS AverageOrderValue
FROM Orders o;

--9
SELECT TOP 5 c.first_name, c.last_name, SUM(p.payment_amount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY TotalSpent DESC;

--10
SELECT p.product_name
FROM Products p
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;





