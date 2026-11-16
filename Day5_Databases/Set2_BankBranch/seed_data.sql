USE bank_branch;

INSERT INTO branches (branch_name, city) VALUES
('Main Branch','Mumbai'),('City Center','Delhi'),('Tech Park','Bengaluru'),
('Harbour','Chennai'),('Lakeside','Pune'),('Old Town','Kolkata'),
('Greenfield','Hyderabad'),('Market Road','Ahmedabad'),
('Hill View','Jaipur'),('Riverfront','Lucknow');

INSERT INTO relationship_managers (rm_name, branch_id) VALUES
('Anita Rao',1),('Vikram Shah',2),('Meera Iyer',3),('Rohit Das',4),
('Kiran Patil',5),('Sana Khan',6),('Arjun Nair',7),('Pooja Mehta',8),
('Dev Singh',9),('Neha Gupta',10);

INSERT INTO customers (full_name, address, phone, rm_id) VALUES
('Ravi Kumar','12 MG Road, Mumbai','9810000001',1),
('Priya Sharma','8 CP, Delhi','9810000002',2),
('Aman Verma','22 Whitefield, Bengaluru','9810000003',3),
('Leela Menon','5 Marina, Chennai','9810000004',4),
('Suresh Patil','9 FC Road, Pune','9810000005',5),
('Nisha Roy','3 Park St, Kolkata','9810000006',6),
('Imran Ali','14 Banjara Hills, Hyderabad','9810000007',7),
('Kavya Desai','7 CG Road, Ahmedabad','9810000008',8),
('Rahul Jain','2 MI Road, Jaipur','9810000009',9),
('Tara Singh','11 Hazratganj, Lucknow','9810000010',10),
('Mohan Lal','44 Andheri, Mumbai','9810000011',1),
('Diya Sen','18 Salt Lake, Kolkata','9810000012',6);

INSERT INTO accounts (account_number, customer_id, branch_id, account_type, balance, opened_date) VALUES
('ACC1001',1,1,'SAVINGS',75000.00,'2026-08-10'),
('ACC1002',2,2,'CURRENT',150000.00,'2026-07-15'),
('ACC1003',3,3,'SALARY',45000.00,'2026-09-01'),
('ACC1004',4,4,'SAVINGS',22000.00,'2026-06-20'),
('ACC1005',5,5,'FD',300000.00,'2026-08-25'),
('ACC1006',6,6,'CURRENT',98000.00,'2026-05-12'),
('ACC1007',7,7,'SAVINGS',61000.00,'2026-09-18'),
('ACC1008',8,8,'SALARY',38000.00,'2026-07-30'),
('ACC1009',9,9,'SAVINGS',120000.00,'2026-10-02'),
('ACC1010',10,10,'FD',500000.00,'2026-04-05'),
('ACC1011',11,1,'CURRENT',82000.00,'2026-08-05'),
('ACC1012',12,6,'SAVINGS',27000.00,'2026-09-22');
