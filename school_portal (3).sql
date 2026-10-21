CREATE DATABASE school_portal;
USE school_portal;
CREATE TABLE Admin_Account (
    Admin_ID   int not null primary key,
    Username   varchar(30) not null,
    Password   varchar(30) not null,
    Full_Name  varchar(50) not null,
    Email      varchar(50),
    Role       varchar(20));

CREATE TABLE Student (
    Student_ID        varchar(10) not null primary key,
    First_Name        varchar(30) not null,
    Last_Name         varchar(30) not null,
    Course            varchar(10),
    Year_Level        varchar(10),
    Gender            varchar(20),
    Birth_Date        date,
    Email             varchar(50),
    Contact           varchar(15),
    Address           varchar(100),
    Guardian          varchar(50),
    Relationship      varchar(20),
    Guardian_Contact  varchar(15));

CREATE TABLE Clearance (
    Clearance_ID           varchar(10) not null primary key,
    Student_ID             varchar(10) not null,
    Admin_ID               int not null,
    Registrar_Status       varchar(10) not null,
    Library_Status         varchar(10) not null,
    Accounting_Status      varchar(10) not null,
    Clinic_Status          varchar(10) not null,
    Guidance_Status        varchar(10) not null,
    Student_Affairs_Status varchar(10) not null,
    Overall_Status         varchar(10) not null,
    Progress               int not null,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Admin_Account(Admin_ID));

CREATE TABLE Payment (
    Receipt_No    varchar(10) not null primary key,
    Student_ID    varchar(10) not null,
    Admin_ID      int not null,
    Description   varchar(50) not null,
    Amount        decimal(10,2) not null,
    Payment_Date  date not null,
    Status        varchar(10) not null,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Admin_Account(Admin_ID));

CREATE TABLE Announcement (
    Announcement_ID  varchar(10) not null primary key,
    Admin_ID         int not null,
    Title            varchar(60) not null,
    Message          varchar(255) not null,
    Date_Posted      date not null,
    FOREIGN KEY (Admin_ID) REFERENCES Admin_Account(Admin_ID));

