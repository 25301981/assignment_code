-- Insert sample data
-- Insert Sample Hotels
INSERT INTO hotel (hotel_name, province, city, address, phone, email) VALUES
('SA Hotel Hub Sandton', 'Gauteng', 'Johannesburg', '123 Rivonia Road, Sandton, 2196', '0115551000', 'sandton@sahotelhub.co.za'),
('SA Hotel Hub Waterfront', 'Western Cape', 'Cape Town', '45 Victoria & Alfred Waterfront, 8001', '0215552000', 'waterfront@sahotelhub.co.za'),
('SA Hotel Hub Umhlanga', 'KwaZulu-Natal', 'Durban', '78 Lighthouse Road, Umhlanga, 4320', '0315553000', 'umhlanga@sahotelhub.co.za'),
('SA Hotel Hub Polokwane', 'Limpopo', 'Polokwane', '22 Church Street, Polokwane, 0700', '0155554000', 'polokwane@sahotelhub.co.za'),
('SA Hotel Hub Nelspruit', 'Mpumalanga', 'Mbombela', '56 Paul Kruger Street, Mbombela, 1200', '0135555000', 'nelspruit@sahotelhub.co.za'),
('SA Hotel Hub Port Elizabeth', 'Eastern Cape', 'Gqeberha', '89 Beach Road, Summerstrand, 6001', '0415556000', 'pe@sahotelhub.co.za');

-- Insert staff
INSERT INTO staff (hotel_id, first_name, last_name, email, phone, role, hire_date, salary) VALUES
-- Sandton Hotel Team (Gauteng)
(1, 'Thabo', 'Mabunda', 'thabo.mabunda@sahotelhub.co.za', '0823456789', 'Manager', '2020-01-15', 35000.00),
(1, 'Lerato', 'Mokoena', 'lerato.mokoena@sahotelhub.co.za', '0834567890', 'Receptionist', '2021-03-20', 18000.00),
(1, 'Precious', 'Mahlangu', 'precious.m@sahotelhub.co.za', '0845678901', 'Housekeeper', '2022-06-10', 12000.00),
(1, 'Sello', 'Motaung', 'sello.m@sahotelhub.co.za', '0856789012', 'Maintenance', '2021-09-05', 15000.00),

-- Waterfront Hotel Team (Western Cape)
(2, 'Naledi', 'Khumalo', 'naledi.khumalo@sahotelhub.co.za', '0867890123', 'Manager', '2019-05-10', 36000.00),
(2, 'Ayanda', 'Nkosi', 'ayanda.nkosi@sahotelhub.co.za', '0878901234', 'Receptionist', '2020-11-15', 18500.00),
(2, 'Busisiwe', 'Dube', 'busisiwe.d@sahotelhub.co.za', '0889012345', 'Housekeeper', '2021-07-20', 12500.00),
(2, 'Themba', 'Radebe', 'themba.r@sahotelhub.co.za', '0890123456', 'Maintenance', '2020-08-12', 15500.00),

-- Umhlanga Hotel Team (KwaZulu-Natal)
(3, 'Sipho', 'Dlamini', 'sipho.dlamini@sahotelhub.co.za', '0801234567', 'Manager', '2018-03-01', 37000.00),
(3, 'Nomvula', 'Zulu', 'nomvula.zulu@sahotelhub.co.za', '0812345678', 'Receptionist', '2021-01-10', 19000.00),
(3, 'Zanele', 'Mkhize', 'zanele.mkhize@sahotelhub.co.za', '0823456780', 'Housekeeper', '2022-04-15', 13000.00),
(3, 'Bongani', 'Cele', 'bongani.cele@sahotelhub.co.za', '0834567891', 'Maintenance', '2021-06-20', 16000.00),

-- Polokwane Hotel Team (Limpopo)
(4, 'Vhutshilo', 'Netshiunda', 'vhutshilo.netshiunda@sahotelhub.co.za', '0845678902', 'Manager', '2020-07-01', 34000.00),
(4, 'Takalani', 'Munyai', 'takalani.munyai@sahotelhub.co.za', '0856789013', 'Receptionist', '2021-09-15', 17500.00),
(4, 'Azwindini', 'Ramabulana', 'azwindini.r@sahotelhub.co.za', '0867890124', 'Housekeeper', '2022-02-10', 12000.00),
(4, 'Risuna', 'Chauke', 'risuna.chauke@sahotelhub.co.za', '0878901235', 'Maintenance', '2021-11-05', 14500.00),

