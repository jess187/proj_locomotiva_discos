-- Script de Criacao do Banco de Dados e Tabelas para "Locomotiva Discos"

-- Criar o Banco de Dados
CREATE DATABASE VinylStore;
USE VinylStore;

-- Tabela: Customers
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- Tabela: Employees
CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- Tabela: Suppliers
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    tax_id VARCHAR(20) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- Tabela: Inventory
CREATE TABLE Inventory (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    album_title VARCHAR(100) NOT NULL,
    artist VARCHAR(100),
    quantity INT DEFAULT 0,
    price DECIMAL(10,2),
    entry_date DATE,
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Tabela: Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_value DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Tabela: Order_Items (Tabela Intermediaria para eliminar N:N entre Orders e Inventory)
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Inventory(item_id)
);

-- Tabela: Supplies (Tabela Intermediaria para eliminar N:N entre Suppliers e Inventory)
CREATE TABLE Supplies (
    supply_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    item_id INT,
    quantity INT,
    supply_date DATE,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (item_id) REFERENCES Inventory(item_id)
);