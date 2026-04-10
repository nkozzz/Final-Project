-- ============================================================
-- SEED DATA FOR FLEET MANAGEMENT SYSTEM (PostgreSQL)
-- ============================================================

-- ===========================
-- USERS
-- ===========================
INSERT INTO users (email, password) VALUES
('admin@fleet.com', 'hashedpassword123'),
('staff1@fleet.com', 'hashedpassword456'),
('staff2@fleet.com', 'hashedpassword789');


-- ===========================
-- VEHICLES
-- ===========================
INSERT INTO vehicles (model, description, price, booked) VALUES
('Toyota Camry 2021', 'Reliable mid-size sedan, great fuel economy.', 55.00, FALSE),
('Honda CR-V 2022', 'Compact SUV with AWD and spacious interior.', 75.00, FALSE),
('Ford F-150 2020', 'Full-size pickup truck with towing package.', 95.00, FALSE),
('Tesla Model 3 2023', 'Electric sedan with autopilot features.', 120.00, FALSE),
('BMW X5 2021', 'Luxury SUV with premium interior.', 150.00, FALSE);


-- ===========================
-- CUSTOMERS
-- ===========================
INSERT INTO customers 
(first_name, last_name, email, phone_number, driver_license_number, address, quadrant, credit_card_number)
VALUES
('John', 'Doe', 'john.doe@example.com', '403-555-1234', 'D1234567', '123 Main St', 'NE', '4111111111111111'),
('Sarah', 'Miller', 'sarah.miller@example.com', '587-555-9876', 'M7654321', '45 Riverbend Dr', 'SE', '5500000000000004'),
('David', 'Nguyen', 'david.nguyen@example.com', '403-555-2222', 'N9988776', '89 Sunset Blvd', 'SW', '340000000000009'),
('Emily', 'Clark', 'emily.clark@example.com', '587-555-3333', 'C1122334', '12 Lakeview Rd', 'NW', '30000000000004'),
('Michael', 'Brown', 'michael.brown@example.com', '403-555-4444', 'B5566778', '77 Aspen Way', 'NE', '6011000000000004');


-- ===========================
-- RESERVATIONS
-- ===========================
INSERT INTO reservations 
(customer_id, vehicle_id, start_date, end_date, invoice_id)
VALUES
(1, 1, '2026-04-05', '2026-04-10', NULL),
(2, 3, '2026-04-12', '2026-04-15', NULL),
(3, 2, '2026-04-20', '2026-04-25', NULL),
(4, 5, '2026-04-18', '2026-04-22', NULL),
(5, 4, '2026-04-01', '2026-04-03', NULL);


-- ===========================
-- INVOICES
-- ===========================
INSERT INTO invoices
(reservation_id, customer_id, vehicle_id, vehicle_price, total_days, insurance, tax, total_amount)
VALUES
(1, 1, 1, 55.00, 5, TRUE, 13.75, 55.00 * 5 + 13.75),
(2, 2, 3, 95.00, 3, FALSE, 14.25, 95.00 * 3 + 14.25),
(3, 3, 2, 75.00, 5, TRUE, 18.75, 75.00 * 5 + 18.75),
(4, 4, 5, 150.00, 4, FALSE, 30.00, 150.00 * 4 + 30.00),
(5, 5, 4, 120.00, 2, TRUE, 12.00, 120.00 * 2 + 12.00);


-- ===========================
-- UPDATE RESERVATIONS WITH INVOICE IDS
-- ===========================
UPDATE reservations SET invoice_id = 1 WHERE id = 1;
UPDATE reservations SET invoice_id = 2 WHERE id = 2;
UPDATE reservations SET invoice_id = 3 WHERE id = 3;
UPDATE reservations SET invoice_id = 4 WHERE id = 4;
UPDATE reservations SET invoice_id = 5 WHERE id = 5;


-- ===========================
-- OPTIONAL: MARK VEHICLES AS BOOKED
-- ===========================
UPDATE vehicles SET booked = TRUE WHERE id IN (1, 2, 3, 4, 5);