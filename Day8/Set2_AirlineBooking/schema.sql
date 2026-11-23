DROP DATABASE IF EXISTS day8_airline_booking;
CREATE DATABASE day8_airline_booking;
USE day8_airline_booking;

CREATE TABLE flights (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    flight_no VARCHAR(10) NOT NULL UNIQUE,
    flight_date DATE NOT NULL,
    origin VARCHAR(3) NOT NULL,
    destination VARCHAR(3) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE seats (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    flight_id BIGINT NOT NULL,
    seat_no VARCHAR(5) NOT NULL,
    travel_class ENUM('ECONOMY', 'BUSINESS') NOT NULL,
    fare DECIMAL(10,2) NOT NULL,
    status ENUM('AVAILABLE', 'HELD', 'BOOKED') NOT NULL DEFAULT 'AVAILABLE',
    CONSTRAINT uq_seat_flight_no UNIQUE (flight_id, seat_no),
    CONSTRAINT chk_seat_fare_positive CHECK (fare > 0.00),
    CONSTRAINT fk_seat_flight FOREIGN KEY (flight_id) REFERENCES flights(id)
) ENGINE=InnoDB;

CREATE TABLE passengers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE bookings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_ref VARCHAR(30) NOT NULL UNIQUE,
    flight_id BIGINT NOT NULL,
    seat_id BIGINT NOT NULL UNIQUE,
    passenger_id BIGINT NOT NULL,
    fare DECIMAL(10,2) NOT NULL,
    booking_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('CONFIRMED', 'CANCELLED') NOT NULL DEFAULT 'CONFIRMED',
    CONSTRAINT fk_booking_flight FOREIGN KEY (flight_id) REFERENCES flights(id),
    CONSTRAINT fk_booking_seat FOREIGN KEY (seat_id) REFERENCES seats(id),
    CONSTRAINT fk_booking_passenger FOREIGN KEY (passenger_id) REFERENCES passengers(id)
) ENGINE=InnoDB;

CREATE INDEX idx_booking_flight_fare ON bookings(flight_id, fare DESC);
