--1
ALTER TABLE buyers
add constraint len_of_buyer_id
CHECK (length(buyer_id) >= 4);


INSERT INTO Buyers (buyer_id, buyer_name, email, phone, address) VALUES (999, 'avi', 'ohackett0@globo.com', '054-343-2341', '70 herzel ofakim');


--2
ALTER TABLE Orders
ADD CONSTRAINT check_order_date_since_2023
CHECK (order_date >= DATE '2023-01-01');


INSERT INTO Orders (order_id,order_date, tracking_number, product_id, buyer_id) VALUES (1233456,DATE '2021-07-25', 65443321,1 ,9999);



--3
ALTER TABLE Categories
ADD CONSTRAINT check_information_empty
CHECK (information IS NOT NULL);


INSERT INTO Categories (category_id,category_name,information ) VALUES (31,'tashmishi kdoshy','');
