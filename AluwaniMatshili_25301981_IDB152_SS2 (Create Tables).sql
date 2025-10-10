-- Create the database for SA Hotel Hub (HotelHubLogic)
DROP DATABASE HotelHubLogic;
CREATE DATABASE HotelHubLogic;
USE HotelHubLogic;

-- Create tables 
-- Hotel  (This stores all the hotel's locations across SA provinces)
CREATE TABLE hotel (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_name VARCHAR(100) UNIQUE NOT NULL,
    province VARCHAR(50) NOT NULL,
    city  VARCHAR(50) NOT NULL,
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(15) UNIQUE  NOT NULL,
    email VARCHAR(100) UNIQUE  NOT NULL,
    manager_id INT,
    is_active  BOOLEAN DEFAULT TRUE,
    -- Add a constraint to ensure we only use south african provinces for hotels
    CONSTRAINT chk_province CHECK (province IN ('Gauteng', 'Western Cape', 'KwaZulu-Natal', 'Eastern Cape', 'Limpopo', 'Mpumalanga', 'North West', 'Free State', 'Northern Cape'))
);

-- corporate_account (For business clients like Sasol, Shoprite, etc.)
CREATE TABLE corporate_account (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    contact_person  VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    contract_rate DECIMAL(10,2),
    credit_terms INT,
    discount_percent DECIMAL(5,2),
    is_active  BOOLEAN DEFAULT TRUE
);

-- customer (Stores customer information)
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email  VARCHAR(100) UNIQUE NOT NULL,
    phone  VARCHAR(15) NOT NULL,
    id_number VARCHAR(13) UNIQUE NOT NULL,
    address VARCHAR(200),
    city VARCHAR(50),
    province  VARCHAR(50),
    corporate_account_id INT,
    registration_date DATE  DEFAULT (CURRENT_DATE),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (corporate_account_id) REFERENCES corporate_account(account_id)
    -- Some customers are linked to corporate accounts for special rates
);

-- STAFF (stores team members, Each staff member is assigned to a specific hotel)
CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    role  VARCHAR(30) NOT NULL,
    hire_date  DATE  NOT NULL,
    salary  DECIMAL(10,2),
    is_active  BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id),
    -- add constraint to specify role,  Roles include Manager, Receptionist, Housekeeper, Maintenance, Security
    CONSTRAINT chk_role CHECK (role IN ('Manager', 'Receptionist', 'Housekeeper', 'Maintenance', 'Security'))
);

-- ROOM table - Where the magic happens!, Each room belongs to a specific hotel
CREATE TABLE room (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    room_type  VARCHAR(20) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    max_occupancy INT NOT NULL,
    status  VARCHAR(20) DEFAULT 'Available',
    floor_number INT,
    FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id),
    -- Add constraints to specify accepted statuses, include Available, Occupied, Maintenance, Out of Service
    CONSTRAINT chk_status CHECK (status IN ('Available', 'Occupied', 'Maintenance', 'Out of Service')),
    UNIQUE KEY unique_room_per_hotel (hotel_id, room_number)
);

-- PACKAGE (Special deals and offers)
CREATE TABLE package (
    package_id INT PRIMARY KEY AUTO_INCREMENT,
    package_name VARCHAR(100) NOT NULL,
    package_type VARCHAR(50) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    duration_nights INT NOT NULL,
    is_active  BOOLEAN DEFAULT TRUE,
    -- add constraint to cspecify accepted types below
    CONSTRAINT chk_package_type CHECK (package_type IN ('Breakfast', 'Romantic', 'Business', 'Family', 'Extended Stay'))
);

-- BOOKING (Tracks check-in/out and room availability)
CREATE TABLE booking (
    booking_id  INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    staff_id  INT NOT NULL,
    package_id  INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    check_in_date  DATE  NOT NULL,
    check_out_date DATE  NOT NULL,
    actual_check_in DATETIME,
    actual_check_out  DATETIME,
    number_of_guests INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Confirmed',
    special_requests  TEXT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES package(package_id) ON DELETE SET NULL,
    -- add constraint to show that checkin must be after checkout
    CONSTRAINT chk_dates CHECK (check_out_date > check_in_date),
    -- add constraint to specify accepted statuses
    CONSTRAINT chk_booking_status CHECK (status IN ('Confirmed', 'Checked-In', 'Checked-Out', 'Cancelled', 'No-Show'))
);

