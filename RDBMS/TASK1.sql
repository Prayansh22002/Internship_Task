-- Create the University database
CREATE DATABASE University;

-- Switch to the University database
USE University;

-- Create the Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE NOT NULL,
    enrollment_date DATE NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Create the Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY ,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Professors table
CREATE TABLE Professors (
    professor_id INT PRIMARY KEY ,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

-- Create the Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    department_id INT,
    professor_id INT,
    credits INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

-- Create the Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


-- Insert sample data into Departments

INSERT INTO Departments (department_id, department_name) VALUES 
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics');

-- Insert sample data into Professors
INSERT INTO Professors (professor_id, first_name, last_name, email, phone) VALUES
(1, 'John', 'Doe', 'jdoe@university.edu', '123-456-7890'),
(2, 'Jane', 'Smith', 'jsmith@university.edu', '987-654-3210'),
(3, 'Emily', 'Brown', 'ebrown@university.edu', '555-555-5555');

-- Insert sample data into Courses
INSERT INTO Courses (course_id, course_name, department_id, professor_id, credits) 
VALUES 
(1, 'Database Systems', 1, 1, 4),
(2, 'Operating Systems', 1, 2, 3),
(3, 'Calculus', 2, 3, 4),
(4, 'Quantum Mechanics', 3, 3, 4);

-- Insert sample data into Students
INSERT INTO Students (student_id, first_name, last_name, email, phone, date_of_birth, enrollment_date, department_id) 
VALUES 
(1, 'Alice', 'Johnson', 'alice@university.edu', '111-111-1111', '2000-01-15', '2023-09-01', 1),
(2, 'Bob', 'Williams', 'bob@university.edu', '222-222-2222', '1999-05-10', '2022-09-01', 2),
(3, 'Charlie', 'Davis', 'charlie@university.edu', '333-333-3333', '2001-03-20', '2023-09-01', 1);

-- Insert sample data into Enrollments
INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) 
VALUES 
(1, 1, 1, '2023-09-15', 'A'),
(2, 1, 2, '2023-09-15', 'B'),
(3, 2, 3, '2022-09-15', 'A'),
(4, 3, 1, '2023-09-15', 'C');
--1
SELECT 
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM 
    Departments d
LEFT JOIN 
    Students s ON d.department_id = s.department_id
GROUP BY 
    d.department_id, d.department_name;

--2

SELECT 
    c.course_name
FROM 
    Courses c
JOIN 
    Professors p ON c.professor_id = p.professor_id
WHERE 
    p.first_name = 'John' AND p.last_name = 'Doe'; -- Replace 'John Doe' with the professor's name

--3

SELECT 
    c.course_name,
    AVG(CASE 
        WHEN e.grade = 'A' THEN 4
        WHEN e.grade = 'B' THEN 3
        WHEN e.grade = 'C' THEN 2
        WHEN e.grade = 'D' THEN 1
        ELSE 0 
    END) AS average_grade
FROM 
    Enrollments e
JOIN 
    Courses c ON e.course_id = c.course_id
GROUP BY 
    c.course_id, c.course_name;

--4

SELECT 
    s.first_name,
    s.last_name,
    s.email
FROM 
    Students s
LEFT JOIN 
    Enrollments e ON s.student_id = e.student_id
WHERE 
    e.enrollment_id IS NULL;

--5

SELECT 
    d.department_name,
    COUNT(c.course_id) AS total_courses
FROM 
    Departments d
LEFT JOIN 
    Courses c ON d.department_id = c.department_id
GROUP BY 
    d.department_id, d.department_name;

--6
SELECT 
    s.first_name,
    s.last_name,
    s.email
FROM 
    Students s
JOIN 
    Enrollments e ON s.student_id = e.student_id
JOIN 
    Courses c ON e.course_id = c.course_id
WHERE 
    c.course_name = 'Database Systems'; -- Replace 'Database Systems' with the course name

--7

SELECT 
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM 
    Courses c
JOIN 
    Enrollments e ON c.course_id = e.course_id
GROUP BY 
    c.course_id, c.course_name
ORDER BY 
    total_enrollments DESC
LIMIT 1;

--8

SELECT 
    d.department_name,
    AVG(c.credits) AS avg_credits_per_student
FROM 
    Departments d
JOIN 
    Students s ON d.department_id = s.department_id
JOIN 
    Enrollments e ON s.student_id = e.student_id
JOIN 
    Courses c ON e.course_id = c.course_id
GROUP BY 
    d.department_id, d.department_name;

	--9

SELECT 
    p.first_name,
    p.last_name,
    COUNT(DISTINCT c.department_id) AS num_departments
FROM 
    Professors p
JOIN 
    Courses c ON p.professor_id = c.professor_id
GROUP BY 
    p.professor_id, p.first_name, p.last_name
HAVING 
    COUNT(DISTINCT c.department_id) > 1;


--10
SELECT 
    c.course_name,
    MAX(e.grade) AS highest_grade,
    MIN(e.grade) AS lowest_grade
FROM 
    Enrollments e
JOIN 
    Courses c ON e.course_id = c.course_id
WHERE 
    c.course_name = 'Operating Systems' -- Replace with the course name
GROUP BY 
    c.course_id, c.course_name;


