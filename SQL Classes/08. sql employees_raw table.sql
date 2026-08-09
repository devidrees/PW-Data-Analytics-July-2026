USE store_management;

DROP TABLE IF EXISTS employees_raw;

CREATE TABLE employees_raw (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    country VARCHAR(50),
    join_date VARCHAR(20) -- Intentionally a string to teach conversion
);

INSERT INTO employees_raw (emp_id, name, department, salary, country, join_date) VALUES
(1, 'Alice', 'Sales', 60000, 'US', '2023-01-15'), (2, 'Bob', 'Sales', 65000, 'US', '2023-02-10'),
(3, 'Charlie', 'Sales', NULL, 'US', '2023-03-05'), (4, 'Diana', 'IT', 80000, 'US', '2023-04-20'),
(5, 'Evan', 'IT', 75000, 'UK', '2023-05-12'), (6, 'Fiona', 'HR', 55000, 'US', '2023-06-18'),
(7, 'George', 'HR', 60000, 'US', '2023-07-22'), (8, 'Derek', 'Sales', 65000, 'CA', '2023-08-30'),
(9, 'Elena', 'Sales', NULL, 'US', '2023-09-14'), (10, 'Felix', 'Sales', 50000, 'US', '2023-10-01'),
(4, 'Diana', 'IT', 80000, 'US', '2023-04-20'), -- Duplicate
(11, 'Grace', 'Marketing', 70000, 'US', '2023-11-05'), (12, 'Henry', 'Marketing', NULL, 'US', '2023-11-20'),
(13, 'Ivy', 'IT', 82000, 'US', '2023-12-01'), (14, 'Jack', 'HR', 58000, 'AU', '2024-01-10'),
(15, 'Kelly', 'Sales', 62000, 'US', '2024-02-15'), (16, 'Liam', 'IT', 78000, 'US', '2024-03-22'),
(17, 'Mia', 'Marketing', 71000, 'US', '2024-04-18'), (18, 'Noah', 'Sales', 64000, 'US', '2024-05-05'),
(19, 'Olivia', 'HR', NULL, 'US', '2024-06-12'), (20, 'Paul', 'IT', 85000, 'US', '2024-07-25'),
(15, 'Kelly', 'Sales', 62000, 'US', '2024-02-15'), -- Duplicate
(21, 'Quinn', 'Marketing', 69000, 'UK', '2024-08-30'), (22, 'Ryan', 'Sales', 61000, 'US', '2024-09-14'),
(23, 'Sophia', 'HR', 57000, 'US', '2024-10-02'), (24, 'Tom', 'IT', NULL, 'US', '2024-11-11'),
(25, 'Uma', 'Marketing', 72000, 'US', '2024-12-05'), (26, 'Victor', 'Sales', 66000, 'US', '2025-01-20'),
(27, 'Wendy', 'IT', 79000, 'CA', '2025-02-15'), (28, 'Xavier', 'HR', 59000, 'US', '2025-03-10'),
(29, 'Yara', 'Sales', 63000, 'US', '2025-04-22'), (30, 'Zane', 'Marketing', 73000, 'US', '2025-05-18'),
(31, 'Alice_B', 'Sales', 60500, 'US', '2025-06-01'), (32, 'Bob_B', 'IT', 76000, 'US', '2025-06-15'),
(22, 'Ryan', 'Sales', 61000, 'US', '2024-09-14'), -- Duplicate
(33, 'Charlie_B', 'HR', NULL, 'US', '2025-07-10'), (34, 'Diana_B', 'Marketing', 74000, 'US', '2025-07-25'),
(35, 'Evan_B', 'Sales', 67000, 'US', '2025-08-05'), (36, 'Fiona_B', 'IT', 81000, 'UK', '2025-08-20'),
(37, 'George_B', 'HR', 61000, 'US', '2025-09-10'), (38, 'Derek_B', 'Marketing', 68000, 'US', '2025-09-28'),
(39, 'Elena_B', 'Sales', NULL, 'US', '2025-10-15'), (40, 'Felix_B', 'IT', 83000, 'US', '2025-11-02'),
(41, 'Grace_B', 'HR', 62000, 'US', '2025-11-20'), (42, 'Henry_B', 'Marketing', 75000, 'US', '2025-12-10'),
(43, 'Ivy_B', 'Sales', 68000, 'US', '2026-01-05'), (44, 'Jack_B', 'IT', 84000, 'CA', '2026-01-22'),
(45, 'Kelly_B', 'HR', NULL, 'US', '2026-02-15'), (46, 'Liam_B', 'Marketing', 76000, 'US', '2026-03-01'),
(34, 'Diana_B', 'Marketing', 74000, 'US', '2025-07-25'), -- Duplicate
(47, 'Mia_B', 'Sales', 69000, 'US', '2026-03-20'), (48, 'Noah_B', 'IT', 86000, 'US', '2026-04-10'),
(49, 'Olivia_B', 'HR', 63000, 'US', '2026-04-28'), (50, 'Paul_B', 'Marketing', 77000, 'US', '2026-05-15'),
(51, 'Quinn_B', 'Sales', 70000, 'US', '2026-06-05'), (52, 'Ryan_B', 'IT', NULL, 'US', '2026-06-25'),
(53, 'Sophia_B', 'HR', 64000, 'UK', '2026-07-12'), (54, 'Tom_B', 'Marketing', 78000, 'US', '2026-07-30'),
(55, 'Uma_B', 'Sales', 71000, 'US', '2026-08-18'), (56, 'Victor_B', 'IT', 87000, 'US', '2026-09-05'),
(57, 'Wendy_B', 'HR', 65000, 'US', '2026-09-25'), (58, 'Xavier_B', 'Marketing', NULL, 'US', '2026-10-15'),
(48, 'Noah_B', 'IT', 86000, 'US', '2026-04-10'), -- Duplicate
(59, 'Yara_B', 'Sales', 72000, 'US', '2026-11-02'), (60, 'Zane_B', 'IT', 88000, 'US', '2026-11-20'),
(61, 'Alice_C', 'HR', 66000, 'CA', '2026-12-10'), (62, 'Bob_C', 'Marketing', 79000, 'US', '2027-01-05'),
(63, 'Charlie_C', 'Sales', 73000, 'US', '2027-01-25'), (64, 'Diana_C', 'IT', 89000, 'US', '2027-02-15'),
(65, 'Evan_C', 'HR', NULL, 'US', '2027-03-08'), (66, 'Fiona_C', 'Marketing', 80000, 'US', '2027-03-28'),
(67, 'George_C', 'Sales', 74000, 'US', '2027-04-15'), (68, 'Derek_C', 'IT', 90000, 'UK', '2027-05-05'),
(69, 'Elena_C', 'HR', 67000, 'US', '2027-05-25'), (70, 'Felix_C', 'Marketing', 81000, 'US', '2027-06-15'),
(64, 'Diana_C', 'IT', 89000, 'US', '2027-02-15'), -- Duplicate
(71, 'Grace_C', 'Sales', NULL, 'US', '2027-07-02'), (72, 'Henry_C', 'IT', 91000, 'US', '2027-07-22'),
(73, 'Ivy_C', 'HR', 68000, 'US', '2027-08-10'), (74, 'Jack_C', 'Marketing', 82000, 'CA', '2027-08-30'),
(75, 'Kelly_C', 'Sales', 75000, 'US', '2027-09-18'), (76, 'Liam_C', 'IT', 92000, 'US', '2027-10-08'),
(77, 'Mia_C', 'HR', 69000, 'US', '2027-10-28'), (78, 'Noah_C', 'Marketing', NULL, 'US', '2027-11-15'),
(79, 'Olivia_C', 'Sales', 76000, 'UK', '2027-12-05'), (80, 'Paul_C', 'IT', 93000, 'US', '2027-12-25'),
(72, 'Henry_C', 'IT', 91000, 'US', '2027-07-22'), -- Duplicate
(81, 'Quinn_C', 'HR', 70000, 'US', '2028-01-12'), (82, 'Ryan_C', 'Marketing', 83000, 'US', '2028-02-02'),
(83, 'Sophia_C', 'Sales', 77000, 'US', '2028-02-22'), (84, 'Tom_C', 'IT', 94000, 'US', '2028-03-15'),
(85, 'Uma_C', 'HR', NULL, 'US', '2028-04-05'), (86, 'Victor_C', 'Marketing', 84000, 'CA', '2028-04-25'),
(87, 'Wendy_C', 'Sales', 78000, 'US', '2028-05-15'), (88, 'Xavier_C', 'IT', 95000, 'US', '2028-06-05'),
(89, 'Yara_C', 'HR', 71000, 'US', '2028-06-25'), (90, 'Zane_C', 'Marketing', 85000, 'US', '2028-07-15'),
(84, 'Tom_C', 'IT', 94000, 'US', '2028-03-15'), -- Duplicate
(91, 'Alice_D', 'Sales', 79000, 'UK', '2028-08-02'), (92, 'Bob_D', 'IT', NULL, 'US', '2028-08-22'),
(93, 'Charlie_D', 'HR', 72000, 'US', '2028-09-10'), (94, 'Diana_D', 'Marketing', 86000, 'US', '2028-09-30'),
(95, 'Evan_D', 'Sales', 80000, 'US', '2028-10-20'), (96, 'Fiona_D', 'IT', 96000, 'US', '2028-11-10'),
(97, 'George_D', 'HR', 73000, 'CA', '2028-11-30'), (98, 'Derek_D', 'Marketing', 87000, 'US', '2028-12-20'),
(99, 'Elena_D', 'Sales', 81000, 'US', '2029-01-10'), (100, 'Felix_D', 'IT', 97000, 'US', '2029-01-30'),
(95, 'Evan_D', 'Sales', 80000, 'US', '2028-10-20'), -- Duplicate
(101, 'Grace_D', 'HR', NULL, 'US', '2029-02-18'), (102, 'Henry_D', 'Marketing', 88000, 'US', '2029-03-10'),
(103, 'Ivy_D', 'Sales', 82000, 'US', '2029-03-30'), (104, 'Jack_D', 'IT', 98000, 'UK', '2029-04-20'),
(105, 'Kelly_D', 'HR', 74000, 'US', '2029-05-10'), (106, 'Liam_D', 'Marketing', 89000, 'US', '2029-05-30'),
(107, 'Mia_D', 'Sales', 83000, 'US', '2029-06-20'), (108, 'Noah_D', 'IT', 99000, 'US', '2029-07-10'),
(109, 'Olivia_D', 'HR', 75000, 'US', '2029-07-30'), (110, 'Paul_D', 'Marketing', NULL, 'CA', '2029-08-20'),
(108, 'Noah_D', 'IT', 99000, 'US', '2029-07-10'), -- Duplicate
(111, 'Quinn_D', 'Sales', 84000, 'US', '2029-09-08'), (112, 'Ryan_D', 'IT', 100000, 'US', '2029-09-28'),
(113, 'Sophia_D', 'HR', 76000, 'US', '2029-10-18'), (114, 'Tom_D', 'Marketing', 90000, 'US', '2029-11-05'),
(115, 'Uma_D', 'Sales', 85000, 'UK', '2029-11-25'), (116, 'Victor_D', 'IT', 101000, 'US', '2029-12-15'),
(117, 'Wendy_D', 'HR', NULL, 'US', '2030-01-05'), (118, 'Xavier_D', 'Marketing', 91000, 'US', '2030-01-25'),
(119, 'Yara_D', 'Sales', 86000, 'US', '2030-02-15'), (120, 'Zane_D', 'IT', 102000, 'CA', '2030-03-05'),
(118, 'Xavier_D', 'Marketing', 91000, 'US', '2030-01-25'), -- Duplicate
(121, 'Alice_E', 'HR', 77000, 'US', '2030-03-25'), (122, 'Bob_E', 'Marketing', 92000, 'US', '2030-04-15'),
(123, 'Charlie_E', 'Sales', 87000, 'US', '2030-05-05'), (124, 'Diana_E', 'IT', 103000, 'US', '2030-05-25'),
(125, 'Evan_E', 'HR', 78000, 'US', '2030-06-15'), (126, 'Fiona_E', 'Marketing', NULL, 'UK', '2030-07-05'),
(127, 'George_E', 'Sales', 88000, 'US', '2030-07-25'), (128, 'Derek_E', 'IT', 104000, 'US', '2030-08-15'),
(129, 'Elena_E', 'HR', 79000, 'US', '2030-09-05'), (130, 'Felix_E', 'Marketing', 93000, 'CA', '2030-09-25'),
(128, 'Derek_E', 'IT', 104000, 'US', '2030-08-15'), -- Duplicate
(131, 'Grace_E', 'Sales', 89000, 'US', '2030-10-15'), (132, 'Henry_E', 'IT', 105000, 'US', '2030-11-05'),
(133, 'Ivy_E', 'HR', 80000, 'US', '2030-11-25'), (134, 'Jack_E', 'Marketing', 94000, 'US', '2030-12-15'),
(135, 'Kelly_E', 'Sales', NULL, 'US', '2031-01-05'), (136, 'Liam_E', 'IT', 106000, 'US', '2031-01-25'),
(137, 'Mia_E', 'HR', 81000, 'UK', '2031-02-15'), (138, 'Noah_E', 'Marketing', 95000, 'US', '2031-03-05'),
(139, 'Olivia_E', 'Sales', 90000, 'US', '2031-03-25'), (140, 'Paul_E', 'IT', 107000, 'US', '2031-04-15'),
(138, 'Noah_E', 'Marketing', 95000, 'US', '2031-03-05'), -- Duplicate
(141, 'Quinn_E', 'HR', 82000, 'CA', '2031-05-05'), (142, 'Ryan_E', 'Marketing', 96000, 'US', '2031-05-25'),
(143, 'Sophia_E', 'Sales', 91000, 'US', '2031-06-15'), (144, 'Tom_E', 'IT', 108000, 'US', '2031-07-05'),
(145, 'Uma_E', 'HR', 83000, 'US', '2031-07-25'), (146, 'Victor_E', 'Marketing', 97000, 'US', '2031-08-15'),
(147, 'Wendy_E', 'Sales', 92000, 'US', '2031-09-05'), (148, 'Xavier_E', 'IT', NULL, 'US', '2031-09-25'),
(149, 'Yara_E', 'HR', 84000, 'UK', '2031-10-15'), (150, 'Zane_E', 'Marketing', 98000, 'US', '2031-11-05');