-- PAYMENT (Tracks all payments for bookings)
CREATE TABLE payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount  DECIMAL(10,2) NOT NULL,
    payment_method  VARCHAR(20) NOT NULL,
    payment_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_status  VARCHAR(20) DEFAULT 'Completed',
    transaction_ref VARCHAR(50) unique not null,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE,
    -- add constraints for payment methods and statuses
    CONSTRAINT chk_payment_method CHECK (payment_method IN ('Cash', 'Credit Card', 'Debit Card', 'EFT', 'Mobile Payment')),
    CONSTRAINT chk_payment_status CHECK (payment_status IN ('Pending', 'Completed', 'Failed', 'Refunded'))
);

-- MAINTENANCE (Tracks repairs, cleaning, and maintenance tasks)
CREATE TABLE maintenance (
    maintenance_id  INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT NOT NULL,
    staff_id INT NOT NULL,
    issue_type VARCHAR(50) NOT NULL,
    description TEXT  NOT NULL,
    priority VARCHAR(10) DEFAULT 'Medium',
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_date DATETIME,
    status  VARCHAR(20) DEFAULT 'Pending',
    cost  DECIMAL(10,2),
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE,
    CONSTRAINT chk_priority CHECK (priority IN ('Low', 'Medium', 'High', 'Urgent')),
    CONSTRAINT chk_maintenance_status CHECK (status IN ('Pending', 'In Progress', 'Completed', 'Cancelled'))
);

-- REVIEW (Customers can rate their stay and leave feedback)
CREATE TABLE review (
    review_id  INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    booking_id INT NOT NULL,
    rating  INT NOT NULL,
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    staff_response  TEXT,
    response_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE,
    CONSTRAINT chk_rating CHECK (rating BETWEEN 1 AND 5)
);

-- CUSTOMER_PREFERENCE (Stores preferences like pillow type, room temperature, dietary needs)
CREATE TABLE customer_preference (
    preference_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    preference_type VARCHAR(50) NOT NULL,
    preference_value VARCHAR(100) NOT NULL,
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT chk_pref_type CHECK (preference_type IN ('Room Temperature', 'Pillow Type', 'Dietary', 'Accessibility', 'Allergy', 'Floor Preference'))
);

-- CONCIERGE_SERVICE (Stores extra special services Tours, transportation, restaurant bookings, event tickets)
CREATE TABLE concierge_service (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    booking_id INT,
    service_type VARCHAR(50) NOT NULL,
    description TEXT  NOT NULL,
    request_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
    service_date  DATE,
    status  VARCHAR(20) DEFAULT 'Pending',
    cost  DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE SET NULL,
    CONSTRAINT chk_service_type CHECK (service_type IN ('Transportation', 'Tour', 'Restaurant', 'Event Tickets', 'Wake-up Call')),
    CONSTRAINT chk_service_status CHECK (status IN ('Pending', 'Confirmed', 'Completed', 'Cancelled'))
);

-- PRICING_RULE (Dynamic pricing based on season, weekends, events)
CREATE TABLE pricing_rule (
    rule_id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT NOT NULL,
    rule_name  VARCHAR(100) NOT NULL,
    rule_type  VARCHAR(30) NOT NULL,
    start_date DATE  NOT NULL,
    end_date DATE  NOT NULL,
    price_modifier  DECIMAL(5,2) NOT NULL,
    is_active  BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE,
    CONSTRAINT chk_rule_type CHECK (rule_type IN ('Seasonal', 'Weekend', 'Event', 'Early Bird', 'Last Minute'))
);

-- LOYALTY_PROGRAM (Stores Points, tiers (Silver, Gold, Platinum), and benefits)
CREATE TABLE loyalty_program (
    loyalty_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT UNIQUE NOT NULL,
    points_balance  INT DEFAULT 0,
    tier_level VARCHAR(20) DEFAULT 'Silver',
    join_date  DATE  DEFAULT (CURRENT_DATE),
    last_activity DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT chk_tier CHECK (tier_level IN ('Silver', 'Gold', 'Platinum'))
);

-- INVENTORY table (Keep track of supplies Minibar items, toiletries, linens, cleaning supplies)
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT NOT NULL,
    item_name  VARCHAR(100) NOT NULL,
    item_category VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    reorder_level INT DEFAULT 5,
    last_restock  DATE,
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE,
    CONSTRAINT chk_category CHECK (item_category IN ('Minibar', 'Toiletries', 'Linen', 'Cleaning Supplies', 'Furniture'))
);

ALTER TABLE hotel 
ADD CONSTRAINT fk_hotel_manager 
FOREIGN KEY (manager_id) REFERENCES staff(staff_id) ON DELETE SET NULL;