CREATE TABLE students_30 (
    student_id   INT PRIMARY KEY,
    name         VARCHAR(50),
    city         VARCHAR(50),
    joined_date  DATE
);

CREATE TABLE courses_30 (
    course_id    INT PRIMARY KEY,
    course_name  VARCHAR(50),
    category     VARCHAR(30),  -- 'Tech', 'Business', 'Design', 'Marketing'
    price        DECIMAL(10,2)
);

CREATE TABLE enrollments_30 (
    enroll_id    INT PRIMARY KEY,
    student_id   INT,
    course_id    INT,
    enroll_date  DATE,
    status       VARCHAR(20),  -- 'completed', 'in_progress', 'dropped'
    rating       INT           -- 1 to 5, NULL if not completed
);

-- Students
INSERT INTO students_30 VALUES
(1,  'Arjun Sharma',   'Hyderabad', '2021-03-15'),
(2,  'Priya Reddy',    'Hyderabad', '2022-07-22'),
(3,  'Kiran Mehta',    'Mumbai',    '2021-01-10'),
(4,  'Sneha Iyer',     'Mumbai',    '2020-11-05'),
(5,  'Ravi Kumar',     'Bangalore', '2022-05-19'),
(6,  'Divya Nair',     'Bangalore', '2021-09-30'),
(7,  'Amit Joshi',     'Hyderabad', '2022-02-14'),
(8,  'Neha Gupta',     'Mumbai',    '2023-06-25'),
(9,  'Suresh Babu',    'Bangalore', '2021-08-11'),
(10, 'Kavya Menon',    'Hyderabad', '2024-02-05'), -- joined 2024, excluded
(11, 'Rohit Verma',    'Mumbai',    '2022-04-18'),
(12, 'Lakshmi Rao',    'Bangalore', '2021-07-09');

-- Courses
INSERT INTO courses_30 VALUES
(1,  'Python Basics',         'Tech',       2999.00),
(2,  'Data Science',          'Tech',       4999.00),
(3,  'Machine Learning',      'Tech',       5999.00),
(4,  'Excel for Business',    'Business',   1999.00),
(5,  'Financial Modelling',   'Business',   3999.00),
(6,  'Digital Marketing',     'Marketing',  2499.00),
(7,  'SEO Fundamentals',      'Marketing',  1499.00),
(8,  'UI/UX Design',          'Design',     3499.00),
(9,  'Figma Masterclass',     'Design',     2999.00),
(10, 'Product Management',    'Business',   4499.00);

-- Enrollments
INSERT INTO enrollments_30 VALUES
-- Arjun (1) - Hyderabad
(101, 1, 1,  '2022-01-10', 'completed',   5),
(102, 1, 2,  '2022-03-15', 'completed',   4),
(103, 1, 3,  '2022-07-20', 'completed',   5),
(104, 1, 4,  '2022-10-05', 'in_progress', NULL),
(105, 1, 6,  '2023-01-12', 'dropped',     NULL),

-- Priya (2) - Hyderabad
(106, 2, 6,  '2022-08-01', 'completed',   4),
(107, 2, 7,  '2022-10-18', 'completed',   3),
(108, 2, 8,  '2023-01-25', 'completed',   5),
(109, 2, 9,  '2023-05-10', 'completed',   4),
(110, 2, 4,  '2023-08-22', 'dropped',     NULL),

-- Kiran (3) - Mumbai
(111, 3, 2,  '2021-06-10', 'completed',   4),
(112, 3, 3,  '2021-09-20', 'completed',   5),
(113, 3, 1,  '2022-01-15', 'completed',   4),
(114, 3, 5,  '2022-05-30', 'in_progress', NULL),
(115, 3, 10, '2022-09-14', 'dropped',     NULL),

-- Sneha (4) - Mumbai
(116, 4, 4,  '2021-03-10', 'completed',   3),
(117, 4, 5,  '2021-07-22', 'completed',   4),
(118, 4, 10, '2022-01-18', 'completed',   5),
(119, 4, 6,  '2022-06-05', 'completed',   4),
(120, 4, 7,  '2022-11-30', 'dropped',     NULL),

-- Ravi (5) - Bangalore
(121, 5, 1,  '2022-09-05', 'completed',   5),
(122, 5, 2,  '2023-01-20', 'completed',   4),
(123, 5, 3,  '2023-05-15', 'completed',   5),
(124, 5, 8,  '2023-08-10', 'in_progress', NULL),

-- Divya (6) - Bangalore
(125, 6, 8,  '2022-02-14', 'completed',   5),
(126, 6, 9,  '2022-05-30', 'completed',   4),
(127, 6, 6,  '2022-09-18', 'completed',   4),
(128, 6, 7,  '2023-01-25', 'completed',   3),
(129, 6, 4,  '2023-06-10', 'dropped',     NULL),

