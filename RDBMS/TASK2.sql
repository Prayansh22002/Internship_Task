CREATE DATABASE RideHailing;
USE RideHailing;

-- Create Drivers Table
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY ,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    VehicleType VARCHAR(50),
    Rating DECIMAL(2,1)
);

-- Create Riders Table
CREATE TABLE Riders (
    RiderID INT PRIMARY KEY ,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    JoinDate DATE
);

-- Create Rides Table
CREATE TABLE Rides (
    RideID INT PRIMARY KEY,
    RiderID INT,
    DriverID INT,
    RideDate DATE,
    PickupLocation VARCHAR(100),
    DropLocation VARCHAR(100),
    Distance DECIMAL(5,2),
    Fare DECIMAL(10,2),
    RideStatus VARCHAR(20),
    FOREIGN KEY (RiderID) REFERENCES Riders(RiderID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

-- Create Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY ,
    RideID INT,
    PaymentMethod VARCHAR(20),
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);

INSERT INTO Drivers (DriverID, FirstName, LastName, Phone, City, VehicleType, Rating) VALUES
(1, 'John', 'Doe', '123-456-7890', 'New York', 'SUV', 4.8),
(2, 'Jane', 'Smith', '234-567-8901', 'Los Angeles', 'Sedan', 4.2),
(3, 'Alice', 'Johnson', '345-678-9012', 'Chicago', 'Hatchback', 4.6),
(4, 'Bob', 'Davis', '456-789-0123', 'Miami', 'SUV', 5.0);



INSERT INTO Riders (RiderID, FirstName, LastName, Phone, City, JoinDate) VALUES
(1, 'Mike', 'Lee', '567-890-1234', 'New York', '2022-06-15'),
(2, 'Sara', 'Williams', '678-901-2345', 'Chicago', '2021-08-21'),
(3, 'David', 'Taylor', '789-012-3456', 'Miami', '2023-01-10'),
(4, 'Emma', 'Brown', '890-123-4567', 'Los Angeles', '2022-11-05');

INSERT INTO Rides (RideID, RiderID, DriverID, RideDate, PickupLocation, DropLocation, Distance, Fare, RideStatus) VALUES
(1, 1, 1, '2023-01-15', 'Central Park', 'Times Square', 10.5, 30.00, 'Completed'),
(2, 2, 2, '2023-02-20', 'Lake Shore', 'Millennium Park', 8.0, 25.00, 'Completed'),
(3, 3, 3, '2023-03-05', 'Brickell', 'South Beach', 22.0, 50.00, 'Completed'),
(4, 4, 4, '2023-03-10', 'Hollywood Blvd', 'Santa Monica', 15.0, 40.00, 'Cancelled'),
(5, 1, 3, '2023-04-05', 'Central Park', 'Brooklyn Bridge', 12.0, 35.00, 'Completed');

INSERT INTO Payments (PaymentID, RideID, PaymentMethod, Amount, PaymentDate) VALUES
(1, 1, 'Card', 30.00, '2023-01-15'),
(2, 2, 'Cash', 25.00, '2023-02-20'),
(3, 3, 'Wallet', 50.00, '2023-03-05'),
(4, 4, 'Card', 0.00, '2023-03-10'),
(5, 5, 'Wallet', 35.00, '2023-04-05');

--1
SELECT FirstName, LastName, Phone, City, VehicleType, Rating
FROM Drivers
WHERE Rating >= 4.5;
--2
SELECT d.FirstName, d.LastName, COUNT(r.RideID) AS TotalRides
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
WHERE r.RideStatus = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.LastName;
--3
SELECT r.FirstName, r.LastName, r.Phone, r.City
FROM Riders r
LEFT JOIN Rides ri ON r.RiderID = ri.RiderID
WHERE ri.RideID IS NULL;
--4
SELECT d.FirstName, d.LastName, SUM(p.Amount) AS TotalEarnings
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
JOIN Payments p ON r.RideID = p.RideID
WHERE r.RideStatus = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.LastName;
--5
SELECT r1.FirstName AS RiderFirstName, r1.LastName AS RiderLastName, r2.RideDate
FROM Riders r1
JOIN Rides r2 ON r1.RiderID = r2.RiderID
WHERE r2.RideDate = (
    SELECT MAX(RideDate)
    FROM Rides
    WHERE RiderID = r1.RiderID
);
--6
SELECT d.City, COUNT(r.RideID) AS NumberOfRides
FROM Rides r
JOIN Drivers d ON r.DriverID = d.DriverID
GROUP BY d.City;
--7
SELECT r.RideID, r.RideDate, r.Distance, r.PickupLocation, r.DropLocation
FROM Rides r
WHERE r.Distance > 20;
--8
SELECT TOP 1 PaymentMethod, COUNT(PaymentMethod) AS PaymentCount
FROM Payments
GROUP BY PaymentMethod
ORDER BY PaymentCount DESC;
--9
SELECT TOP 3 d.FirstName, d.LastName, SUM(p.Amount) AS TotalEarnings
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
JOIN Payments p ON r.RideID = p.RideID
WHERE r.RideStatus = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.LastName
ORDER BY TotalEarnings DESC;
--10
SELECT r.RideID, r.RideDate, r.PickupLocation, r.DropLocation, r.Distance, r.Fare, r.RideStatus,
       ri.FirstName AS RiderFirstName, ri.LastName AS RiderLastName,
       d.FirstName AS DriverFirstName, d.LastName AS DriverLastName
FROM Rides r
JOIN Riders ri ON r.RiderID = ri.RiderID
JOIN Drivers d ON r.DriverID = d.DriverID
WHERE r.RideStatus = 'Cancelled';









