USE hospital_records;

INSERT INTO departments (dept_name) VALUES
('Cardiology'),('Neurology'),('Orthopedics'),('Pediatrics'),('Dermatology'),
('General Medicine'),('ENT'),('Oncology'),('Gynecology'),('Urology');

INSERT INTO doctors (doctor_name, department_id, phone) VALUES
('Dr. Asha Mehta',1,'9900000001'),('Dr. Rohan Das',2,'9900000002'),
('Dr. Kavita Rao',3,'9900000003'),('Dr. Sunil Iyer',4,'9900000004'),
('Dr. Neha Kapoor',5,'9900000005'),('Dr. Arvind Jain',6,'9900000006'),
('Dr. Priti Shah',7,'9900000007'),('Dr. Manoj Nair',8,'9900000008'),
('Dr. Leena Paul',9,'9900000009'),('Dr. Vivek Sen',10,'9900000010');

INSERT INTO patients (full_name, address, phone, dob) VALUES
('Ramesh Gupta','Delhi','9800000001','1980-05-10'),
('Sita Verma','Mumbai','9800000002','1992-11-20'),
('Arun Kumar','Chennai','9800000003','1975-03-15'),
('Meena Joshi','Pune','9800000004','1988-07-01'),
('Karan Patel','Ahmedabad','9800000005','2001-01-25'),
('Divya Nair','Kochi','9800000006','1995-09-09'),
('Farhan Ali','Hyderabad','9800000007','1983-12-30'),
('Pooja Rao','Bengaluru','9800000008','1990-04-18'),
('Nitin Shah','Jaipur','9800000009','1979-06-22'),
('Anita Roy','Kolkata','9800000010','1986-08-14');

INSERT INTO visits (patient_id, doctor_id, visit_date, diagnosis, prescription) VALUES
(1,1,'2026-09-05','Hypertension','Amlodipine'),
(2,6,'2026-09-12','Fever','Paracetamol'),
(3,2,'2026-10-02','Migraine','Sumatriptan'),
(4,3,'2026-10-10','Fracture','Cast + Painkiller'),
(5,4,'2026-10-15','Flu','Rest + Fluids'),
(6,5,'2026-11-01','Rash','Antihistamine'),
(7,7,'2026-08-20','Sinusitis','Nasal spray'),
(8,8,'2026-09-25','Checkup','Follow-up'),
(9,9,'2026-10-28','Consultation','Vitamins'),
(10,10,'2026-11-05','UTI','Antibiotic');

INSERT INTO billing (visit_id, bill_amount, bill_status) VALUES
(1,1500.00,'PAID'),
(2,500.00,'OPEN'),
(3,2200.00,'PAID'),
(4,8000.00,'OPEN'),
(5,700.00,'PAID'),
(6,900.00,'OPEN'),
(7,1200.00,'PAID'),
(8,2500.00,'OPEN'),
(9,1100.00,'PAID'),
(10,1800.00,'OPEN');
