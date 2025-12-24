-- CREATE DATABASE;
-- Users Table 
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL,
    email varchar(150) UNIQUE NOT NULL,
    password text NOT NULL,
    phone varchar(19) NOT NULL,
    role varchar(10) CHECK (role IN ('Admin', 'Customer'))
);

-- Vehicles Table 
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL,
    type varchar(24) CHECK (type IN ('car', 'bike', 'truck')),
    model varchar(10),
    registration_number varchar(50) UNIQUE NOT NULL,
    rental_price int NOT NULL,
    status varchar(30) CHECK (status IN ('available', 'rented', 'maintenance'))
);

-- Bookings Table  (Foreign Keys)
CREATE TABLE bookings (
    bookings_id SERIAL PRIMARY KEY,
    user_id int NOT NULL,
    vehicle_id int NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status varchar(30) CHECK (
        status IN ('pending', 'confirmed', 'completed', 'cancelled')
    ),
    total_cost int NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id)
);

INSERT INTO
    users (name, email, password, phone, role)
VALUES
    (
        'Alice Ahmed',
        'alice@example.com',
        'pass123',
        '01711223344',
        'Customer'
    ),
    (
        'Bob Smith',
        'bob@example.com',
        'pass456',
        '01822334455',
        'Admin'
    ),
    (
        'Charlie',
        'charlie@example.com',
        'pass789',
        '01933445566',
        'Customer'
    );

INSERT INTO
    vehicles (
        name,
        type,
        model,
        registration_number,
        rental_price,
        status
    )
VALUES
    (
        'Toyota Corolla',
        'car',
        '2022',
        'DHK-1234',
        2500,
        'available'
    ),
    (
        'Yamaha R15',
        'bike',
        'V3',
        'DHK-5678',
        1200,
        'available'
    ),
    (
        'TATA Pickup',
        'truck',
        '2021',
        'DHK-9012',
        5000,
        'rented'
    );

INSERT INTO
    bookings (
        user_id,
        vehicle_id,
        start_date,
        end_date,
        total_cost,
        status
    )
VALUES
    (
        1,
        1,
        '2025-12-25',
        '2025-12-27',
        5000,
        'confirmed'
    ),
    (
        1,
        3,
        '2025-12-28',
        '2025-12-30',
        10000,
        'completed'
    );

-- Query 1: JOIN 
SELECT
    b.bookings_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM
    bookings b
    INNER JOIN users u ON b.user_id = u.user_id
    INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;

-- Query 2: EXISTS
SELECT
    *
FROM
    vehicles v
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            bookings b
        WHERE
            b.vehicle_id = v.vehicle_id
    );

-- Query 3: WHERE 
SELECT
    *
FROM
    vehicles
WHERE
    type = 'car'
    AND status = 'available';

-- Query 4: GROUP BY & HAVING 
SELECT
    v.name AS vehicle_name,
    COUNT(b.bookings_id) AS total_bookings
FROM
    vehicles v
    JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY
    v.name
HAVING
    COUNT(b.bookings_id) > 2;

-- To view all data after execution
SELECT
    *
FROM
    users;

SELECT
    *
FROM
    vehicles;

SELECT
    *
FROM
    bookings;

DROP TABLE bookings;

DROP TABLE vehicles;

DROP TABLE users;