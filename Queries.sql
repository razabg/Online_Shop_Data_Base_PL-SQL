--Query to find the top 3 buyers who have placed the highest number
-- of orders along with the total amount spent by each buyer.

SELECT 
    B.buyer_id, 
    B.buyer_name, 
    COUNT(O.order_id) AS total_orders, 
    SUM(P.price * OD.quantity) AS total_spent
FROM 
    Buyers B
JOIN 
    Orders O ON B.buyer_id = O.buyer_id
JOIN 
    include_products IP ON O.order_id = IP.order_id
JOIN 
    Products P ON IP.product_id = P.product_id
JOIN 
    OrderDetails OD ON P.product_id = OD.product_id
GROUP BY 
    B.buyer_id, B.buyer_name
ORDER BY 
    total_spent DESC
FETCH FIRST 3 ROWS ONLY;



