
-- Create New Booking with Seasonal Pricing
-- Set booking details
SET @customer_id = 16;      -- Naledi Molefe
SET @room_id = 6;           -- Waterfront Single Room
SET @staff_id = 6;          -- Ayanda Nkosi (Receptionist)
SET @package_id = 5;        -- Cape Winelands Tour
SET @check_in = '2025-12-20';
SET @check_out = '2025-12-25';
SET @num_guests = 2;
SET @nights = DATEDIFF(@check_out, @check_in);

-- Get base price from room table
SET @base_price = (SELECT price_per_night FROM room WHERE room_id = @room_id);

-- Get seasonal modifier from pricing_rule table
SET @seasonal_modifier = (
    SELECT COALESCE(price_modifier, 1.00) 
    FROM pricing_rule 
    WHERE room_id = @room_id 
      AND is_active = TRUE
      AND @check_in BETWEEN start_date AND end_date
    LIMIT 1
);

-- Get package price
SET @package_price = (SELECT COALESCE(price, 0) FROM package WHERE package_id = @package_id);

-- Calculate total amount
SET @room_total = ROUND(@base_price * @seasonal_modifier * @nights, 2);
SET @total_amount = @room_total + @package_price;

-- Insert booking
INSERT INTO booking (customer_id, room_id, staff_id, package_id, check_in_date, check_out_date, number_of_guests, total_amount, status)
VALUES (@customer_id, @room_id, @staff_id, @package_id, @check_in, @check_out, @num_guests, @total_amount, 'Confirmed');

SET @booking_id = LAST_INSERT_ID();

-- Insert payment
INSERT INTO payment (booking_id, amount, payment_method, payment_status, transaction_ref)
VALUES (@booking_id, @total_amount, 'Credit Card', 'Completed', CONCAT('TXN2025', LPAD(@booking_id, 6, '0')));

-- View booking confirmation
SELECT 
    @booking_id AS booking_id,
    @base_price AS base_price_per_night,
    @seasonal_modifier AS seasonal_modifier,
    @nights AS nights,
    @room_total AS room_total,
    @package_price AS package_price,
    @total_amount AS total_amount,
    'Confirmed' AS status;