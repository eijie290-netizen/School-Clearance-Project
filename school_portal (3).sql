CREATE DATABASE school_portal;
USE school_portal;

CREATE TABLE admin_account (
    admin_id   INT          NOT NULL,
    username   VARCHAR(30)  NOT NULL,
    password   VARCHAR(30)  NOT NULL,
    full_name  VARCHAR(50)  NOT NULL,
    email      VARCHAR(50),
    role       VARCHAR(20),
    PRIMARY KEY (admin_id)
);

CREATE TABLE student (
    student_id        VARCHAR(10)  NOT NULL,
    first_name        VARCHAR(30)  NOT NULL,
    last_name         VARCHAR(30)  NOT NULL,
    course            VARCHAR(10),
    year_level        VARCHAR(10),
    gender            VARCHAR(20),
    birth_date        DATE,
    email             VARCHAR(50),
    contact           VARCHAR(15),
    address           VARCHAR(100),
    guardian          VARCHAR(50),
    relationship      VARCHAR(20),
    guardian_contact  VARCHAR(15),
    PRIMARY KEY (student_id)
);

CREATE TABLE clearance (
    clearance_id           VARCHAR(10) NOT NULL,
    student_id             VARCHAR(10) NOT NULL,
    registrar_status       VARCHAR(10) NOT NULL,
    library_status         VARCHAR(10) NOT NULL,
    accounting_status      VARCHAR(10) NOT NULL,
    clinic_status          VARCHAR(10) NOT NULL,
    guidance_status        VARCHAR(10) NOT NULL,
    student_affairs_status VARCHAR(10) NOT NULL,
    overall_status         VARCHAR(10) NOT NULL,
    progress               INT         NOT NULL,
    PRIMARY KEY (clearance_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE TABLE payment (
    receipt_no    VARCHAR(10)   NOT NULL,
    student_id    VARCHAR(10)   NOT NULL,
    description   VARCHAR(50)   NOT NULL,
    amount        DECIMAL(10,2) NOT NULL,
    payment_date  DATE          NOT NULL,
    status        VARCHAR(10)   NOT NULL,
    PRIMARY KEY (receipt_no),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE TABLE announcement (
    announcement_id  VARCHAR(10)  NOT NULL,
    title            VARCHAR(60)  NOT NULL,
    message          VARCHAR(255) NOT NULL,
    date_posted      DATE         NOT NULL,
    PRIMARY KEY (announcement_id)
);

INSERT INTO admin_account (admin_id, username, password, full_name, email, role)
VALUES (1, 'Ericka', 'Borlasa123', 'Ericka Magday', 'magday28@school.edu', 'Administrator');

INSERT INTO student (student_id, first_name, last_name, course, year_level, gender,
                     birth_date, email, contact, address, guardian, relationship,
                     guardian_contact) VALUES
('2024-001', 'Maria', 'Santos', 'BSIT', '2nd Year', 'Female', '2005-04-12',
 'maria.santos@school.edu', '09171234567', 'San Jose del Monte, Bulacan',
 'Liza Santos', 'Mother', '09179876543'),
('2024-002', 'Juan', 'Dela Cruz', 'BSBA', '2nd Year', 'Male', '2004-11-02',
 'juan.delacruz@school.edu', '09181234567', 'Quezon City',
 'Ramon Dela Cruz', 'Father', '09189998877'),
('2024-003', 'Ana', 'Reyes', 'BSA', '3rd Year', 'Female', '2003-08-19',
 'ana.reyes@school.edu', '09201234567', 'Meycauayan, Bulacan',
 'Mila Reyes', 'Mother', '09205554433'),
('2024-004', 'Carlo', 'Garcia', 'BSCE', '4th Year', 'Male', '2002-06-07',
 'carlo.garcia@school.edu', '09221234567', 'Marilao, Bulacan',
 'Jose Garcia', 'Father', '09227776655'),
('2024-005', 'Ella', 'Cruz', 'BSN', '1st Year', 'Female', '2006-01-25',
 'ella.cruz@school.edu', '09231234567', 'Bocaue, Bulacan',
 'Rina Cruz', 'Mother', '09234445566');

INSERT INTO clearance (clearance_id, student_id, registrar_status, library_status,
                       accounting_status, clinic_status, guidance_status,
                       student_affairs_status, overall_status, progress) VALUES
('CL-001', '2024-001', 'Cleared', 'Cleared', 'Cleared', 'Pending', 'Cleared', 'Cleared', 'Pending', 83),
('CL-002', '2024-002', 'Cleared', 'Cleared', 'Pending', 'Cleared', 'Cleared', 'Pending', 'Pending', 66),
('CL-003', '2024-003', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Pending', 'Pending', 83),
('CL-004', '2024-004', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 'Cleared', 100),
('CL-005', '2024-005', 'Pending', 'Pending', 'Cleared', 'Pending', 'Cleared', 'Pending', 'Pending', 33);

INSERT INTO payment (receipt_no, student_id, description, amount, payment_date, status) VALUES
('2026-001', '2024-001', 'Laboratory Fee', 2500.00, '2026-02-10', 'Paid'),
('2026-002', '2024-002', 'Tuition Installment', 2500.00, '2026-02-11', 'Paid'),
('2026-003', '2024-003', 'Miscellaneous Fee', 1800.00, '2026-02-12', 'Pending'),
('2026-004', '2024-004', 'Laboratory Fee', 2500.00, '2026-02-14', 'Paid'),
('2026-005', '2024-005', 'Student Fee', 1200.00, '2026-02-15', 'Pending');

INSERT INTO announcement (announcement_id, title, message, date_posted) VALUES
('AN-001', 'No Classes on Feb 21',
 'There will be no classes on February 21. Please check official school updates.', '2026-02-18'),
('AN-002', 'Enrollment Schedule',
 'Enrollment for the next term starts on March 3, 2026.', '2026-02-16'),
('AN-003', 'Readmission Policy',
 'Please review the readmission policy for school year 2026-2027.', '2026-02-12');

SELECT COUNT(*) AS total_students FROM student;

SELECT COUNT(*) AS pending_clearance
FROM clearance
WHERE overall_status = 'Pending';

SELECT COUNT(*) AS unpaid_payments
FROM payment
WHERE status = 'Pending';

SELECT COUNT(*) AS total_announcements FROM announcement;

SELECT student_id AS "Student ID",
       CONCAT(first_name, ' ', last_name) AS "Student Name",
       course AS "Course",
       year_level AS "Year Level",
       gender AS "Gender",
       email AS "Email",
       contact AS "Contact"
FROM student
ORDER BY last_name ASC, first_name ASC;

SELECT student_id AS "Student ID",
       CONCAT(first_name, ' ', last_name) AS "Student Name",
       guardian AS "Guardian",
       relationship AS "Relationship",
       guardian_contact AS "Guardian Contact"
FROM student
ORDER BY last_name;

SELECT clearance_id AS "Clearance ID",
       student_id AS "Student ID",
       registrar_status AS "Registrar",
       library_status AS "Library",
       accounting_status AS "Accounting",
       clinic_status AS "Clinic",
       guidance_status AS "Guidance",
       student_affairs_status AS "Student Affairs",
       overall_status AS "Overall",
       progress AS "Progress (%)"
FROM clearance
ORDER BY clearance_id;

SELECT clearance_id, student_id, progress
FROM clearance
WHERE overall_status = 'Cleared';

SELECT clearance_id, student_id, progress
FROM clearance
WHERE overall_status = 'Pending'
ORDER BY progress ASC;

SELECT overall_status AS "Overall Status",
       COUNT(*) AS "No. of Students",
       AVG(progress) AS "Average Progress"
FROM clearance
GROUP BY overall_status;

SELECT receipt_no AS "Receipt No.",
       student_id AS "Student ID",
       description AS "Description",
       amount AS "Amount (PHP)",
       payment_date AS "Date",
       status AS "Status"
FROM payment
ORDER BY payment_date ASC;

SELECT status AS "Status",
       COUNT(*) AS "No. of Receipts",
       SUM(amount) AS "Total Amount",
       AVG(amount) AS "Average Amount"
FROM payment
GROUP BY status;

SELECT description AS "Fee Type", SUM(amount) AS "Total Collected"
FROM payment
WHERE status = 'Paid'
GROUP BY description
HAVING SUM(amount) > 2000;

SELECT student_id AS "Student ID", SUM(amount) AS "Pending Balance"
FROM payment
WHERE status = 'Pending'
GROUP BY student_id
ORDER BY SUM(amount) DESC;

SELECT course AS "Course", COUNT(*) AS "No. of Students"
FROM student
GROUP BY course
ORDER BY COUNT(*) DESC;

SELECT year_level AS "Year Level", COUNT(*) AS "No. of Students"
FROM student
GROUP BY year_level
ORDER BY year_level;

SELECT announcement_id AS "Announcement ID",
       title AS "Title",
       message AS "Message",
       date_posted AS "Date Posted"
FROM announcement
ORDER BY date_posted DESC;
