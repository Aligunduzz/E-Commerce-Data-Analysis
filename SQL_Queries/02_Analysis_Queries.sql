-- ====================================================================
-- DATA ANALYST INTERNSHIP PROJECT - E-COMMERCE ANALYSIS
-- ====================================================================

-- ====================================================================
-- 1. EXPLORATORY DATA ANALYSIS (EDA) - VERİ KEŞIF ANALİZİ
-- ====================================================================

-- 1.1 Veri Seti Boyut ve Yapı Analizi
SELECT COUNT(*), COUNT(DISTINCT customer_id) FROM customers;

-- 1.2 Müşteri Satın Alma Davranışı - Tekrar Eden Müşteriler Analizi
SELECT COUNT(*), COUNT(DISTINCT Customer_Id) FROM Orders;

-- 1.3 Temel Tablo İncelemesi
SELECT * FROM Orders;
SELECT * FROM order_seller_clean;
SELECT * FROM order_payment;

-- 1.4 Veri Zaman Aralığı - Tarihsel Kapsam
SELECT MIN(Order_Purchase_Timestamp), MAX(Order_Purchase_Timestamp) FROM Orders;

-- 1.5 Veri Kalitesi Kontrolü - Eksik Veriler Analizi
SELECT * FROM Orders WHERE Customer_Id IS NULL;

-- 1.6 Toplam Satış Tutarı - Genel Özet
SELECT SUM(payment_value) as TOPLAM_SATIS_TUTARİ FROM order_payment;

-- ====================================================================
-- 2. TEMPORAL ANALYSIS (ZAMANSELİ ANALİZ) - SATIŞLAR ZAMAN BOYUTUNDA
-- ====================================================================

-- 2.1 Yıllık Satış Trendleri
SELECT
    YEAR(a1.Order_Purchase_Timestamp) as order_year,
    SUM(a2.payment_value) as total_sales,
    COUNT(DISTINCT a1.Customer_Id) as total_customers
FROM Orders a1
INNER JOIN order_payment a2 ON a1.Order_Id = a2.order_id
GROUP BY YEAR(a1.Order_Purchase_Timestamp)
ORDER BY YEAR(a1.Order_Purchase_Timestamp);

-- 2.2 Aylık Satış Trendleri - Mevsimsellik Analizi
SELECT
    MONTH(a1.Order_Purchase_Timestamp) as order_month,
    SUM(a2.payment_value) as total_sales,
    COUNT(DISTINCT a1.Customer_Id) as total_customers
FROM Orders a1
INNER JOIN order_payment a2 ON a1.Order_Id = a2.order_id
GROUP BY MONTH(a1.Order_Purchase_Timestamp)
ORDER BY MONTH(a1.Order_Purchase_Timestamp);

-- 2.3 Yıl ve Ay Kombinasyonu - Detaylı Zaman Serisi Analizi
SELECT
    YEAR(a1.Order_Purchase_Timestamp) as order_year,
    MONTH(a1.Order_Purchase_Timestamp) as order_month,
    SUM(a2.payment_value) as total_sales,
    COUNT(DISTINCT a1.Customer_Id) as total_customers
FROM Orders a1
INNER JOIN order_payment a2 ON a1.Order_Id = a2.order_id
GROUP BY YEAR(a1.Order_Purchase_Timestamp), MONTH(a1.Order_Purchase_Timestamp)
ORDER BY YEAR(a1.Order_Purchase_Timestamp), MONTH(a1.Order_Purchase_Timestamp);

-- 2.4 Aylık Toplam Satışlar - Aylar Bazında Performans (Alternatif Yazım)
SELECT
    DATETRUNC(month, a1.Order_Purchase_Timestamp) as order_date,
    SUM(a2.payment_value) as total_sales,
    COUNT(DISTINCT a1.Customer_Id) as total_customers
FROM Orders a1
INNER JOIN order_payment a2 ON a1.Order_Id = a2.order_id
GROUP BY DATETRUNC(month, a1.Order_Purchase_Timestamp)
ORDER BY DATETRUNC(month, a1.Order_Purchase_Timestamp);

-- ====================================================================
-- 3. PAYMENT METHOD ANALYSIS (ÖDEME YÖNTEMİ ANALİZİ)
-- ====================================================================

-- 3.1 Ödeme Yöntemi Dağılımı - Müşteri Tercih Analizi
SELECT 
    payment_type, 
    COUNT(payment_type) as sum_of_payment_type
FROM order_payment
GROUP BY payment_type
ORDER BY COUNT(payment_type) DESC;

-- 3.2 Ürün Kategorisi ve Ödeme Yöntemi İlişkisi
SELECT 
    a1.product_category_name,
    a3.payment_type,
    COUNT(a3.payment_type) as transaction_count
FROM Products a1
LEFT JOIN order_items a2 ON a1.product_id = a2.Product_Id
LEFT JOIN order_payment a3 ON a2.Order_Id = a3.order_id
GROUP BY a1.product_category_name, a3.payment_type
ORDER BY a1.product_category_name, a3.payment_type;

-- 3.3 Yıllık Ödeme Yöntemi Dağılımı - Zaman İçinde Ödeme Tercihleri
SELECT 
    DATETRUNC(YEAR, a1.Order_Purchase_Timestamp) as order_year,
    a2.payment_type,
    COUNT(a2.payment_type) as total_payments
FROM Orders a1
INNER JOIN order_payment a2 ON a1.Order_Id = a2.order_id
GROUP BY DATETRUNC(YEAR, a1.Order_Purchase_Timestamp), payment_type
ORDER BY DATETRUNC(YEAR, a1.Order_Purchase_Timestamp), payment_type;

-- 3.4 Ödeme Yöntemi Satış Analizi - Hangi Ödeme Şekli Daha Çok Gelir Getirir?
SELECT
    DATETRUNC(YEAR, a1.order_purchase_timestamp) AS order_year,
    a2.payment_type,
    SUM(a2.payment_value) AS total_sales
FROM Orders a1
JOIN order_payment a2 ON a1.Order_Id = a2.order_id
GROUP BY
    DATETRUNC(YEAR, a1.order_purchase_timestamp),
    a2.payment_type
ORDER BY
    order_year,
    total_sales DESC;

-- ====================================================================
-- 4. SELLER PERFORMANCE ANALYSIS (SATICI PERFORMANSI ANALİZİ)
-- ====================================================================

-- 4.1 Satıcı Coğrafi Dağılımı - Şehir ve Eyalet Bazında Satış Performansı
SELECT 
    a1.Seller_State,
    a1.Seller_City, 
    SUM(a2.Price) as TotalValue
FROM order_seller_clean a1
LEFT JOIN order_items a2 ON a1.Seller_Id = a2.Seller_Id
GROUP BY a1.Seller_State, a1.Seller_City
ORDER BY SUM(a2.Price) DESC;