-- Nelspruit Hotel Team (Mpumalanga)
(5, 'Thandiwe', 'Nkosi', 'thandiwe.nkosi@sahotelhub.co.za', '0889012346', 'Manager', '2019-09-01', 35500.00),
(5, 'Sibusiso', 'Mahlangu', 'sibusiso.m@sahotelhub.co.za', '0890123457', 'Receptionist', '2020-12-10', 18000.00),
(5, 'Lindiwe', 'Mnisi', 'lindiwe.m@sahotelhub.co.za', '0801234568', 'Housekeeper', '2021-08-15', 12500.00),
(5, 'Mpho', 'Nkuna', 'mpho.n@sahotelhub.co.za', '0812345679', 'Maintenance', '2021-05-20', 15000.00),

-- Port Elizabeth Hotel Team (Eastern Cape)
(6, 'Xolani', 'Mthembu', 'xolani.mthembu@sahotelhub.co.za', '0823456781', 'Manager', '2020-02-15', 34500.00),
(6, 'Zandile', 'Gumede', 'zandile.g@sahotelhub.co.za', '0834567892', 'Receptionist', '2021-04-20', 17500.00),
(6, 'Noluthando', 'Ngcobo', 'noluthando.n@sahotelhub.co.za', '0845678903', 'Housekeeper', '2022-01-10', 12000.00),
(6, 'Andile', 'Buthelezi', 'andile.b@sahotelhub.co.za', '0856789014', 'Maintenance', '2021-10-05', 14500.00);

-- link each hotel to its manager in one statement
UPDATE hotel SET manager_id = CASE hotel_id
    WHEN 1 THEN 1   -- Sandton: Thabo Mabunda (staff_id=1)
    WHEN 2 THEN 5   -- Waterfront: Naledi Khumalo (staff_id=5)
    WHEN 3 THEN 9   -- Umhlanga: Sipho Dlamini (staff_id=9)
    WHEN 4 THEN 13  -- Polokwane: Vhutshilo Netshiunda (staff_id=13)
    WHEN 5 THEN 17  -- Nelspruit: Thandiwe Nkosi (staff_id=17)
    WHEN 6 THEN 21  -- Port Elizabeth: Xolani Mthembu (staff_id=21)
END
WHERE hotel_id IN (1, 2, 3, 4, 5, 6);

-- Add corporate accounts for companies (MUST BE BEFORE CUSTOMERS!)
INSERT INTO corporate_account (company_name, contact_person, email, phone, contract_rate, credit_terms, discount_percent) VALUES
('Sasol Limited', 'Lerato Mokoena', 'lerato.m@sasol.com', '0115551234', 1000.00, 30, 15.00),
('Shoprite Holdings', 'Mandla Radebe', 'mandla.r@shoprite.co.za', '0215552345', 1100.00, 45, 20.00),
('Eskom Holdings', 'Zanele Sithole', 'zanele.s@eskom.co.za', '0115553456', 950.00, 30, 12.00);

