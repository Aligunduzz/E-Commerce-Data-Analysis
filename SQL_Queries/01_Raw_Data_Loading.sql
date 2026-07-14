CREATE DATABASE ECommerceDB;
GO

USE ECommerceDB;
GO


CREATE TABLE customers (
    customer_id NVARCHAR(50) NOT NULL,
    customer_unique_id NVARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT NOT NULL,
    customer_city NVARCHAR(100) NOT NULL,
    customer_state NVARCHAR(2) NOT NULL,

    CONSTRAINT PK_customers PRIMARY KEY (customer_id)
);
GO


SELECT *
FROM customers




BULK INSERT customers
FROM 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\customers_clean.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

SELECT *
FROM customers

-----------------------------------------------------------------------------------------------------------


CREATE TABLE order_items (
    Order_Id NVARCHAR(50) NOT NULL,
    Order_Item_Id INT NOT NULL,
    Product_Id NVARCHAR(50) NOT NULL,
    Seller_Id NVARCHAR(50) NOT NULL,
    Shipping_Limit_Date DATETIME NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Freight_Value DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_order_items PRIMARY KEY (Order_Id, Order_Item_Id)
);
GO




BULK INSERT order_items
FROM 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\order_items_clean.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001',
    TABLOCK
);


SELECT *
FROM
order_items


-----------------------------------------------------------------------------------------------------------


CREATE TABLE order_payment (
    order_id NVARCHAR(50) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type NVARCHAR(30) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_order_payment 
    PRIMARY KEY (order_id, payment_sequential)
);
GO



BULK INSERT order_payment
FROM 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\order_payment_clean.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001',
    TABLOCK
);


SELECT *
FROM 
order_payment



-----------------------------------------------------------------------------------------------------------


CREATE TABLE order_reviews_clean (
    Review_Id NVARCHAR(50) NOT NULL,
    Order_Id NVARCHAR(50) NOT NULL,
    Review_Score INT NOT NULL,
    Review_Comment_Title NVARCHAR(200) NULL,
    Review_Comment_Message NVARCHAR(800) NULL,
    Review_Creation_Date NVARCHAR(50) NOT NULL,
    Review_Answer_Timestamp NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_order_reviews 
    PRIMARY KEY (Review_Id)
);
GO

DROP TABLE order_reviews_clean;
GO


BULK INSERT order_reviews_clean
FROM 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\order_reviews_clean.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);


SELECT * 
FROM order_reviews


-----------------------------------------------------------------------------------------------------------


USE ECommerceDB;
GO

CREATE TABLE order_seller_clean (
    Seller_Id NVARCHAR(50) NOT NULL,
    Seller_Zip_Code_Prefix INT NOT NULL,
    Seller_City NVARCHAR(100) NOT NULL,
    Seller_State NVARCHAR(2) NOT NULL,

    CONSTRAINT PK_order_seller_clean
    PRIMARY KEY (Seller_Id)
);
GO

SELECT *
FROM order_seller_clean

BULK INSERT order_seller_clean
FROM 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\order_seller_clean.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    MAXERRORS = 1000,
    ERRORFILE = 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\order_seller_errors'
);




DROP TABLE order_seller_clean;
GO


CREATE TABLE order_seller_clean (
    Seller_Id NVARCHAR(100),
    Seller_Zip_Code_Prefix NVARCHAR(50),
    Seller_City NVARCHAR(200),
    Seller_State NVARCHAR(50)
);
GO


BULK INSERT order_seller_clean
FROM 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\order_seller_clean.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
);


SELECT *
FROM order_seller_clean



-----------------------------------------------------------------------------------------------------------


CREATE TABLE Orders (
    Order_Id                       VARCHAR(50) NOT NULL,
    Customer_Id                    VARCHAR(50) NOT NULL,
    Order_Status                   VARCHAR(30) NOT NULL,
    Order_Purchase_Timestamp       DATETIME2 NOT NULL,
    Order_Approved_At              DATETIME2 NULL,
    Order_Delivered_Carrier_Date   DATETIME2 NULL,
    Order_Delivered_Customer_Date  DATETIME2 NULL,
    Order_Estimated_Delivery_Date  DATETIME2 NOT NULL,

    CONSTRAINT PK_Orders PRIMARY KEY (Order_Id)
);



BULK INSERT Orders
FROM 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\orders_clean.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK,
    CODEPAGE = '65001'
);


SELECT *
FROM Orders




-----------------------------------------------------------------------------------------------------------


CREATE TABLE Products (
    product_id                    VARCHAR(50) NOT NULL,
    product_category_name         VARCHAR(100) NULL,
    product_name_length           INT NULL,
    product_description_length    INT NULL,
    product_photos_qty            INT NULL,
    product_weight_g              DECIMAL(10,2) NULL,
    product_length_cm             DECIMAL(10,2) NULL,
    product_height_cm             DECIMAL(10,2) NULL,
    product_width_cm              DECIMAL(10,2) NULL,

    CONSTRAINT PK_Products PRIMARY KEY (product_id)
);

ALTER TABLE Products ALTER COLUMN product_name_length FLOAT NULL;

ALTER TABLE Products ALTER COLUMN product_description_length FLOAT NULL;

ALTER TABLE Products ALTER COLUMN product_photos_qty FLOAT NULL;

ALTER TABLE Products ALTER COLUMN product_weight_g FLOAT NULL;

ALTER TABLE Products ALTER COLUMN product_length_cm FLOAT NULL;

ALTER TABLE Products ALTER COLUMN product_height_cm FLOAT NULL;

ALTER TABLE Products ALTER COLUMN product_width_cm FLOAT NULL;


BULK INSERT Products
FROM 'C:\Users\Ali\JUPİTER İÇİN\Olist_projesi\data\cleaned\products_clean.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK,
    CODEPAGE = '65001'
);

select *
from Products
