
-- Script de Inserção de Dados para o Banco de Dados "Locomotiva Discos"

-- Inserção de Dados: Customers
INSERT INTO Customers (full_name, email, phone, address) VALUES
('John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St'),
('Jane Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St'),
('Alice Johnson', 'alice.johnson@example.com', '555-666-7777', '789 Oak St');

-- Inserção de Dados: Employees
INSERT INTO Employees (full_name, position, salary, hire_date) VALUES
('Michael Brown', 'Manager', 4000.00, '2023-01-15'),
('Emily Davis', 'Sales Associate', 2500.00, '2023-03-01'),
('James Wilson', 'Stock Clerk', 2000.00, '2023-04-20');

-- Inserção de Dados: Suppliers
INSERT INTO Suppliers (supplier_name, tax_id, phone, address) VALUES
('Vinyl World', '123456789', '123-456-7890', '10 Vinyl St'),
('Music Hub', '987654321', '987-654-3210', '20 Melody Ave'),
('Groove Inc.', '555666777', '555-666-7777', '30 Harmony Blvd');

-- Inserção de Dados: Inventory
INSERT INTO Inventory (album_title, artist, quantity, price, entry_date, supplier_id) VALUES
('Abbey Road', 'The Beatles', 10, 19.99, '2024-01-01', 1),
('Dark Side of the Moon', 'Pink Floyd', 5, 24.99, '2024-01-05', 2),
('Thriller', 'Michael Jackson', 15, 18.99, '2024-01-10', 3);

-- Inserção de Dados: Orders
INSERT INTO Orders (customer_id, employee_id, order_date, total_value) VALUES
(1, 1, '2024-02-01', 39.98),
(2, 2, '2024-02-02', 24.99),
(3, 3, '2024-02-03', 18.99);

-- Inserção de Dados: Order_Items
INSERT INTO Order_Items (order_id, item_id, quantity, unit_price) VALUES
(1, 1, 2, 19.99),
(2, 2, 1, 24.99),
(3, 3, 1, 18.99);

-- Inserção de Dados: Supplies
INSERT INTO Supplies (supplier_id, item_id, quantity, supply_date) VALUES
(1, 1, 10, '2024-01-01'),
(2, 2, 5, '2024-01-05'),
(3, 3, 15, '2024-01-10');