INSERT INTO Admin_Account VALUES (1, 'Ericka', 'Borlasa123', 'Ericka Magday', 'magday28@school.edu', 'Administrator');
INSERT INTO Student VALUES ('2024-001', 'Maria', 'Santos', 'BSIT', '2nd Year', 'Female', '2005-04-12', 'maria.santos@school.edu', '09171234567', 'San Jose del Monte, Bulacan', 'Liza Santos', 'Mother', '09179876543');
INSERT INTO Student VALUES ('2024-002', 'Juan', 'Dela Cruz', 'BSBA', '2nd Year', 'Male', '2004-11-02', 'juan.delacruz@school.edu', '09181234567', 'Quezon City', 'Ramon Dela Cruz', 'Father', '09189998877');
INSERT INTO Student VALUES ('2024-003', 'Ana', 'Reyes', 'BSA', '3rd Year', 'Female', '2003-08-19', 'ana.reyes@school.edu', '09201234567', 'Meycauayan, Bulacan', 'Mila Reyes', 'Mother', '09205554433');
INSERT INTO Student VALUES ('2024-004', 'Carlo', 'Garcia', 'BSCE', '4th Year', 'Male', '2002-06-07', 'carlo.garcia@school.edu', '09221234567', 'Marilao, Bulacan', 'Jose Garcia', 'Father', '09227776655');
INSERT INTO Student VALUES ('2024-005', 'Ella', 'Cruz', 'BSN', '1st Year', 'Female', '2006-01-25', 'ella.cruz@school.edu', '09231234567', 'Bocaue, Bulacan', 'Rina Cruz', 'Mother', '09234445566');
INSERT INTO Student VALUES ('2024-006', 'Paolo', 'Mendoza', 'BSIT', '1st Year', 'Male', '2006-03-14', 'paolo.mendoza@school.edu', '09241234567', 'Balagtas, Bulacan', 'Elena Mendoza', 'Mother', '09241112233');
INSERT INTO Student VALUES ('2024-007', 'Kristine', 'Bautista', 'BSIT', '3rd Year', 'Female', '2003-12-05', 'kristine.bautista@school.edu', '09251234567', 'Malolos, Bulacan', 'Pedro Bautista', 'Father', '09251112233');
INSERT INTO Student VALUES ('2024-008', 'Mark', 'Villanueva', 'BSBA', '2nd Year', 'Male', '2004-09-21', 'mark.villanueva@school.edu', '09261234567', 'Caloocan City', 'Nena Villanueva', 'Mother', '09261112233');
INSERT INTO Student VALUES ('2024-009', 'Jasmine', 'Navarro', 'BSN', '1st Year', 'Female', '2006-07-30', 'jasmine.navarro@school.edu', '09271234567', 'Guiguinto, Bulacan', 'Ben Navarro', 'Father', '09271112233');
INSERT INTO Student VALUES ('2024-010', 'Rico', 'Salazar', 'BSA', '4th Year', 'Male', '2002-02-18', 'rico.salazar@school.edu', '09281234567', 'Pandi, Bulacan', 'Teresa Salazar', 'Mother', '09281112233');
INSERT INTO Clearance VALUES ('CL-001', '2024-001', 1, 'Cleared', 'Cleared', 'Cleared', 'Pending', 'Cleared', 'Cleared', 'Pending', 83);
INSERT INTO Clearance VALUES ('CL-002', '2024-002', 1, 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Pending', 'Pending', 83);
INSERT INTO Clearance VALUES ('CL-003', '2024-003', 1, 'Cleared', 'Cleared', 'Pending', 'Cleared', 'Cleared', 'Pending', 'Pending', 66);
INSERT INTO Clearance VALUES ('CL-004', '2024-004', 1, 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 100);
INSERT INTO Clearance VALUES ('CL-005', '2024-005', 1, 'Pending', 'Pending', 'Pending', 'Pending', 'Cleared', 'Pending', 'Pending', 16);
INSERT INTO Clearance VALUES ('CL-006', '2024-006', 1, 'Cleared', 'Cleared', 'Pending', 'Pending', 'Pending', 'Pending', 'Pending', 33);
INSERT INTO Clearance VALUES ('CL-007', '2024-007', 1, 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 100);
INSERT INTO Clearance VALUES ('CL-008', '2024-008', 1, 'Cleared', 'Pending', 'Cleared', 'Cleared', 'Pending', 'Pending', 'Pending', 50);
INSERT INTO Clearance VALUES ('CL-009', '2024-009', 1, 'Pending', 'Pending', 'Pending', 'Pending', 'Pending', 'Pending', 'Pending', 0);
INSERT INTO Clearance VALUES ('CL-010', '2024-010', 1, 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Pending', 'Pending', 83);
INSERT INTO Payment VALUES ('2026-001', '2024-001', 1, 'Laboratory Fee', 2500.00, '2026-02-10', 'Paid');
INSERT INTO Payment VALUES ('2026-002', '2024-002', 1, 'Tuition Installment', 2500.00, '2026-02-11', 'Paid');
INSERT INTO Payment VALUES ('2026-003', '2024-003', 1, 'Miscellaneous Fee', 1800.00, '2026-02-12', 'Pending');
INSERT INTO Payment VALUES ('2026-004', '2024-004', 1, 'Laboratory Fee', 2500.00, '2026-02-14', 'Paid');
INSERT INTO Payment VALUES ('2026-005', '2024-005', 1, 'Student Fee', 1200.00, '2026-02-15', 'Pending');
INSERT INTO Payment VALUES ('2026-006', '2024-006', 1, 'Laboratory Fee', 2500.00, '2026-02-16', 'Pending');
INSERT INTO Payment VALUES ('2026-007', '2024-007', 1, 'Tuition Installment', 3000.00, '2026-02-17', 'Paid');
INSERT INTO Payment VALUES ('2026-008', '2024-008', 1, 'Miscellaneous Fee', 1800.00, '2026-02-18', 'Paid');
INSERT INTO Payment VALUES ('2026-009', '2024-009', 1, 'Student Fee', 1200.00, '2026-02-19', 'Pending');
INSERT INTO Payment VALUES ('2026-010', '2024-010', 1, 'Laboratory Fee', 2500.00, '2026-02-20', 'Paid');
INSERT INTO Payment VALUES ('2026-011', '2024-007', 1, 'Laboratory Fee', 2500.00, '2026-02-21', 'Paid');
INSERT INTO Payment VALUES ('2026-012', '2024-005', 1, 'Miscellaneous Fee', 1800.00, '2026-02-22', 'Pending');
INSERT INTO Payment VALUES ('2026-013', '2024-003', 1, 'Student Fee', 1200.00, '2026-02-23', 'Pending');
INSERT INTO Announcement VALUES ('AN-001', 1, 'No Classes on Feb 21', 'There will be no classes on February 21. Please check official school updates.', '2026-02-18');
INSERT INTO Announcement VALUES ('AN-002', 1, 'Enrollment Schedule', 'Enrollment for the next term starts on March 3, 2026.', '2026-02-16');
INSERT INTO Announcement VALUES ('AN-003', 1, 'Readmission Policy', 'Please review the readmission policy for school year 2026-2027.', '2026-02-12');

SELECT COUNT(*) AS "Total Students" FROM Student;

SELECT COUNT(*) AS "Pending Clearance"
FROM Clearance
WHERE Overall_Status = 'Pending';
SELECT COUNT(*) AS "Unpaid Payments"
FROM Payment
WHERE Status = 'Pending';

SELECT COUNT(*) AS "Total Announcements" FROM Announcement;

SELECT Student_ID AS "Student ID",
       CONCAT(First_Name, ' ', Last_Name) AS "Student Name",
       Course AS "Course",
       Year_Level AS "Year Level",
       Gender AS "Gender",
       Email AS "Email",
       Contact AS "Contact"
FROM Student
ORDER BY Last_Name ASC, First_Name ASC;

SELECT Student_ID AS "Student ID",
       CONCAT(First_Name, ' ', Last_Name) AS "Student Name",
       Guardian AS "Guardian",
       Relationship AS "Relationship",
       Guardian_Contact AS "Guardian Contact"
FROM Student
ORDER BY Last_Name ASC;

SELECT Student_ID AS "Student ID",
       CONCAT(First_Name, ' ', Last_Name) AS "Student Name",
       Address AS "Address"
FROM Student
WHERE Address LIKE '%Bulacan%'
ORDER BY Last_Name ASC;

SELECT Student_ID AS "Student ID",
       CONCAT(First_Name, ' ', Last_Name) AS "Student Name",
       Course AS "Course"
FROM Student
WHERE Course IN ('BSIT', 'BSN', 'BSA')
ORDER BY Course ASC, Last_Name ASC;

SELECT Student_ID AS "Student ID",
       CONCAT(UPPER(Last_Name), ', ', First_Name) AS "Student Name",
       LOWER(Email) AS "Email"
FROM Student
ORDER BY Last_Name ASC;

SELECT DISTINCT Course AS "Course" FROM Student ORDER BY Course ASC;
SELECT Course AS "Course", COUNT(*) AS "No. of Students"
FROM Student
GROUP BY Course
ORDER BY COUNT(*) DESC;

SELECT Year_Level AS "Year Level", COUNT(*) AS "No. of Students"
FROM Student
GROUP BY Year_Level
ORDER BY Year_Level ASC;

SELECT Course AS "Course", COUNT(*) AS "No. of Students"
FROM Student
GROUP BY Course
HAVING COUNT(*) > 1
ORDER BY Course ASC;

SELECT Clearance_ID AS "Clearance ID",
       Student_ID AS "Student ID",
       Registrar_Status AS "Registrar",
       Library_Status AS "Library",
       Accounting_Status AS "Accounting",
       Clinic_Status AS "Clinic",
       Guidance_Status AS "Guidance",
       Student_Affairs_Status AS "Student Affairs",
       Overall_Status AS "Overall",
       Progress AS "Progress (%)"
FROM Clearance
ORDER BY Clearance_ID ASC;

SELECT Clearance_ID AS "Clearance ID", Student_ID AS "Student ID", Progress AS "Progress (%)"
FROM Clearance
WHERE Overall_Status = 'Cleared';
SELECT Clearance_ID AS "Clearance ID", Student_ID AS "Student ID", Progress AS "Progress (%)"
FROM Clearance
WHERE Overall_Status = 'Pending'
ORDER BY Progress ASC;

SELECT Clearance_ID AS "Clearance ID", Student_ID AS "Student ID", Progress AS "Progress (%)"
FROM Clearance
WHERE Overall_Status = 'Pending' AND Progress BETWEEN 50 AND 83
ORDER BY Progress DESC;

SELECT Clearance_ID AS "Clearance ID",
       Student_ID AS "Student ID",
       Accounting_Status AS "Accounting",
       Clinic_Status AS "Clinic"
FROM Clearance
WHERE Accounting_Status = 'Pending' OR Clinic_Status = 'Pending'
ORDER BY Student_ID ASC;

SELECT Overall_Status AS "Overall Status",
       COUNT(*) AS "No. of Students",
       AVG(Progress) AS "Average Progress"
FROM Clearance
GROUP BY Overall_Status;

SELECT MIN(Progress) AS "Lowest Progress", MAX(Progress) AS "Highest Progress"
FROM Clearance;

SELECT Receipt_No AS "Receipt No.",
       Student_ID AS "Student ID",
       Description AS "Description",
       Amount AS "Amount (PHP)",
       Payment_Date AS "Date",
       Status AS "Status"
FROM Payment
ORDER BY Payment_Date ASC;

SELECT Receipt_No AS "Receipt No.", Description AS "Description", Amount AS "Amount (PHP)"
FROM Payment
WHERE Amount BETWEEN 1800 AND 2500
ORDER BY Amount DESC;
SELECT Status AS "Status",
       COUNT(*) AS "No. of Receipts",
       SUM(Amount) AS "Total Amount",
       AVG(Amount) AS "Average Amount"
FROM Payment
GROUP BY Status;

SELECT Description AS "Fee Type", SUM(Amount) AS "Total Collected"
FROM Payment
WHERE Status = 'Paid'
GROUP BY Description
HAVING SUM(Amount) > 5000
ORDER BY SUM(Amount) DESC;
SELECT Student_ID AS "Student ID", SUM(Amount) AS "Pending Balance"
FROM Payment
WHERE Status = 'Pending'
GROUP BY Student_ID
ORDER BY SUM(Amount) DESC;

SELECT Student_ID AS "Student ID", SUM(Amount) AS "Pending Balance"
FROM Payment
WHERE Status = 'Pending'
GROUP BY Student_ID
HAVING SUM(Amount) > 2000
ORDER BY SUM(Amount) DESC;

SELECT SUM(Amount) AS "Total Payments",
       MIN(Amount) AS "Lowest Payment",
       MAX(Amount) AS "Highest Payment"
FROM Payment;

SELECT Announcement_ID AS "Announcement ID",
       Title AS "Title",
       Message AS "Message",
       Date_Posted AS "Date Posted"
FROM Announcement
ORDER BY Date_Posted DESC;
