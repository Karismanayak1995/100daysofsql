CREATE TABLE employees_11 (
    emp_id      INT PRIMARY KEY,
    full_name   VARCHAR(100),   -- format: 'FirstName LastName'
    email       VARCHAR(100),
    phone       VARCHAR(20),    -- format: '+91-XXXXXXXXXX'
    department  VARCHAR(50),
    job_title   VARCHAR(100),
    address     VARCHAR(200)    -- format: 'Street, City, State - PIN'
);

INSERT INTO employees_11 VALUES
(1,  'Arjun Sharma',   'arjun.sharma@gmail.com',      '+91-9876543210', 'Sales',     'Sr. Sales Manager',      '42 MG Road, Hyderabad, Telangana - 500001'),
(2,  'Priya Reddy',    'priya.reddy@yahoo.com',        '+91-8765432109', 'Sales',     'Jr. Sales Executive',    '15 Banjara Hills, Hyderabad, Telangana - 500034'),
(3,  'Kiran Mehta',    'kiran.mehta@outlook.com',      '+91-7654321098', 'Tech',      'Sr. Tech Lead',          '8 Andheri West, Mumbai, Maharashtra - 400053'),
(4,  'Sneha Iyer',     'sneha.iyer@gmail.com',         '+91-6543210987', 'Tech',      'Jr. Developer',          '23 Koramangala, Bangalore, Karnataka - 560034'),
(5,  'Ravi Kumar',     'ravi.kumar@company.co.in',     '+91-5432109876', 'HR',        'HR Manager',             '5 Anna Nagar, Chennai, Tamil Nadu - 600040'),
(6,  'Divya Nair',     'divya.nair@hotmail.com',       '+91-4321098765', 'Tech',      'Sr. Developer',          '11 Viman Nagar, Pune, Maharashtra - 411014'),
(7,  'Amit Joshi',     'amit.joshi@gmail.com',         '+91-3210987654', 'Finance',   'Finance Lead',           '7 Civil Lines, Delhi, Delhi - 110054'),
(8,  'Neha Gupta',     'neha.gupta@yahoo.com',         '+91-2109876543', 'Finance',   'Jr. Finance Analyst',    '19 Salt Lake, Kolkata, West Bengal - 700091'),
(9,  'Suresh Babu',    'suresh.babu@outlook.com',      '+91-1098765432', 'Sales',     'Sales Lead',             '3 Jubilee Hills, Hyderabad, Telangana - 500033'),
(10, 'Kavya Menon',    'kavya.menon@company.co.in',    '+91-9087654321', 'HR',        'Sr. HR Manager',         '31 Indiranagar, Bangalore, Karnataka - 560038'),
(11, 'Rohit Verma',    'rohit.verma@gmail.com',        '+91-8076543210', 'Tech',      'Tech Lead',              '14 Sector 18, Noida, Uttar Pradesh - 201301'),
(12, 'Lakshmi Rao',    'lakshmi.rao@hotmail.com',      '+91-7065432109', 'Sales',     'Jr. Sales Manager',      '6 T Nagar, Chennai, Tamil Nadu - 600017');

-- Part 1 — Name splitting
-- Extract first name and last name into separate columns:
-- emp_id     first_name    last_name
--  1         Arjun          Sharma

-- Part 2 — Email domain extraction
-- Extract the domain from the email address:
-- emp_id   full_name      email_domain
--  1       Arjun Sharma    gmail.com

-- Part 3 — Phone number cleaning
-- Remove the +91- prefix and return only the 10-digit number:
-- emp_id     clean_phone
--  1          9876543210

-- Part 4 — Job title standardisation

-- Convert job_title to UPPER case
-- Replace any 'Sr.' with 'Senior'
-- Replace any 'Jr.' with 'Junior'
-- Show only employees whose job title contains 'Manager' or 'Lead'


-- Part 5 — Address parsing
-- Extract the city and PIN code from the address:
-- Format: 'Street, City, State - PIN'
-- emp_id     city         pin_code
--    1       Hyderabad    500001



SELECT * FROM employees_11;

---part--1
SELECT emp_id,
SPLIT_PART(full_name,' ',1) AS first_name,
SPLIT_PART(full_name,' ',2) AS last_name
FROM employees_11

--part--2
SELECT emp_id,full_name,
--SPLIT_PART(email,'@',2) AS domain_name
SUBSTRING(email,POSITION('@' IN email)+1) AS domain_name
FROM employees_11

--part--3
SELECT emp_id,
--SUBSTRING(phone,3) AS clean_phone
REPLACE(phone,'+91-','') AS clean_phone
FROM employees_11

--part--4

SELECT emp_id,
UPPER(REPLACE(REPLACE(job_title,'Sr.','senior'),'Jr.','junior')) AS job_title
FROM employees_11
WHERE job_title LIKE '%Manager%' OR job_title LIKE '%Lead%'



--part--5
SELECT emp_id,
SPLIT_PART(address,',',2) AS city,
SPLIT_PART(address,'-',2) AS pin
FROM employees_11
	