-- Insert Customers
INSERT INTO customer (first_name, last_name, email, phone, id_number, address, city, province, corporate_account_id) VALUES
('Vhutshilo', 'Netshiunda', 'vhutshilo.n@email.com', '0821234567', '9501015800081', '123 Thohoyandou Street', 'Thohoyandou', 'Limpopo', NULL),
('Takalani', 'Munyai', 'takalani.m@email.com', '0837654321', '8803156789012', '45 Sibasa Road', 'Makhado', 'Limpopo', 1),
('Azwindini', 'Ramabulana', 'azwindini.r@email.com', '0719876543', '9205201234567', '78 Louis Trichardt Ave', 'Polokwane', 'Limpopo', NULL),
('Risuna', 'Chauke', 'risuna.c@email.com', '0834567890', '8712125678901', '22 Giyani Street', 'Giyani', 'Limpopo', 2),
('Xikombiso', 'Baloyi', 'xikombiso.b@email.com', '0845678901', '9106301234568', '67 Malamulele Road', 'Malamulele', 'Limpopo', NULL),
('Hlengani', 'Maluleke', 'hlengani.m@email.com', '0856789012', '8909151234569', '34 Phalaborwa Ave', 'Phalaborwa', 'Limpopo', NULL),
('Sipho', 'Dlamini', 'sipho.d@email.com', '0867890123', '8501225800082', '56 Umlazi Drive', 'Durban', 'KwaZulu-Natal', NULL),
('Thandi', 'Khumalo', 'thandi.k@email.com', '0878901234', '9203306789013', '89 Pietermaritzburg Road', 'Pietermaritzburg', 'KwaZulu-Natal', 3),
('Bongani', 'Mthembu', 'bongani.m@email.com', '0889012345', '7805401234570', '12 Richards Bay Street', 'Richards Bay', 'KwaZulu-Natal', NULL),
('Nomvula', 'Zulu', 'nomvula.z@email.com', '0890123456', '9112155678902', '45 Empangeni Road', 'Empangeni', 'KwaZulu-Natal', NULL),
('Mandla', 'Ngubane', 'mandla.n@email.com', '0801234567', '8608201234571', '78 Ladysmith Ave', 'Ladysmith', 'KwaZulu-Natal', 1),
('Tendai', 'Moyo', 'tendai.m@email.com', '0812345678', '9001015800083', '23 Musina Street', 'Musina', 'Limpopo', NULL),
('Rudo', 'Ncube', 'rudo.n@email.com', '0823456789', '8903256789014', '67 Beitbridge Road', 'Musina', 'Limpopo', NULL),
('Tatenda', 'Sibanda', 'tatenda.s@email.com', '0834567890', '9205301234572', '89 Louis Trichardt Street', 'Louis Trichardt', 'Limpopo', 2),
('Lerato', 'Mokoena', 'lerato.mokoena@email.com', '0845678901', '8812125678903', '34 Sandton Drive', 'Johannesburg', 'Gauteng', NULL),
('Thabo', 'Mabunda', 'thabo.mabunda@email.com', '0856789012', '9106401234573', '56 Pretoria Road', 'Pretoria', 'Gauteng', 3),
('Naledi', 'Molefe', 'naledi.molefe@email.com', '0867890123', '8909251234574', '78 Sea Point Ave', 'Cape Town', 'Western Cape', NULL),
('Zanele', 'Sithole', 'zanele.sithole@email.com', '0878901234', '9212155678904', '12 Stellenbosch Road', 'Stellenbosch', 'Western Cape', 1),
('Xolani', 'Ndlovu', 'xolani.ndlovu@email.com', '0889012345', '8501305800084', '45 Port Elizabeth Beach', 'Gqeberha', 'Eastern Cape', NULL);

-- Insert Rooms per hotel
INSERT INTO room (hotel_id, room_number, room_type, price_per_night, max_occupancy, status, floor_number) VALUES
-- Sandton Hotel Rooms
(1, '101', 'Single', 1200.00, 1, 'Available', 1),
(1, '102', 'Double', 1800.00, 2, 'Available', 1),
(1, '201', 'Suite', 3500.00, 4, 'Available', 2),
(1, '202', 'Double', 1800.00, 2, 'Occupied', 2),
(1, '301', 'Single', 1200.00, 1, 'Maintenance', 3),

-- Waterfront Hotel Rooms
(2, '101', 'Single', 1500.00, 1, 'Available', 1),
(2, '102', 'Double', 2200.00, 2, 'Available', 1),
(2, '201', 'Suite', 4000.00, 4, 'Available', 2),
(2, '202', 'Suite', 4000.00, 4, 'Occupied', 2),

-- Umhlanga Hotel Rooms
(3, '101', 'Single', 1100.00, 1, 'Available', 1),
(3, '102', 'Double', 1600.00, 2, 'Available', 1),
(3, '201', 'Suite', 3200.00, 4, 'Available', 2),
(3, '301', 'Double', 1600.00, 2, 'Occupied', 3),

-- Polokwane Hotel Rooms
(4, '101', 'Single', 800.00, 1, 'Available', 1),
(4, '102', 'Double', 1200.00, 2, 'Available', 1),
(4, '201', 'Suite', 2500.00, 4, 'Available', 2),

-- Nelspruit Hotel Rooms
(5, '101', 'Single', 900.00, 1, 'Available', 1),
(5, '102', 'Double', 1400.00, 2, 'Available', 1),
(5, '201', 'Suite', 2800.00, 4, 'Available', 2),

-- Port Elizabeth Hotel Rooms
(6, '101', 'Single', 850.00, 1, 'Available', 1),
(6, '102', 'Double', 1300.00, 2, 'Available', 1),
(6, '201', 'Suite', 2600.00, 4, 'Available', 2);

