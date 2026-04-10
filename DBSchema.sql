-- ============================================================
-- 1. Enable dblink (required for conditional CREATE DATABASE)
-- ============================================================
CREATE EXTENSION IF NOT EXISTS dblink;


-- ============================================================
-- 2. Create database fleet_db ONLY if it does not already exist
-- ============================================================
DO
$$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_database WHERE datname = 'fleet_db'
    ) THEN
        PERFORM dblink_exec('dbname=postgres', 'CREATE DATABASE fleet_db');
    END IF;
END
$$;


-- ============================================================
-- 3. USERS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);


-- ============================================================
-- 4. VEHICLES TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS vehicles (
    id SERIAL PRIMARY KEY,
    model VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    booked BOOLEAN NOT NULL DEFAULT FALSE
);


-- ============================================================
-- 5. CUSTOMERS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(150) NOT NULL,
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) NOT NULL,
    driver_license_number VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    quadrant VARCHAR(50),
    credit_card_number VARCHAR(50)
);


-- ============================================================
-- 6. INVOICES TABLE (created before reservations to avoid circular FK)
-- ============================================================
CREATE TABLE IF NOT EXISTS invoices (
    id SERIAL PRIMARY KEY,
    reservation_id INTEGER, -- FK added later
    customer_id INTEGER NOT NULL,
    vehicle_id INTEGER NOT NULL,
    vehicle_price DECIMAL(10,2) NOT NULL,
    total_days INTEGER NOT NULL,
    insurance BOOLEAN NOT NULL DEFAULT FALSE,
    tax DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_invoices_customer
        FOREIGN KEY (customer_id) REFERENCES customers(id),

    CONSTRAINT fk_invoices_vehicle
        FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
);


-- ============================================================
-- 7. RESERVATIONS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS reservations (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    vehicle_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    invoice_id INTEGER,

    CONSTRAINT fk_reservations_customer
        FOREIGN KEY (customer_id) REFERENCES customers(id),

    CONSTRAINT fk_reservations_vehicle
        FOREIGN KEY (vehicle_id) REFERENCES vehicles(id),

    CONSTRAINT fk_reservations_invoice
        FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);


-- ============================================================
-- 8. Add missing invoice → reservation FK
-- ============================================================
ALTER TABLE invoices
    ADD CONSTRAINT fk_invoices_reservation
    FOREIGN KEY (reservation_id) REFERENCES reservations(id)
    ON DELETE SET NULL;