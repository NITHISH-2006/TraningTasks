USE day9_telecom_followup;

INSERT INTO plans (id, name, monthly_fee, validity_days, plan_type) VALUES
    (1, 'Prepaid Basic 30',   199.00, 30, 'PREPAID'),
    (2, 'Prepaid Plus 90',    499.00, 90, 'PREPAID'),
    (3, 'Postpaid Family',    799.00, 30, 'POSTPAID');

INSERT INTO subscribers
    (id, subscriber_no, full_name, phone, email, plan_id, connection_type, balance, last_recharge_date, status) VALUES
    (1, 'SUB-9001', 'Amit Verma',  '9800000001', 'amit@example.com',  1, 'PREPAID',  30.00, '2026-11-05', 'ACTIVE'),
    (2, 'SUB-9002', 'Sneha Kulkarni','9800000002','sneha@example.com',2, 'PREPAID',  45.00, '2026-10-20', 'ACTIVE'),
    (3, 'SUB-9003', 'Rohan Gupta', '9800000003', 'rohan@example.com', 2, 'PREPAID', 120.00, '2026-11-10', 'ACTIVE'),
    (4, 'SUB-9004', 'Priya Nair',  '9800000004', 'priya@example.com', 3, 'POSTPAID',200.00, NULL,        'ACTIVE');

INSERT INTO recharges (subscriber_id, amount, recharge_date, recharge_mode) VALUES
    (1, 199.00, '2026-11-05 08:15:00', 'USSD'),
    (2, 499.00, '2026-10-20 19:40:00', 'ONLINE'),
    (3, 499.00, '2026-11-10 11:05:00', 'ONLINE'),
    (3, 100.00, '2026-11-18 14:30:00', 'OFFLINE');
