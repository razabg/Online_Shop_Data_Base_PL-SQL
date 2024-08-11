CREATE OR REPLACE PROCEDURE PlaceNewOrder (
  buyerId IN INT,              
  orderId IN INT,             
  orderDate IN DATE,           
  trackingNumber IN VARCHAR2,  
  products IN SYS.ODCINUMBERLIST, -- Input parameter: List of product IDs 
  quantities IN SYS.ODCINUMBERLIST  -- Input parameter: List of quantities 
) IS
  v_product_id INT;            -- Local variable 
  v_quantity INT;              
  v_stock INT;                 
BEGIN
  -- Check if the buyer exists using EXISTS
   BEGIN
    SELECT 1 --check if there are any rows in the specified table.
    INTO v_product_id
    FROM Buyers
    WHERE buyer_id = buyerId;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002, 'Buyer with ID ' || buyerId || ' does not exist.');
  END;
  
  SAVEPOINT sp_before_order;   -- Savepoint to allow rollback in case of errors
  
  INSERT INTO Orders (order_id, order_date, buyer_id)
  VALUES (orderId, orderDate, buyerId); 

  
  INSERT INTO OrderDetails (order_id, delivery_method, tracking_number,Order_Status)
  VALUES (orderId, 'home delivery', trackingNumber,'pending'); 

  -- Loop through each product in the products list
  FOR i IN 1 .. products.COUNT LOOP
    v_product_id := products(i);  -- Get the current product ID from the list
    v_quantity := quantities(i);  -- Get the current quantity from the list

    -- Check stock
    SELECT p.stock
    INTO v_stock
    FROM Products p
    WHERE p.product_id = v_product_id; -- Query to get the stock of the current product

    -- If there is not enough stock, raise an error
    IF v_stock < v_quantity THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for product ' || v_product_id);
    END IF;

    
    INSERT INTO include_products (order_id, product_id, quantity)
    VALUES (orderId, v_product_id, v_quantity); 

    
    UPDATE Products
    SET stock = stock - v_quantity
    WHERE product_id = v_product_id; 
  END LOOP;

  -- Commit transaction
  COMMIT; -- Commit the transaction if all operations succeed

EXCEPTION
  WHEN OTHERS THEN
    -- Rollback to savepoint in case of error
    ROLLBACK TO sp_before_order; -- Rollback to the savepoint if any error occurs
    RAISE; -- Re-raise the exception to propagate the error
END PlaceNewOrder;
/
