CREATE OR REPLACE PROCEDURE PlaceNewOrder (
  buyerId IN INT,
  orderId IN INT,
  orderDate IN DATE,
  trackingNumber IN VARCHAR2,
  products IN SYS.ODCIVARCHAR2LIST, -- Assuming Oracle Collection type for list of product IDs
  quantities IN SYS.ODCINUMBERLIST   -- Assuming Oracle Collection type for list of quantities
) IS
  v_product_id INT;
  v_quantity INT;
  v_stock INT;
BEGIN
  -- Start transaction
  SAVEPOINT sp_before_order;

  FOR i IN 1 .. products.COUNT LOOP
    v_product_id := products(i);
    v_quantity := quantities(i);

    -- Check stock
    SELECT p.stock
    INTO v_stock
    FROM Products p
    WHERE p.product_id = v_product_id;

    IF v_stock < v_quantity THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for product ' || v_product_id);
    END IF;

    -- Insert into Orders table
    INSERT INTO Orders (order_id, order_date, tracking_number, product_id, buyer_id)
    VALUES (orderId, orderDate, trackingNumber, v_product_id, buyerId);

    -- Update stock
    UPDATE Products
    SET stock = stock - v_quantity
    WHERE product_id = v_product_id;

    -- Insert into include_products table
    INSERT INTO include_products (order_id, product_id)
    VALUES (orderId, v_product_id);
  END LOOP;

  -- Commit transaction
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    -- Rollback to savepoint in case of error
    ROLLBACK TO sp_before_order;
    RAISE;
END PlaceNewOrder;
/
/
