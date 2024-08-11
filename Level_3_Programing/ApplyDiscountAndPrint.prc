--checks if a buyer has ordered more than 5 items, applies a 10% discount,
-- and then prints the buyer's name along with the original and discounted prices
-- exlicit cursor , loop ,excepetion , conditions


CREATE OR REPLACE PROCEDURE ApplyDiscountAndPrint (
  p_order_date IN DATE
) IS
  CURSOR order_cursor IS
    SELECT b.buyer_id, b.buyer_name, o.order_id, p.product_id, ip.quantity, p.price
    FROM Orders o
    JOIN include_products ip ON o.order_id = ip.order_id
    JOIN Buyers b ON o.buyer_id = b.buyer_id
    JOIN Products p ON ip.product_id = p.product_id
    WHERE o.order_date >= p_order_date;

  v_buyer_name Buyers.buyer_name%TYPE;
  v_buyer_id Buyers.buyer_id%TYPE;
  v_order_id Orders.order_id%TYPE;
  v_product_id Products.product_id%TYPE;
  v_quantity INT;
  v_price NUMBER(10, 2);
  v_total_price NUMBER(10, 2);
  v_discounted_price NUMBER(10, 2);
  v_discount_rate NUMBER := 0.1;  -- 10% discount
   v_empty_cursor BOOLEAN := TRUE; 
BEGIN
  
   IF p_order_date < TO_DATE('01/01/2023', 'DD/MM/YYYY') THEN
   RAISE_APPLICATION_ERROR(-20001, 'invalid date ' || TO_CHAR(p_order_date, 'DD/MM/YYYY'));
   END IF;

  OPEN order_cursor;
  LOOP
    FETCH order_cursor INTO v_buyer_id, v_buyer_name, v_order_id, v_product_id, v_quantity, v_price;
    EXIT WHEN order_cursor%NOTFOUND;
    
    v_empty_cursor := FALSE;-- if we got here the curser is not empty

    -- Calculate total price for the order
    v_total_price := v_quantity * v_price;

    -- Apply discount if quantity is greater than 5
    IF v_quantity > 5 THEN
      v_discounted_price := v_total_price * (1 - v_discount_rate);
    ELSE
      v_discounted_price := v_total_price; -- No discount
    END IF;

    -- Print buyer's name and price details
    DBMS_OUTPUT.PUT_LINE('Buyer: ' || v_buyer_name);
    DBMS_OUTPUT.PUT_LINE('Original Price: ' || v_total_price);
    DBMS_OUTPUT.PUT_LINE('Discounted Price: ' || v_discounted_price);
    DBMS_OUTPUT.PUT_LINE('-------------------------');
  END LOOP;
  
  
  -- Check if cursor was empty and raise an error if true
  IF v_empty_cursor THEN
    RAISE_APPLICATION_ERROR(-20002, 'No orders found for the given date.');
  END IF;
  
  CLOSE order_cursor;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END ApplyDiscountAndPrint;
/
