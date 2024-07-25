-- dropTables.sql

-- Drop the tables in the reverse order of their creation to ensure all dependencies are handled properly

DROP TABLE include_products CASCADE CONSTRAINTS;
DROP TABLE sell CASCADE CONSTRAINTS;
DROP TABLE Reviews CASCADE CONSTRAINTS;
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Products CASCADE CONSTRAINTS;
DROP TABLE Buyers CASCADE CONSTRAINTS;
DROP TABLE OrderDetails CASCADE CONSTRAINTS;
DROP TABLE Categories CASCADE CONSTRAINTS;
DROP TABLE Sellers CASCADE CONSTRAINTS;

-- End of dropTables.sql
