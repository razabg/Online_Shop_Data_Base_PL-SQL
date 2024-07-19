CREATE TABLE Sellers ( -- done
  seller_name VARCHAR2(20) NOT NULL, -- Changed INT to VARCHAR2(20) for name
  seller_id INT NOT NULL,
  phone VARCHAR2(20) NOT NULL, -- Changed INT to VARCHAR2(20) for phone numbers
  address VARCHAR2(30) NOT NULL, -- Changed INT to VARCHAR2(200) for address
  PRIMARY KEY (seller_id)
);

CREATE TABLE Categories ( -- done
  category_id INT NOT NULL,
  category_name VARCHAR2(35) NOT NULL, 
  information VARCHAR2(50),
  PRIMARY KEY (category_id)
);

CREATE TABLE OrderDetails ( --done need to genreate again
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  delivery_method VARCHAR2(20) NOT NULL,
  PRIMARY KEY (product_id)
);

CREATE TABLE Buyers ( --done
  buyer_id INT NOT NULL,
  buyer_name VARCHAR2(200) NOT NULL, 
  email VARCHAR2(255) NOT NULL, 
  phone VARCHAR2(20) NOT NULL, 
  address VARCHAR2(200) NOT NULL, 
  PRIMARY KEY (buyer_id)
);

CREATE TABLE Products ( -- done
  product_id INT NOT NULL,
  product_name VARCHAR2(200) NOT NULL, 
  information VARCHAR2(50), 
  price NUMBER(10,2) NOT NULL, -- Use NUMBER for price with precision (10) and scale (2)
  category_id INT NOT NULL,
  PRIMARY KEY (product_id),
  FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders ( --done need to generate
  order_id INT NOT NULL,
  order_date DATE NOT NULL, -- Use DATE for date
  tracking_number VARCHAR2(20) NOT NULL,
  product_id INT NOT NULL,
  buyer_id INT NOT NULL,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (product_id) REFERENCES OrderDetails(product_id),
  FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id)
);

CREATE TABLE Reviews ( --done
  review_id INT NOT NULL,
  rating NUMBER(10,1), -- Use NUMBER for rating with precision (10) and scale (1)
  comment_text VARCHAR2(2000), -- Changed INT to VARCHAR2(2000) for comment
  review_date DATE NOT NULL, -- Use DATE for date
  product_id INT NOT NULL,
  buyer_id INT NOT NULL,
  PRIMARY KEY (review_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id),
  FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id)
);

CREATE TABLE sell (
  seller_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (seller_id, product_id),
  FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE include_products (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id, product_id) REFERENCES Orders(order_id, product_id)
);
