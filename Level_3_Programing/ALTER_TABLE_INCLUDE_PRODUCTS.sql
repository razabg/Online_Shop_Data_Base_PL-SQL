ALTER TABLE include_products
ADD quantity INT ;

UPDATE include_products
SET quantity = FLOOR(DBMS_RANDOM.VALUE(1, 21));


--current stock
ALTER TABLE products
ADD stock INT ;

UPDATE products
SET stock = FLOOR(DBMS_RANDOM.VALUE(1, 30));


ALTER TABLE Products
ADD available_date DATE;

ALTER TABLE Orderdetails
ADD Order_status varchar2(20);


UPDATE Orderdetails
SET Order_status = 
    CASE 
        WHEN DBMS_RANDOM.VALUE(0, 1) < 0.5 THEN 'pending' 
        ELSE 'shipped' 
    END;
