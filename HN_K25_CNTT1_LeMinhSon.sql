CREATE DATABASE manager_shoppe;
USE manager_shoppe;

SET SQL_SAFE_UPDATES = 0;
-- Bảng khách hàng (Customers)
CREATE TABLE Customers (
	customer_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE
);

-- Bảng thương hiệu
CREATE TABLE Brands (
	brand_id VARCHAR(5) PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE
);

-- Bảng sản phẩm
CREATE TABLE Products (
	product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    brand_id VARCHAR(5) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES Brands (brand_id)
);

-- Bảng Orders 
CREATE TABLE Orders (
	order_id INT PRIMARY KEY auto_increment,
    customer_id VARCHAR(5) NOT NULL,
    product_id VARCHAR(5) NOT NULL, 
    status ENUM('Pending', 'Completed', 'Cancelled'),
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

-- Thêm dữ liệu vào cột
-- Thêm dữ liệu vào bảng Customers
INSERT INTO Customers (customer_id, full_name, email, phone)
VALUES 
('C01', 'Nguyễn Văn An', 'an.nv@gmail.com', '0911111111'),
('C02', 'Nguyễn Thị Mai', 'mai.nt@gmail.com',  '0922222222'),
('C03', 'Trần Quang Hải', 'hai.tq@gmail.com', '0933333333'),
('C04', 'Phạm Bảo Ngọc', 'ngoc.pb@gmail.com', '0944444444'),
('C05', 'Vũ Đức Đam', 'dam.vd@gmail.com', '0955555555');

-- Thêm dữ liệu vào bảng Brands
INSERT INTO Brands (brand_id, brand_name)
VALUES
('B01', 'Apple'),
('B02', 'Samsung'),
('B03', 'Sony'),
('B04', 'Dell');

-- Thêm dữ liệu vào bảng Products
INSERT INTO Products (product_id, product_name, brand_id, price, stock)
VALUES 
('P01', 'iPhone 15 Pro Max', 'B01', 30000000.00, 10),
('P02', 'MacBook Pro M3', 'B01', 45000000.00, 5),
('P03', 'Galaxy S24 Ultra', 'B02', 25000000.00, 20),
('P04', 'PlayStation 5', 'B03', 15000000.00, 8),
('P05', 'Dell XPS 15', 'B04', 35000000.00, 15);

-- Thêm dữ liệu vào bảng Orders
INSERT INTO Orders (customer_id, product_id, status, order_date)
VALUES
('C01', 'P01', 'Pending', '2025-10-01'),
('C02', 'P03', 'Completed', '2025-10-02'),
('C01', 'P02', 'Completed', '2025-10-03'),
('C04', 'P05', 'Cancelled', '2025-10-04'),
('C05', 'P01', 'Pending', '2025-10-05'); 

-- 3.
SELECT * FROM Products;
UPDATE Products 
SET stock = stock + 10, price = price * 1.05
WHERE product_name = 'Dell XPS 15';

-- 4.
SELECT * FROM Customers;
UPDATE Customers
SET phone = '0999999999'
WHERE customer_id = 'C03';

-- 5.
SELECT * FROM Orders;
DELETE FROM Orders
WHERE status = 'Completed' AND order_date < '2025-10-03';

-- 6.
SELECT product_id, product_name, price FROM Products
WHERE price BETWEEN 15000000 AND 30000000 AND stock > 0;

-- 7. 
SELECT full_name, email FROM Customers
WHERE full_name LIKE ('%Nguyễn%');

-- 8. 
SELECT order_id, customer_id, order_date FROM Orders
ORDER BY order_date DESC;

-- 9. 
SELECT * FROM Products 
ORDER BY price DESC
LIMIT 3;

-- 10.
SELECT product_name, stock FROM Products
ORDER BY product_id 
LIMIT 2 OFFSET 2;

-- 11
SELECT o.order_id, c.full_name, p.product_name, order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
WHERE o.status = 'Pending';

-- 12.
SELECT b.brand_name, COUNT(p.product_id) AS total_products
FROM Brands b 
LEFT JOIN Products p ON p.brand_id = b.brand_id 
GROUP BY b.brand_id, b.brand_name;

-- 15.
SELECT product_id, product_name, price FROM Products
WHERE price > (
	SELECT AVG(price) FROM Products
)
LIMIT 1;








