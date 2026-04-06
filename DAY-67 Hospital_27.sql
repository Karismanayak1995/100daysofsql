-- Write a query that returns for each doctor, their performance summary:
-- Column                        Description
--doctor_name                    Doctor's name
--speciality                     Their speciality
--total_completed                Count of completed appointments
--total_revenue                  Sum of fees from completed appointments
--cancellation_rate              cancelled / total appointments * 100
--avg_fee                        Average fee per completed appointment
--revenue_rank                   Rank by total_revenue within their speciality
--top_city                       City from which they get the most patients
-- Only include doctors who have at least 5 completed appointments.



CREATE TABLE doctors_27 (
    doctor_id    INT PRIMARY KEY,
    name         VARCHAR(50),
    speciality   VARCHAR(50),
    city         VARCHAR(50)
);

CREATE TABLE patients_27 (
    patient_id   INT PRIMARY KEY,
    name         VARCHAR(50),
    age          INT,
    city         VARCHAR(50)
);

CREATE TABLE appointments_27 (
    appt_id      INT PRIMARY KEY,
    doctor_id    INT,
    patient_id   INT,
    appt_date    DATE,
    status       VARCHAR(20),  -- 'completed', 'cancelled', 'no_show'
    fee          DECIMAL(10,2)
);


-- Doctors
INSERT INTO doctors_27 VALUES
(1,  'Dr. Arjun Rao',     'Cardiology',    'Hyderabad'),
(2,  'Dr. Priya Nair',    'Cardiology',    'Mumbai'),
(3,  'Dr. Kiran Mehta',   'Neurology',     'Bangalore'),
(4,  'Dr. Sneha Iyer',    'Neurology',     'Hyderabad'),
(5,  'Dr. Ravi Kumar',    'Orthopedics',   'Chennai'),
(6,  'Dr. Divya Sharma',  'Orthopedics',   'Hyderabad'),
(7,  'Dr. Amit Joshi',    'Cardiology',    'Delhi'),
(8,  'Dr. Neha Gupta',    'Dermatology',   'Mumbai');  -- < 5 completed, excluded

-- Patients
INSERT INTO patients_27 VALUES
(1,  'Anil Reddy',     45, 'Hyderabad'),
(2,  'Sunita Verma',   38, 'Mumbai'),
(3,  'Rahul Das',      52, 'Bangalore'),
(4,  'Meena Pillai',   61, 'Chennai'),
(5,  'Vijay Singh',    29, 'Delhi'),
(6,  'Lakshmi Rao',    47, 'Hyderabad'),
(7,  'Rohit Sharma',   35, 'Mumbai'),
(8,  'Pooja Iyer',     42, 'Hyderabad'),
(9,  'Deepak Nair',    55, 'Bangalore'),
(10, 'Kavya Menon',    31, 'Chennai'),
(11, 'Suresh Babu',    48, 'Hyderabad'),
(12, 'Anita Kulkarni', 39, 'Pune');

-- Appointments
INSERT INTO appointments_27 VALUES
-- Dr. Arjun Rao (doctor 1) - Cardiology, Hyderabad
(101, 1, 1,  '2024-01-05', 'completed',  1500.00),
(102, 1, 6,  '2024-01-15', 'completed',  1500.00),
(103, 1, 8,  '2024-02-10', 'completed',  1800.00),
(104, 1, 11, '2024-02-20', 'completed',  1500.00),
(105, 1, 1,  '2024-03-05', 'completed',  1600.00),
(106, 1, 6,  '2024-03-18', 'cancelled',  1500.00),
(107, 1, 2,  '2024-04-01', 'cancelled',  1500.00),
(108, 1, 8,  '2024-04-22', 'no_show',    1500.00),

-- Dr. Priya Nair (doctor 2) - Cardiology, Mumbai
(109, 2, 2,  '2024-01-08', 'completed',  2000.00),
(110, 2, 7,  '2024-01-20', 'completed',  2000.00),
(111, 2, 3,  '2024-02-05', 'completed',  2200.00),
(112, 2, 2,  '2024-02-25', 'completed',  2000.00),
(113, 2, 7,  '2024-03-10', 'completed',  2100.00),
(114, 2, 12, '2024-03-28', 'cancelled',  2000.00),
(115, 2, 3,  '2024-04-15', 'no_show',    2000.00),

-- Dr. Kiran Mehta (doctor 3) - Neurology, Bangalore
(116, 3, 3,  '2024-01-12', 'completed',  2500.00),
(117, 3, 9,  '2024-01-25', 'completed',  2500.00),
(118, 3, 3,  '2024-02-08', 'completed',  2700.00),
(119, 3, 9,  '2024-02-22', 'completed',  2500.00),
(120, 3, 1,  '2024-03-07', 'completed',  2600.00),
(121, 3, 9,  '2024-03-20', 'cancelled',  2500.00),
(122, 3, 3,  '2024-04-10', 'no_show',    2500.00),

