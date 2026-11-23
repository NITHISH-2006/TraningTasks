USE day9_insurance_premium;

INSERT INTO customers (id, name, email, phone, pan_number) VALUES
    (1, 'Neha Joshi',  'neha@example.com',  '9876500001', 'ABCDE1234F'),
    (2, 'Sanjay Patil','sanjay@example.com','9876500002', 'FGHIJ5678K'),
    (3, 'Divya Iyer',  'divya@example.com', '9876500003', 'KLMNO9012P');

INSERT INTO policies
    (id, policy_no, customer_id, policy_type, status, start_date, end_date, premium_amount, sum_assured) VALUES
    (1, 'POL-1001', 1, 'Health',   'ACTIVE', '2025-12-02', '2026-12-01', 12000.00, 500000.00),
    (2, 'POL-1002', 2, 'Motor',    'ACTIVE', '2025-12-01', '2026-11-30',  8500.00, 400000.00),
    (3, 'POL-1003', 3, 'Travel',   'ACTIVE', '2025-11-01', '2026-11-01',  3000.00, 100000.00),
    (4, 'POL-1004', 1, 'Term Life','LAPSED', '2024-10-01', '2025-10-01', 15000.00, 800000.00),
    (5, 'POL-1005', 2, 'Home',     'ACTIVE', '2026-01-01', '2027-05-01',  6400.00, 300000.00);

INSERT INTO claims (id, claim_no, policy_id, status, amount) VALUES
    (1, 'CLM-5001', 2, 'PENDING', 25000.00),
    (2, 'CLM-5002', 1, 'APPROVED', 12000.00);
