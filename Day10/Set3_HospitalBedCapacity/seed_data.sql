USE day10_hospital_capacity;

INSERT INTO wards (id, ward_name, capacity, occupied) VALUES
    (1, 'ICU',       2, 1),
    (2, 'General',   5, 2),
    (3, 'Recovery',  3, 3);

INSERT INTO admissions (id, patient_name, ward_id, admitted_at, status) VALUES
    (1, 'Patient A', 1, '2026-11-20 08:00:00', 'ADMITTED'),
    (2, 'Patient B', 2, '2026-11-20 09:00:00', 'ADMITTED'),
    (3, 'Patient C', 2, '2026-11-20 10:00:00', 'ADMITTED'),
    (4, 'Patient D', 3, '2026-11-20 11:00:00', 'ADMITTED'),
    (5, 'Patient E', 3, '2026-11-20 12:00:00', 'ADMITTED'),
    (6, 'Patient F', 3, '2026-11-20 13:00:00', 'ADMITTED');
