-- 1. Create tables
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    department_id INT,
    specialty_id INT,
    joining_date DATE
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    date_of_birth DATE,
    gender VARCHAR(10),
    address TEXT
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE Specialties (
    specialty_id INT PRIMARY KEY,
    specialty_name VARCHAR(100)
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATETIME,
    reason TEXT,
    status VARCHAR(20)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    appointment_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    payment_method VARCHAR(20)
);

-- 2. Insert Indian dummy data
INSERT INTO Departments VALUES
(1, 'Cardiology'),
(2, 'Dermatology'),
(3, 'Orthopedics');

INSERT INTO Specialties VALUES
(1, 'Cardiology'),
(2, 'Dermatology'),
(3, 'Orthopedics');

INSERT INTO Doctors VALUES
(1, 'Arun', 'Sharma', 'arun.sharma@hospital.in', '9876543210', 1, 1, '2020-05-15'),
(2, 'Seema', 'Khan', 'seema.khan@hospital.in', '8765432109', 2, 2, '2021-08-20'),
(3, 'Rajesh', 'Singh', 'rajesh.singh@hospital.in', '7654321098', 3, 3, '2019-11-10');

INSERT INTO Patients VALUES
(1, 'Rahul', 'Verma', 'rahul.verma@gmail.com', '9898989898', '1990-03-15', 'Male', 'Delhi'),
(2, 'Pooja', 'Rana', 'pooja.rana@gmail.com', '9797979797', '1985-07-20', 'Female', 'Mumbai'),
(3, 'Amit', 'Kumar', 'amit.kumar@gmail.com', '9696969696', '1995-01-10', 'Male', 'Bangalore');

INSERT INTO Appointments VALUES
(1, 1, 1, '2025-01-10 10:30:00', 'Routine Checkup', 'Completed'),
(2, 2, 2, '2025-01-11 14:00:00', 'Skin Rash', 'Cancelled'),
(3, 3, 3, '2025-01-12 11:00:00', 'Back Pain', 'Scheduled');

INSERT INTO Payments VALUES
(1, 1, '2025-01-10', 500.00, 'Cash'),
(2, 2, '2025-01-11', 0.00, 'Cash');



-- 3. Queries
-- 1. Find the Total Number of Appointments for Each Doctor
SELECT concat(d.first_name,' ',d.last_name) AS doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id;

-- 2. List All Patients Who Have an Appointment with a Specific Doctor (e.g., Dr. Arun Sharma)
SELECT concat(p.first_name,' ',p.last_name) AS patient_name
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 1;

-- 3. Find the Number of Appointments Scheduled in a Specific Department
SELECT d.department_name, COUNT(a.appointment_id) AS total_appointments
FROM Appointments a
JOIN Doctors doc ON a.doctor_id = doc.doctor_id
JOIN Departments d ON doc.department_id = d.department_id
WHERE d.department_name = 'Cardiology'
GROUP BY d.department_id;

-- 4. Find the Most Popular Specialty Based on Number of Appointments
SELECT s.specialty_name, COUNT(a.appointment_id) AS total_appointments
FROM Appointments a
JOIN Doctors doc ON a.doctor_id = doc.doctor_id
JOIN Specialties s ON doc.specialty_id = s.specialty_id
GROUP BY s.specialty_id
ORDER BY total_appointments DESC
LIMIT 1;

-- 5. Get the Total Payment Amount for All Completed Appointments
SELECT SUM(p.payment_amount) AS total_payment
FROM Payments p
JOIN Appointments a ON p.appointment_id = a.appointment_id
WHERE a.status = 'Completed';

-- 6. Find the Number of Patients Seen by Each Doctor
SELECT concat(d.first_name,' ',d.last_name) AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id;

-- 7. List All Patients Who Have Missed Their Appointments (Status 'Cancelled')
SELECT concat(p.first_name,' ',p.last_name) AS patient_name
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.status = 'Cancelled';

-- 8. Find the Total Number of Appointments for Each Status (Scheduled, Completed, Cancelled)
SELECT a.status, COUNT(a.appointment_id) AS total_appointments
FROM Appointments a
GROUP BY a.status;

-- 9. Get the Average Payment Amount for Completed Appointments
SELECT AVG(p.payment_amount) AS avg_payment
FROM Payments p
JOIN Appointments a ON p.appointment_id = a.appointment_id
WHERE a.status = 'Completed';

-- 10. Find the Doctor with the Highest Number of Appointments
SELECT concat(d.first_name , ' ' , d.last_name) AS doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id
ORDER BY total_appointments DESC
LIMIT 1;