-- Insert Packages
INSERT INTO package (package_name, package_type, description, price, duration_nights) VALUES
('Weekend Getaway', 'Romantic', 'Romantic weekend with breakfast and spa', 3500.00, 2),
('Business Special', 'Business', 'Business package with meeting room access', 4000.00, 3),
('Family Fun', 'Family', 'Family package with activities and kids club', 6000.00, 4),
('Kruger Safari', 'Family', 'Safari package with game drives', 8500.00, 3),
('Cape Winelands Tour', 'Romantic', 'Wine tasting and vineyard tours', 5500.00, 2);

-- Insert Bookings (Across Different Hotels)
-- Using valid customer IDs (1-18), staff IDs (1-24), and room IDs (1-23)
INSERT INTO booking (customer_id, room_id, staff_id, package_id, check_in_date, check_out_date, number_of_guests, total_amount, status) VALUES
-- Sandton bookings (staff_id 2 = Lerato Mokoena, Receptionist)
(14, 1, 2, NULL, '2025-10-15', '2025-10-18', 1, 3600.00, 'Confirmed'),
(15, 3, 2, 2, '2025-10-20', '2025-10-23', 2, 4000.00, 'Confirmed'),
(2, 4, 2, NULL, '2025-10-12', '2025-10-14', 2, 3600.00, 'Checked-Out'),

-- Waterfront bookings (staff_id 6 = Ayanda Nkosi, Receptionist)
(16, 6, 6, 5, '2025-11-01', '2025-11-03', 2, 5500.00, 'Confirmed'),
(17, 7, 6, NULL, '2025-10-25', '2025-10-27', 3, 6600.00, 'Confirmed'),
(8, 8, 6, 1, '2025-10-10', '2025-10-12', 2, 3500.00, 'Checked-Out'),

-- Umhlanga bookings (staff_id 10 = Nomvula Zulu, Receptionist)
(7, 10, 10, NULL, '2025-11-05', '2025-11-08', 1, 3300.00, 'Confirmed'),
(9, 11, 10, 3, '2025-10-18', '2025-10-22', 4, 6000.00, 'Confirmed'),
(11, 12, 10, NULL, '2025-10-08', '2025-10-10', 2, 3200.00, 'Checked-Out'),

-- Polokwane bookings (staff_id 14 = Takalani Munyai, Receptionist)
(1, 15, 14, NULL, '2025-11-10', '2025-11-12', 1, 1600.00, 'Confirmed'),
(4, 16, 14, 2, '2025-10-22', '2025-10-25', 2, 4000.00, 'Confirmed'),

-- Nelspruit bookings (staff_id 18 = Sibusiso Mahlangu, Receptionist)
(5, 18, 18, 4, '2025-11-15', '2025-11-18', 3, 8500.00, 'Confirmed'),
(12, 19, 18, NULL, '2025-10-28', '2025-10-30', 2, 2800.00, 'Confirmed'),

-- Port Elizabeth bookings (staff_id 22 = Zandile Gumede, Receptionist)
(18, 21, 22, NULL, '2025-11-20', '2025-11-22', 1, 1700.00, 'Confirmed'),
(10, 22, 22, 1, '2025-10-15', '2025-10-17', 2, 3500.00, 'Checked-Out');

-- Insert Payments
INSERT INTO payment (booking_id, amount, payment_method, payment_status, transaction_ref) VALUES
(1, 3600.00, 'Credit Card', 'Completed', 'TXN2025001'),
(2, 4000.00, 'EFT', 'Completed', 'TXN2025002'),
(3, 3600.00, 'Cash', 'Completed', 'TXN2025003'),
(4, 5500.00, 'Credit Card', 'Completed', 'TXN2025004'),
(5, 8000.00, 'EFT', 'Completed', 'TXN2025005'),
(6, 3500.00, 'Mobile Payment', 'Completed', 'TXN2025006'),
(7, 3300.00, 'Credit Card', 'Completed', 'TXN2025007'),
(8, 6000.00, 'EFT', 'Completed', 'TXN2025008'),
(9, 3200.00, 'Debit Card', 'Completed', 'TXN2025009'),
(10, 1600.00, 'Cash', 'Completed', 'TXN2025010'),
(11, 4000.00, 'Credit Card', 'Completed', 'TXN2025011'),
(12, 8500.00, 'EFT', 'Completed', 'TXN2025012'),
(13, 5600.00, 'Credit Card', 'Completed', 'TXN2025013'),
(14, 1700.00, 'Cash', 'Completed', 'TXN2025014'),
(15, 3500.00, 'Mobile Payment', 'Completed', 'TXN2025015');

