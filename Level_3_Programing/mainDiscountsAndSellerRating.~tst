PL/SQL Developer Test script 3.0
45
-- main to apply discount and print buyer information, and get sellers with low-rated products

-- Declare local variables and cursors
DECLARE
  v_sellers SYS_REFCURSOR;  -- Cursor for fetching sellers with low-rated products
  v_seller_id INT; 
  v_seller_name VARCHAR2(50); 
  v_avg_rating NUMBER(10, 2);  

BEGIN
  -- Enable DBMS_OUTPUT with a buffer size of 1,000,000 bytes
  DBMS_OUTPUT.ENABLE(1000000);

  
  
  ApplyDiscountAndPrint(p_order_date => :p_order_date);

  
  DBMS_OUTPUT.PUT_LINE('***********************************************************************************************');

  -- Call the GetSellersWithLowRatedProducts function to get sellers with products rated below 3
  -- with reviews within the date range from '2023-01-01' to '2025-01-01'
  v_sellers := GetSellersWithLowRatedProducts(3, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

  
  LOOP
   
    FETCH v_sellers INTO v_seller_id, v_seller_name, v_avg_rating;

    
    EXIT WHEN v_sellers%NOTFOUND;

    
    DBMS_OUTPUT.PUT_LINE('Seller ID: ' || v_seller_id || ', Name: ' || v_seller_name || ', Average Rating: ' || v_avg_rating);
  END LOOP;


  CLOSE v_sellers;
  

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);  
END;
/
5
result
1
<Cursor>
-116
p_rating
1
4
-4
p_start_date
1
01/01/2023
-12
p_end_date
1
01/01/2025
-12
p_order_date
1
01/01/2024
12
0
