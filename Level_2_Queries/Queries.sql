-- QUERIES WITH PARAM


-- 1. Query with a list parameter to find products in specific categories
VARIABLE category_list NUMBER
EXEC :category_list := 1
SELECT p.product_name, p.price, c.category_name

FROM Products p

JOIN Categories c ON p.category_id = c.category_id

WHERE c.category_id = (:category_list);

-- 2. Query with a date parameter to find orders within a date range
VARIABLE start_date DATE
VARIABLE end_date DATE
EXEC :start_date := DATE '2024-01-01'
EXEC :end_date := DATE '2024-03-31'
SELECT o.order_id, o.order_date, b.buyer_name, p.product_name

FROM Orders o

JOIN Buyers b ON o.buyer_id = b.buyer_id

JOIN Products p ON o.product_id = p.product_id

WHERE o.order_date BETWEEN :start_date AND :end_date;

-- 3. Query with a string parameter using LIKE for partial matching
VARIABLE name_pattern VARCHAR2(50)
EXEC :name_pattern := '%john%'
SELECT s.seller_name, s.phone, s.address
FROM Sellers s
WHERE LOWER(s.seller_name)
 LIKE LOWER(:name_pattern);

-- 4. Query with multiple parameters including a number for filtering
VARIABLE min_rating NUMBER
VARIABLE review_after_date DATE
VARIABLE category_id NUMBER
EXEC :min_rating := 4
EXEC :review_after_date := DATE '2024-01-01'
EXEC :category_id := 2
SELECT r.review_id, r.rating, r.comment_text, p.product_name
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id

WHERE r.rating >= :min_rating
  AND r.review_date > :review_after_date
  AND p.category_id = :category_id;
