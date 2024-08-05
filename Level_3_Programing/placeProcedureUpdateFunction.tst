PL/SQL Developer Test script 3.0
36


DECLARE
  v_buyerId INT := 9999; -- Example buyer ID
  v_orderId INT := 547775847; -- Example order ID
  v_orderDate DATE := SYSDATE; -- Current date as order date
  v_trackingNumber VARCHAR2(20) := '666-666'; -- Example tracking number
  v_product INT := 1; -- Example product IDs
  v_quantity INT := 4; -- Example quantities
  result VARCHAR2(50);
BEGIN
  -- Call the PlaceNewOrder procedure
  PlaceNewOrder(
    buyerId => v_buyerId,
    orderId => v_orderId,
    orderDate => v_orderDate,
    trackingNumber => v_trackingNumber,
    product => v_product,
    quantity => v_quantity
  );

  -- Output success message
  DBMS_OUTPUT.PUT_LINE('Order placed successfully.');
  
  :result := UpdatePricesByCategory(startDate => :startDate,
                                    categoryId => :categoryId);
                                    
  DBMS_OUTPUT.PUT_LINE(result);                                  
                                    
                                    

EXCEPTION
  WHEN OTHERS THEN
    -- Output error message
    DBMS_OUTPUT.PUT_LINE('Error placing order: ' || SQLERRM);
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
5
startDate
1
01/01/2024
5
categoryId
1
1
5
0
