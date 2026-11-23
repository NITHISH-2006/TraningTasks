USE day8_airline_booking;

INSERT INTO flights (id, flight_no, flight_date, origin, destination) VALUES
    (1, 'AI-241', '2026-11-15', 'DEL', 'BOM'),
    (2, 'AI-512', '2026-11-16', 'BLR', 'GOI');

INSERT INTO seats (id, flight_id, seat_no, travel_class, fare, status) VALUES
    (1, 1, '1A', 'BUSINESS', 9500.00, 'AVAILABLE'),
    (2, 1, '1B', 'BUSINESS', 9500.00, 'AVAILABLE'),
    (3, 1, '12A', 'ECONOMY', 4200.00, 'AVAILABLE'),
    (4, 1, '12B', 'ECONOMY', 4200.00, 'AVAILABLE'),
    (5, 1, '12C', 'ECONOMY', 3900.00, 'AVAILABLE'),
    (6, 2, '2A', 'BUSINESS', 7200.00, 'AVAILABLE'),
    (7, 2, '10A', 'ECONOMY', 3100.00, 'AVAILABLE'),
    (8, 2, '10B', 'ECONOMY', 3100.00, 'BOOKED');

INSERT INTO passengers (id, full_name, email) VALUES
    (1, 'Ananya Iyer', 'ananya@example.com'),
    (2, 'Rahul Shah', 'rahul@example.com'),
    (3, 'Kavya Menon', 'kavya@example.com');

INSERT INTO bookings (id, booking_ref, flight_id, seat_id, passenger_id, fare, status) VALUES
    (1, 'BK-SEED-8', 2, 8, 3, 3100.00, 'CONFIRMED');
