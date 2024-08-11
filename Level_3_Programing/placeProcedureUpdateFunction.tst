PL/SQL Developer Test script 3.0
34

DECLARE
  v_buyer_id INT := 9999; -- Assume buyer with ID 1
  v_order_id INT := 313575; -- New order ID
  v_order_date DATE := SYSDATE; -- Current date
  v_tracking_number VARCHAR2(20) := 'TRACK12345'; -- Tracking number for the order
  
  -- Lists of product IDs and quantities
  v_products SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(1, 2, 3); -- Product IDs
  v_quantities SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(5, 1, 1); -- Quantities for the products
  result VARCHAR2(50); -- for the UpdatePricesByCategory

BEGIN
  -- Call the PlaceNewOrder procedure
  PlaceNewOrder(
    buyerId => v_buyer_id,
    orderId => v_order_id,
    orderDate => v_order_date,
    trackingNumber => v_tracking_number,
    products => v_products,
    quantities => v_quantities
  );

  -- Output success message
  DBMS_OUTPUT.PUT_LINE('Order placed successfully.');
  
  
  :result := UpdatePricesByCategory(startDate => :startDate,
                                    categoryId => :categoryId);
                                    
  DBMS_OUTPUT.PUT_LINE(result);                                  
                                    
                                   
END;
9
buyerId
0
-4
orderId
0
-4
orderDate
0
-12
trackingNumber
0
-5
product
0
-5
quantity
0
-4
result
0
-5
startDate
1
01/01/2024
-12
categoryId
1
1
5
0