-- Amit (7) - Hyderabad
(130, 7, 4,  '2022-04-01', 'completed',   4),
(131, 7, 5,  '2022-08-15', 'completed',   5),
(132, 7, 10, '2023-01-10', 'completed',   4),
(133, 7, 6,  '2023-05-22', 'in_progress', NULL),
(134, 7, 1,  '2023-09-08', 'dropped',     NULL),

-- Neha (8) - Mumbai - only 2 completed, excluded
(135, 8, 6,  '2023-08-10', 'completed',   4),
(136, 8, 7,  '2023-10-25', 'completed',   3),
(137, 8, 8,  '2024-01-15', 'in_progress', NULL),

-- Suresh (9) - Bangalore
(138, 9, 1,  '2021-10-05', 'completed',   4),
(139, 9, 4,  '2022-02-18', 'completed',   3),
(140, 9, 5,  '2022-07-25', 'completed',   5),
(141, 9, 10, '2023-01-15', 'dropped',     NULL),

-- Kavya (10) - joined 2024, excluded
(142, 10, 1, '2024-03-01', 'completed',   5),
(143, 10, 2, '2024-04-15', 'completed',   4),
(144, 10, 3, '2024-05-20', 'completed',   5),

-- Rohit (11) - Mumbai
(145, 11, 2,  '2022-06-10', 'completed',  4),
(146, 11, 3,  '2022-10-22', 'completed',  5),
(147, 11, 1,  '2023-03-15', 'completed',  4),
(148, 11, 8,  '2023-07-28', 'in_progress',NULL),
(149, 11, 9,  '2023-11-10', 'dropped',    NULL),

-- Lakshmi (12) - Bangalore
(150, 12, 8,  '2021-09-15', 'completed',  5),
(151, 12, 9,  '2022-01-28', 'completed',  4),
(152, 12, 6,  '2022-06-10', 'completed',  5),
(153, 12, 7,  '2022-11-25', 'completed',  4),
(154, 12, 4,  '2023-04-08', 'dropped',    NULL);




--Write a query that returns for each student:
--Column                      Description
--student_name                Student's name
--city                        City
--total_completed             Count of completed courses
--total_spent                 Sum of course prices for completed enrollments
--avg_rating_given            Average rating they gave across completed courses
--favourite_category          Category they completed the most courses in
--completion_rate           completed / total enrollments * 100
--city_rank                   Rank by total_spent within their city
--spent_vs_city_avg           Their total_spent minus the city average total_spent

--Only include students who have at least 3 completed courses and joined before 2024.

SELECT * FROM students_30;
SELECT * FROM courses_30;
SELECT * FROM enrollments_30;

WITH details AS (
	SELECT s.student_id,
    s.name AS student_name,
    s.city,
    COUNT(c.course_id) AS total_completed ,
    SUM(c.price) AS total_spent,
    ROUND(AVG(e.rating),2) AS avg_rating_given
    FROM students_30 s
    JOIN enrollments_30 e
    ON s.student_id = e.student_id
    JOIN courses_30 c
    ON e.course_id = c.course_id
    WHERE e.status = 'completed' 
	AND s.joined_date < '2024-01-01'
    GROUP BY s.student_id,s.name,s.city
    HAVING COUNT(DISTINCT c.course_id) >= 3
	),course_completion_rate AS (
	SELECT student_id,
		ROUND(
			COUNT (CASE WHEN status = 'completed' THEN 1 END)
			/COUNT(*) * 100 ,2
		) AS completion_rate
		FROM enrollments_30	
		GROUP BY student_id
	),favourite_category AS (
		SELECT e.student_id,c.category
		FROM (
			SELECT e.student_id,
		    c.category,
			RANK() OVER (
			PARTITION BY e.student_id ORDER BY COUNT(DISTINCT e.course_id) DESC 
			) AS category_rank
			FROM enrollments_30 e
			JOIN courses_30 c
			ON e.course_id = c.course_id
			WHERE e.status = 'completed'
			GROUP BY e.student_id,c.category
		) ranked
		WHERE category_rank = 1
		)
		
SELECT d.student_id,
d.student_name,
d.city,
d.total_completed,
d.total_spent,
d.avg_rating_given,
c.completion_rate,
f.category AS favourite_category,
DENSE_RANK( ) OVER ( 
	PARTITION BY city 
	ORDER BY d.total_spent DESC
) AS city_rank,
ROUND(d.total_spent - AVG(d.total_spent) OVER (PARTITION BY d.city),2) AS spent_vs_city_avg 
FROM details d
JOIN course_completion_rate c 
ON d.student_id = c.student_id
JOIN favourite_category f
ON c.student_id =f.student_id
ORDER BY d.city,city_rank


