-- insertTables.sql

-- Insert data into Sellers table
INSERT INTO Sellers (seller_name, seller_id, phone, address) VALUES ('Seller One', 1, '123-456-7890', '123 Seller St');
INSERT INTO Sellers (seller_name, seller_id, phone, address) VALUES ('Seller Two', 2, '987-654-3210', '456 Seller Ave');

-- Insert data into Categories table
INSERT INTO Categories (category_id, category_name, information) VALUES (1, 'Electronics', 'Electronic items and gadgets');
INSERT INTO Categories (category_id, category_name, information) VALUES (2, 'Books', 'Various books and literature');

-- Insert data into Products table
INSERT INTO Products (product_id, product_name, information, price, category_id) VALUES (1, 'Laptop', 'High performance laptop', 999.99, 1);
INSERT INTO Products (product_id, product_name, information, price, category_id) VALUES (2, 'Smartphone', 'Latest model smartphone', 699.99, 1);
INSERT INTO Products (product_id, product_name, information, price, category_id) VALUES (3, 'Novel', 'Best-selling novel', 19.99, 2);

-- Insert data into OrderDetails table
INSERT INTO OrderDetails (product_id, quantity, delivery_method) VALUES (1, 10, 'Standard');
INSERT INTO OrderDetails (product_id, quantity, delivery_method) VALUES (2, 15, 'Express');
INSERT INTO OrderDetails (product_id, quantity, delivery_method) VALUES (3, 5, 'Standard');

-- Insert data into Buyers table
INSERT INTO Buyers (buyer_id, buyer_name, email, phone, address) VALUES (1, 'Buyer One', 'buyer1@example.com', '111-222-3333', '123 Buyer Rd');
INSERT INTO Buyers (buyer_id, buyer_name, email, phone, address) VALUES (2, 'Buyer Two', 'buyer2@example.com', '444-555-6666', '456 Buyer Ln');

-- Insert data into Orders table
INSERT INTO Orders (order_id, order_date, tracking_number, product_id, buyer_id) VALUES (1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'TRACK123', 1, 1);
INSERT INTO Orders (order_id, order_date, tracking_number, product_id, buyer_id) VALUES (2, TO_DATE('2024-01-02', 'YYYY-MM-DD'), 'TRACK456', 2, 2);
INSERT INTO Orders (order_id, order_date, tracking_number, product_id, buyer_id) VALUES (3, TO_DATE('2024-01-03', 'YYYY-MM-DD'), 'TRACK789', 3, 1);

-- Insert data into Reviews table
INSERT INTO Reviews (review_id, rating, comment_text, review_date, product_id, buyer_id) VALUES (1, 4.5, 'Great product!', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 1, 1);
INSERT INTO Reviews (review_id, rating, comment_text, review_date, product_id, buyer_id) VALUES (2, 3.5, 'Good value for money', TO_DATE('2024-01-11', 'YYYY-MM-DD'), 2, 2);
INSERT INTO Reviews (review_id, rating, comment_text, review_date, product_id, buyer_id) VALUES (3, 5.0, 'Excellent read!', TO_DATE('2024-01-12', 'YYYY-MM-DD'), 3, 1);

-- Insert data into sell table
INSERT INTO sell (seller_id, product_id) VALUES (1, 1);
INSERT INTO sell (seller_id, product_id) VALUES (1, 3);
INSERT INTO sell (seller_id, product_id) VALUES (2, 2);

-- Insert data into include table
INSERT INTO include_products (order_id, product_id) VALUES (1, 1);
INSERT INTO include_products (order_id, product_id) VALUES (2, 2);
INSERT INTO include_products (order_id, product_id) VALUES (3, 3);

-- End of insertTables.sql

select * from sellers        
