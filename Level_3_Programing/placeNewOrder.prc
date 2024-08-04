CREATE OR REPLACE PROCEDURE PlaceNewOrder (
  buyerId IN INT,
  orderId IN INT,
  orderDate IN DATE,
  trackingNumber IN VARCHAR2,
  product IN INT, 
  quantity IN INT 
) IS
  v_stock INT;
BEGIN
  -- Start transaction
  SAVEPOINT sp_before_order; -- save for rollback the action


    -- Check stock
    SELECT p.stock
    INTO v_stock
    FROM Products p
    WHERE p.product_id = product;

    IF v_stock < quantity THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for product ' || product);
    END IF;

    -- Insert into Orders table
    INSERT INTO Orders (order_id, order_date, tracking_number, product_id, buyer_id)
    VALUES (orderId, orderDate, trackingNumber, product, buyerId);

    -- Update stock
    UPDATE Products
    SET stock = stock - quantity
    WHERE product_id = product;

    -- Insert into include_products table
    INSERT INTO include_products (order_id, product_id,Quantity)
    VALUES (orderId, product,quantity);

  -- Commit transaction
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    -- Rollback to savepoint in case of error
    ROLLBACK TO sp_before_order;
    RAISE;
END PlaceNewOrder;
/
