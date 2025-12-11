-- SQL Basics Practice Schema for Data Engineering Interviews
-- Drop and recreate database
DROP DATABASE IF EXISTS de_sql_basics;
CREATE DATABASE de_sql_basics;
USE de_sql_basics;

-- Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

-- Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    discount_code VARCHAR(20) NULL,
    shipped_at DATETIME NULL,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;

-- Order items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id)
        REFERENCES products(product_id)
) ENGINE=InnoDB;

-- Payments table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    paid_at DATETIME NULL,
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
) ENGINE=InnoDB;

-- Seed data: customers
INSERT INTO customers (first_name, last_name, email, phone, city, created_at) VALUES
('Raj', 'Verma', 'raj.verma@example.com', '9876543210', 'Bangalore', '2025-01-10 09:15:00'),
('Ananya', 'Sharma', 'ananya.sharma@example.com', '9876543211', 'Mumbai', '2025-01-11 10:30:00'),
('Karan', 'Patel', 'karan.patel@example.com', NULL, 'Pune', '2025-01-12 08:45:00'),
('Meera', 'Iyer', NULL, '9876543212', 'Chennai', '2025-01-13 11:00:00'),
('Vikram', 'Singh', 'vikram.singh@example.com', '9876543213', 'Delhi', '2025-01-14 12:20:00'),
('Sara', 'Khan', 'sara.khan@example.com', NULL, 'Bangalore', '2025-01-15 14:10:00');

-- Seed data: products
INSERT INTO products (product_name, category, price, is_active) VALUES
('Mechanical Keyboard', 'Electronics', 4500.00, 1),
('Wireless Mouse', 'Electronics', 1200.00, 1),
('Noise Cancelling Headphones', 'Electronics', 8500.00, 1),
('Office Chair', 'Furniture', 9000.00, 1),
('Standing Desk', 'Furniture', 18000.00, 1),
('Laptop Stand', 'Accessories', 2200.00, 0);

-- Seed data: orders
INSERT INTO orders (customer_id, order_date, status, discount_code, shipped_at) VALUES
(1, '2025-02-01', 'DELIVERED', 'NEW10', '2025-02-02 16:30:00'),
(1, '2025-02-10', 'PENDING', NULL, NULL),
(2, '2025-02-05', 'DELIVERED', NULL, '2025-02-06 11:45:00'),
(3, '2025-02-07', 'CANCELLED', 'SAVE5', NULL),
(4, '2025-02-12', 'DELIVERED', NULL, '2025-02-13 10:00:00'),
(5, '2025-02-15', 'SHIPPED', 'NEW10', '2025-02-16 18:20:00'),
(5, '2025-02-18', 'DELIVERED', NULL, '2025-02-19 12:00:00'),
(6, '2025-02-20', 'PENDING', NULL, NULL);

-- Seed data: order_items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 4500.00),
(1, 2, 2, 1200.00),
(2, 3, 1, 8500.00),
(3, 2, 1, 1200.00),
(3, 6, 1, 2200.00),
(4, 4, 1, 9000.00),
(5, 5, 1, 18000.00),
(5, 2, 1, 1200.00),
(6, 1, 1, 4500.00),
(6, 3, 1, 8500.00),
(7, 1, 1, 4300.00), -- discounted unit price
(7, 2, 1, 1200.00),
(7, 3, 1, 8000.00), -- discounted unit price
(8, 4, 1, 9000.00);

-- Seed data: payments
INSERT INTO payments (order_id, amount, payment_method, paid_at) VALUES
(1, 6900.00, 'CARD', '2025-02-01 17:00:00'),
(2, 8500.00, 'UPI', NULL), -- initiated but not completed
(3, 3400.00, 'CARD', '2025-02-05 12:15:00'),
(4, 9000.00, 'NETBANKING', '2025-02-07 09:30:00'),
(5, 19200.00, 'CARD', '2025-02-15 19:00:00'),
(6, 13000.00, 'UPI', '2025-02-15 20:10:00'),
(7, 13500.00, 'CARD', '2025-02-18 13:25:00');