-- Dr. Sneha Iyer (doctor 4) - Neurology, Hyderabad
(123, 4, 1,  '2024-01-09', 'completed',  2200.00),
(124, 4, 6,  '2024-01-22', 'completed',  2200.00),
(125, 4, 8,  '2024-02-12', 'completed',  2400.00),
(126, 4, 11, '2024-02-28', 'completed',  2200.00),
(127, 4, 1,  '2024-03-14', 'completed',  2300.00),
(128, 4, 6,  '2024-04-02', 'cancelled',  2200.00),
(129, 4, 8,  '2024-04-18', 'cancelled',  2200.00),

-- Dr. Ravi Kumar (doctor 5) - Orthopedics, Chennai
(130, 5, 4,  '2024-01-11', 'completed',  1800.00),
(131, 5, 10, '2024-01-24', 'completed',  1800.00),
(132, 5, 4,  '2024-02-14', 'completed',  2000.00),
(133, 5, 10, '2024-03-01', 'completed',  1800.00),
(134, 5, 4,  '2024-03-17', 'completed',  1900.00),
(135, 5, 12, '2024-04-05', 'no_show',    1800.00),

-- Dr. Divya Sharma (doctor 6) - Orthopedics, Hyderabad
(136, 6, 1,  '2024-01-14', 'completed',  1600.00),
(137, 6, 6,  '2024-01-27', 'completed',  1600.00),
(138, 6, 8,  '2024-02-16', 'completed',  1800.00),
(139, 6, 11, '2024-03-03', 'completed',  1600.00),
(140, 6, 1,  '2024-03-19', 'completed',  1700.00),
(141, 6, 6,  '2024-04-07', 'cancelled',  1600.00),
(142, 6, 12, '2024-04-20', 'no_show',    1600.00),

-- Dr. Amit Joshi (doctor 7) - Cardiology, Delhi
(143, 7, 5,  '2024-01-16', 'completed',  1700.00),
(144, 7, 12, '2024-01-29', 'completed',  1700.00),
(145, 7, 5,  '2024-02-18', 'completed',  1900.00),
(146, 7, 12, '2024-03-05', 'completed',  1700.00),
(147, 7, 5,  '2024-03-21', 'completed',  1800.00),
(148, 7, 5,  '2024-04-08', 'cancelled',  1700.00),

-- Dr. Neha Gupta (doctor 8) - Dermatology - only 3 completed, excluded
(149, 8, 2,  '2024-01-18', 'completed',  1200.00),
(150, 8, 7,  '2024-02-20', 'completed',  1200.00),
(151, 8, 2,  '2024-03-15', 'completed',  1200.00),
(152, 8, 7,  '2024-04-12', 'cancelled',  1200.00);


SELECT * FROM doctors_27;
SELECT * FROM patients_27;
SELECT * FROM appointments_27;


WITH total_completed_appt AS (
    SELECT d.doctor_id, d.name, d.speciality,
           COUNT(*)        AS total_completed,
           SUM(a.fee)      AS total_revenue,
           AVG(a.fee)      AS avg_fee
    FROM doctors_27 d
    JOIN appointments_27 a ON d.doctor_id = a.doctor_id
    WHERE a.status = 'completed'
    GROUP BY d.doctor_id, d.name, d.speciality
    HAVING COUNT(*) >= 5                          
),
cancellation_rate AS (
    SELECT doctor_id,
           ROUND(
               COUNT(CASE WHEN status = 'cancelled' THEN 1 END)
               / COUNT(*) * 100, 2
           ) AS cancellation_rate
    FROM appointments_27
    GROUP BY doctor_id
),
top_city AS (
    SELECT doctor_id, city
    FROM (
        SELECT a.doctor_id, p.city,
               RANK() OVER (
                   PARTITION BY a.doctor_id
                   ORDER BY COUNT(*) DESC
               ) AS city_rank
        FROM appointments_27 a
        JOIN patients_27 p ON a.patient_id = p.patient_id
        WHERE a.status = 'completed'
        GROUP BY a.doctor_id, p.city
    ) ranked
    WHERE city_rank = 1
)
SELECT
    t.name              AS doctor_name,
    t.speciality,
    t.total_completed,
    t.total_revenue,
    r.cancellation_rate,
    ROUND(t.avg_fee, 2) AS avg_fee,
    c.city              AS top_city,
    DENSE_RANK() OVER (
		PARTITION BY t.speciality
        ORDER BY t.total_revenue DESC            
    )                   AS revenue_rank
FROM total_completed_appt t
JOIN cancellation_rate r ON t.doctor_id = r.doctor_id
JOIN top_city c          ON t.doctor_id = c.doctor_id
ORDER BY t.speciality, revenue_rank;