-- Insert Maintenance Records (Across Different Hotels)
INSERT INTO maintenance (room_id, staff_id, issue_type, description, priority, status) VALUES
-- Sandton maintenance
(5, 4, 'Plumbing', 'Leaking bathroom sink in room 301', 'High', 'In Progress'),
(3, 4, 'Cleaning', 'Deep cleaning after guest checkout', 'Medium', 'Completed'),
(1, 4, 'Electrical', 'Replace light bulbs in room 101', 'Low', 'Pending'),

-- Waterfront maintenance
(7, 8, 'Plumbing', 'Shower drain blocked in room 102', 'Medium', 'Completed'),
(9, 8, 'Electrical', 'Air conditioning not working', 'High', 'In Progress'),

-- Umhlanga maintenance
(12, 12, 'Cleaning', 'Routine deep cleaning', 'Low', 'Completed'),
(14, 12, 'Plumbing', 'Toilet repair needed', 'Medium', 'Pending'),

-- Polokwane maintenance
(15, 16, 'Electrical', 'TV remote not working', 'Low', 'Completed'),

-- Nelspruit maintenance
(19, 20, 'Cleaning', 'Post-checkout cleaning', 'Medium', 'Completed'),

-- Port Elizabeth maintenance
(22, 24, 'Plumbing', 'Tap leaking in bathroom', 'Medium', 'In Progress');

-- Insert Loyalty Programs
INSERT INTO loyalty_program (customer_id, points_balance, tier_level) VALUES
(1, 850, 'Silver'),
(2, 2500, 'Gold'),
(7, 3200, 'Platinum'),
(8, 1800, 'Gold'),
(14, 650, 'Silver'),
(15, 1200, 'Silver'),
(16, 2100, 'Gold'),
(9, 450, 'Silver'),
(10, 3500, 'Platinum');

-- Insert Inventory (Multiple Hotels)
INSERT INTO inventory (room_id, item_name, item_category, quantity, reorder_level) VALUES
-- Sandton inventory
(1, 'Shampoo', 'Toiletries', 15, 5),
(1, 'Bath Towels', 'Linen', 10, 4),
(3, 'Minibar Drinks', 'Minibar', 18, 6),
(3, 'Bed Sheets', 'Linen', 8, 3),

-- Waterfront inventory
(6, 'Shampoo', 'Toiletries', 12, 5),
(6, 'Hand Towels', 'Linen', 15, 5),
(8, 'Minibar Snacks', 'Minibar', 20, 8),

-- Umhlanga inventory
(11, 'Conditioner', 'Toiletries', 10, 4),
(13, 'Beach Towels', 'Linen', 12, 6),
(13, 'Cleaning Supplies', 'Cleaning Supplies', 25, 10),

-- Polokwane inventory
(15, 'Soap', 'Toiletries', 20, 8),
(16, 'Pillowcases', 'Linen', 16, 6),

-- Nelspruit inventory
(18, 'Shampoo', 'Toiletries', 14, 5),
(19, 'Duvet Covers', 'Linen', 10, 4),

-- Port Elizabeth inventory
(21, 'Body Lotion', 'Toiletries', 12, 5),
(22, 'Cleaning Supplies', 'Cleaning Supplies', 18, 8);

-- Insert Reviews
INSERT INTO review (customer_id, booking_id, rating, review_text) VALUES
(2, 3, 5, 'Excellent service and very clean rooms at Sandton!'),
(14, 1, 4, 'Great stay, would recommend to others. Professional staff.'),
(8, 6, 5, 'Beautiful views at Waterfront! Amazing experience.'),
(7, 7, 4, 'Umhlanga hotel was fantastic. Beach access was great.'),
(1, 10, 5, 'Polokwane hotel exceeded expectations. Very welcoming staff.'),
(10, 15, 4, 'Port Elizabeth location perfect. Clean and comfortable.');

