-- 1. Find available rooms within a date range
SELECT 
    SQL2.hotel_name,
    SQL2.city,
    SQL2.province,
    SQL1.room_number,
    SQL1.room_type,
    SQL1.price_per_night,
    SQL1.max_occupancy,
    SQL1.floor_number
FROM room SQL1
JOIN hotel SQL2 ON SQL1.hotel_id = SQL2.hotel_id
WHERE SQL1.status = 'Available'
AND SQL1.room_id NOT IN (
    SELECT room_id 
    FROM booking 
    WHERE status IN ('Confirmed', 'Checked-In')
    AND check_in_date <= '2025-11-05'
    AND check_out_date >= '2025-11-01'
)
ORDER BY SQL2.province, SQL2.city, SQL1.price_per_night;


-- 2. List all bookings for a specific customer
SELECT 
    SQL1.booking_id,
    CONCAT(SQL2.first_name, ' ', SQL2.last_name) AS customer_name,
    SQL4.hotel_name,
    SQL4.city,
    SQL4.province,
    SQL3.room_number,
    SQL3.room_type,
    SQL1.check_in_date,
    SQL1.check_out_date,
    SQL1.number_of_guests,
    SQL1.total_amount,
    SQL1.status,
    SQL5.package_name
FROM booking SQL1
JOIN customer SQL2 ON SQL1.customer_id = SQL2.customer_id
JOIN room SQL3 ON SQL1.room_id = SQL3.room_id
JOIN hotel SQL4 ON SQL3.hotel_id = SQL4.hotel_id
LEFT JOIN package SQL5 ON SQL1.package_id = SQL5.package_id
WHERE SQL2.customer_id = 7
ORDER BY SQL1.check_in_date DESC;

-- 3. Generate monthly occupancy and revenue reports
SELECT 
    SQL1.hotel_name,
    SQL1.province,
    SQL1.city,
    COUNT(DISTINCT SQL2.room_id) AS total_rooms,
    COUNT(DISTINCT CASE 
        WHEN SQL3.status IN ('Confirmed', 'Checked-In') 
        AND SQL3.check_in_date <= '2025-11-30' 
        AND SQL3.check_out_date >= '2025-11-01' 
        THEN SQL3.room_id 
    END) AS occupied_rooms,
    ROUND(
        (COUNT(DISTINCT CASE 
            WHEN SQL3.status IN ('Confirmed', 'Checked-In') 
            AND SQL3.check_in_date <= '2025-11-30' 
            AND SQL3.check_out_date >= '2025-11-01' 
            THEN SQL3.room_id 
        END) * 100.0 / COUNT(DISTINCT SQL2.room_id)), 2
    ) AS occupancy_percentage,
    COALESCE(SUM(CASE 
        WHEN SQL3.check_in_date >= '2025-11-01' 
        AND SQL3.check_in_date <= '2025-11-30' 
        THEN SQL4.amount 
    END), 0) AS total_revenue
FROM hotel SQL1
JOIN room SQL2 ON SQL1.hotel_id = SQL2.hotel_id
LEFT JOIN booking SQL3 ON SQL2.room_id = SQL3.room_id
LEFT JOIN payment SQL4 ON SQL3.booking_id = SQL4.booking_id AND SQL4.payment_status = 'Completed'
GROUP BY SQL1.hotel_id, SQL1.hotel_name, SQL1.province, SQL1.city
ORDER BY total_revenue DESC;

-- 4. Identify upcoming room maintenance dates
SELECT 
    SQL4.hotel_name,
    SQL4.city,
    SQL2.room_number,
    SQL2.room_type,
    SQL1.issue_type,
    SQL1.description,
    SQL1.priority,
    SQL1.status,
    SQL1.start_date,
    SQL1.end_date,
    CONCAT(SQL3.first_name, ' ', SQL3.last_name) AS assigned_staff,
    SQL3.role,
    SQL1.cost
FROM maintenance SQL1
JOIN room SQL2 ON SQL1.room_id = SQL2.room_id
JOIN staff SQL3 ON SQL1.staff_id = SQL3.staff_id
JOIN hotel SQL4 ON SQL2.hotel_id = SQL4.hotel_id
WHERE SQL1.status IN ('Pending', 'In Progress')
  AND (SQL1.end_date IS NULL OR SQL1.end_date >= CURDATE())
ORDER BY 
    FIELD(SQL1.priority, 'Urgent', 'High', 'Medium', 'Low'),
    SQL1.start_date;