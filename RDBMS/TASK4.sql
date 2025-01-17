-- Create the HR Management database
CREATE DATABASE HR_Management;

-- Use the database
USE HR_Management;

-- Create the Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    ManagerID INT
);

-- Create the Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    HireDate DATE NOT NULL,
    DepartmentID INT,
    ManagerID INT,
    Salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- Add the foreign key constraint for ManagerID in Departments
ALTER TABLE Departments
ADD CONSTRAINT FK_Departments_ManagerID FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID);

-- Create the PerformanceReviews table
CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    ReviewDate DATE NOT NULL,
    PerformanceScore VARCHAR(10) NOT NULL,
    Comments TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT CHK_PerformanceScore CHECK (PerformanceScore IN ('Excellent', 'Good', 'Average', 'Poor'))
);
-- Create the Payroll table
CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT CHK_PaymentMethod CHECK (PaymentMethod IN ('Bank Transfer', 'Check'))
);

-- Insert sample data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES
(1, 'Human Resources', NULL),
(2, 'Engineering', NULL),
(3, 'Finance', NULL);

-- Insert sample data into Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Phone, HireDate, DepartmentID, ManagerID, Salary) VALUES
(101, 'Alice', 'Johnson', 'alice.johnson@example.com', '1234567890', '2022-01-15', 1, NULL, 60000.00),
(102, 'Bob', 'Smith', 'bob.smith@example.com', '0987654321', '2023-03-10', 2, 101, 75000.00),
(103, 'Charlie', 'Brown', 'charlie.brown@example.com', '5678901234', '2023-05-20', 2, 101, 72000.00),
(104, 'Diana', 'Prince', 'diana.prince@example.com', '4567890123', '2023-07-15', 3, NULL, 68000.00);

-- Update Managers in Departments
UPDATE Departments SET ManagerID = 101 WHERE DepartmentID = 1;
UPDATE Departments SET ManagerID = 101 WHERE DepartmentID = 2;
UPDATE Departments SET ManagerID = 104 WHERE DepartmentID = 3;

-- Insert sample data into PerformanceReviews
INSERT INTO PerformanceReviews (ReviewID, EmployeeID, ReviewDate, PerformanceScore, Comments) VALUES
(1, 101, '2023-06-01', 'Excellent', 'Great leadership skills'),
(2, 102, '2023-06-15', 'Good', 'Consistent performer'),
(3, 103, '2023-07-01', 'Average', 'Needs improvement in communication'),
(4, 104, '2023-07-20', 'Excellent', 'Outstanding financial analysis');

-- Insert sample data into Payroll
INSERT INTO Payroll (PayrollID, EmployeeID, PaymentDate, Amount, PaymentMethod) VALUES
(1, 101, '2023-06-30', 5000.00, 'Bank Transfer'),
(2, 102, '2023-06-30', 6250.00, 'Check'),
(3, 103, '2023-06-30', 6000.00, 'Bank Transfer'),
(4, 104, '2023-06-30', 5666.67, 'Bank Transfer');

-- Query 1: Retrieve the names and contact details of employees hired after January 1, 2023
SELECT FirstName, LastName, Email, Phone FROM Employees WHERE HireDate > '2023-01-01';

-- Query 2: Find the total payroll amount paid to each department
SELECT d.DepartmentName, SUM(p.Amount) AS TotalPayroll
FROM Employees e
JOIN Payroll p ON e.EmployeeID = p.EmployeeID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- Query 3: List all employees who have not been assigned a manager
SELECT FirstName, LastName FROM Employees WHERE ManagerID IS NULL;

-- Query 4: Retrieve the highest salary in each department along with the employee’s name
SELECT d.DepartmentName, e.FirstName, e.LastName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = (SELECT MAX(Salary) FROM Employees WHERE DepartmentID = d.DepartmentID);


-- Query 5: Find the most recent performance review for each employee
SELECT e.FirstName, e.LastName, pr.ReviewDate, pr.PerformanceScore, pr.Comments
FROM Employees e
JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID
WHERE pr.ReviewDate = (SELECT MAX(ReviewDate) FROM PerformanceReviews WHERE EmployeeID = e.EmployeeID);

-- Query 6: Count the number of employees in each department
SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;


-- Query 7: List all employees who have received a performance score of "Excellent."
SELECT e.FirstName, e.LastName
FROM Employees e
JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID
WHERE pr.PerformanceScore = 'Excellent';
-- Query 7 (part 2): Identify the most frequently used payment method in payroll
SELECT TOP 1 PaymentMethod, COUNT(*) AS UsageCount
FROM Payroll
GROUP BY PaymentMethod
ORDER BY UsageCount DESC;

-- Query 8: Retrieve the top 5 highest-paid employees along with their departments
SELECT TOP 5 e.FirstName, e.LastName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
ORDER BY e.Salary DESC;

-- Query 9: Show details of all employees who report directly to a specific manager (e.g., ManagerID = 101)
SELECT e.FirstName, e.LastName, e.Email, e.Phone, e.Salary
FROM Employees e
WHERE e.ManagerID = 101;


