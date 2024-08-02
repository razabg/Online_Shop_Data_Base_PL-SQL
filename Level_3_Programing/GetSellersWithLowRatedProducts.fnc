--function that receives a rating as a parameter and returns a list of sellers
-- who have products with ratings below the given rating between the range of the param dates
-- refcursor ,exception


CREATE OR REPLACE FUNCTION GetSellersWithLowRatedProducts(
  p_rating IN NUMBER,
  p_start_date IN DATE,
  p_end_date IN DATE
) RETURN SYS_REFCURSOR IS
  v_sellers SYS_REFCURSOR;
BEGIN
  OPEN v_sellers FOR
    SELECT DISTINCT s.seller_id, se.seller_name, AVG(r.rating) OVER (PARTITION BY p.product_id) AS avg_rating
    FROM Reviews r
    JOIN Products p ON r.product_id = p.product_id
    JOIN sell s ON p.product_id = s.product_id
    JOIN sellers se ON s.seller_id = se.seller_id
    WHERE r.rating < p_rating
      AND r.review_date BETWEEN p_start_date AND p_end_date;

  RETURN v_sellers;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No sellers found with products rated below ' || p_rating || ' within the given date range.');
    RETURN NULL;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    RETURN NULL;
END GetSellersWithLowRatedProducts;
/