-- Insert Customer Preferences
INSERT INTO customer_preference (customer_id, preference_type, preference_value, notes) VALUES
(1, 'Room Temperature', '22°C', 'Vhutshilo prefers cooler rooms'),
(2, 'Pillow Type', 'Firm', 'Takalani needs firm pillows for back support'),
(7, 'Dietary', 'Halaal', 'Sipho requires halaal meals'),
(8, 'Accessibility', 'Wheelchair Access', 'Thandi requires ground floor rooms'),
(14, 'Floor Preference', 'High Floor', 'Lerato prefers rooms above 5th floor'),
(16, 'Dietary', 'Vegetarian', 'Naledi - no meat products'),
(5, 'Pillow Type', 'Soft', 'Xikombiso prefers soft pillows'),
(9, 'Room Temperature', '24°C', 'Bongani prefers warmer rooms');

-- Insert Concierge Services
INSERT INTO concierge_service (customer_id, booking_id, service_type, description, service_date, status, cost) VALUES
(16, 4, 'Transportation', 'Airport pickup from Cape Town International', '2025-11-01', 'Confirmed', 450.00),
(17, 5, 'Tour', 'Table Mountain cable car and city tour', '2025-10-26', 'Confirmed', 650.00),
(7, 7, 'Restaurant', 'Reservation at Moyo uShaka', '2025-11-06', 'Confirmed', 0.00),
(5, 12, 'Tour', 'Kruger National Park day safari', '2025-11-16', 'Pending', 1200.00),
(15, 2, 'Transportation', 'Sandton to OR Tambo transfer', '2025-10-23', 'Confirmed', 350.00),
(18, 14, 'Event Tickets', 'Nelson Mandela Bay Stadium tour', '2025-11-21', 'Pending', 250.00);

-- Insert Pricing Rules (Different Hotels)
INSERT INTO pricing_rule (room_id, rule_name, rule_type, start_date, end_date, price_modifier) VALUES
-- Sandton pricing
(1, 'Summer Holiday Special', 'Seasonal', '2025-12-01', '2026-01-31', 1.25),
(3, 'Weekend Corporate Rate', 'Weekend', '2025-10-01', '2025-12-31', 1.15),
-- Waterfront pricing
(6, 'Peak Season Rate', 'Seasonal', '2025-12-15', '2026-01-15', 1.35),
(8, 'Early Bird Discount', 'Early Bird', '2025-11-01', '2026-03-31', 0.85),
-- Umhlanga pricing
(11, 'Beach Season Premium', 'Seasonal', '2025-12-01', '2026-02-28', 1.20),
-- Polokwane pricing
(15, 'Off-Peak Discount', 'Seasonal', '2025-11-01', '2026-03-31', 0.80);
INSERT INTO loyalty_program (customer_id, points_balance, tier_level) VALUES
(1, 850, 'Silver'),
(2, 2500, 'Gold'),
(7, 3200, 'Platinum'),
(8, 1800, 'Gold'),
(14, 650, 'Silver'),
(15, 1200, 'Silver'),
(16, 2100, 'Gold'),
(9, 450, 'Silver'),
(10, 3500, 'Platinum');

-- Insert Inventory (Multiple Hotels)
INSERT INTO inventory (room_id, item_name, item_category, quantity, reorder_level) VALUES
-- Sandton inventory
(1, 'Shampoo', 'Toiletries', 15, 5),
(1, 'Bath Towels', 'Linen', 10, 4),
(3, 'Minibar Drinks', 'Minibar', 18, 6),
(3, 'Bed Sheets', 'Linen', 8, 3),

-- Waterfront inventory
(6, 'Shampoo', 'Toiletries', 12, 5),
(6, 'Hand Towels', 'Linen', 15, 5),
(8, 'Minibar Snacks', 'Minibar', 20, 8),

-- Umhlanga inventory
(11, 'Conditioner', 'Toiletries', 10, 4),
(13, 'Beach Towels', 'Linen', 12, 6),
(13, 'Cleaning Supplies', 'Cleaning Supplies', 25, 10),

-- Polokwane inventory
(15, 'Soap', 'Toiletries', 20, 8),
(16, 'Pillowcases', 'Linen', 16, 6),

-- Nelspruit inventory
(18, 'Shampoo', 'Toiletries', 14, 5),
(20, 'Duvet Covers', 'Linen', 10, 4),

-- Port Elizabeth inventory
(21, 'Body Lotion', 'Toiletries', 12, 5),
(23, 'Cleaning Supplies', 'Cleaning Supplies', 18, 8);
