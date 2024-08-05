-- the fucntion will update the prices of all the products from the given category

CREATE OR REPLACE FUNCTION UpdatePricesByCategory (
  startDate IN DATE,
  categoryId IN INT
) RETURN VARCHAR2 IS
  CURSOR productCursor IS
    SELECT product_id, price
    FROM Products
    WHERE category_id = categoryId AND available_date >= startDate ;

  productRecord productCursor%ROWTYPE;
  updatedCount INT := 0;

BEGIN
  -- Open the cursor
  OPEN productCursor;

  -- Loop through each product
  LOOP
    FETCH productCursor INTO productRecord;
    EXIT WHEN productCursor%NOTFOUND;

    -- Update the product price by 5%
    UPDATE Products
    SET price = price * 1.05
    WHERE product_id = productRecord.product_id;
    

    -- Increment the count of updated products
    updatedCount := updatedCount + 1;
  END LOOP;

  -- Close the cursor
  CLOSE productCursor;

  -- Return a success message with the number of updated products
  RETURN 'Updated ' || updatedCount || ' products successfully.';

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Handle the case where no matching products are found
    RETURN 'No products found for the given category and date range.';
  WHEN OTHERS THEN
    -- Handle other unexpected errors
    RAISE_APPLICATION_ERROR(-20003, 'An unexpected error occurred: ' || SQLERRM);
END UpdatePricesByCategory;
/
