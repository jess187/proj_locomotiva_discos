-- Projeto SQL: Locomotiva Discos  por Jéssica Oliveira
-- Descrição: Este projeto modela o banco de dados de uma loja de discos de vinil chamada Locomotiva Discos, abrangendo entidades como produtos, clientes, compras, fornecedores e funcionários.

-- Etapa 1: Criação do banco de dados
CREATE DATABASE LocomotivaDiscos;
USE LocomotivaDiscos;

-- Etapa 2: Criação das tabelas

-- Tabela: Suppliers (Fornecedores)
CREATE TABLE Suppliers (
    Supplier_ID INT AUTO_INCREMENT PRIMARY KEY,
    Supplier_Name VARCHAR(100) NOT NULL,
    Supply_Date DATE NOT NULL,
    Contact_Email VARCHAR(100),
    Phone_Number VARCHAR(20)
);

-- Tabela: Products (Produtos)
CREATE TABLE Products (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    Supplier_ID INT,
    FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID)
);

-- Tabela: Employees (Funcionários)
CREATE TABLE Employees (
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    Employee_Name VARCHAR(100) NOT NULL,
    Position VARCHAR(50),
    Hire_Date DATE,
    Salary DECIMAL(10, 2)
);

-- Tabela: Customers (Clientes)
CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone_Number VARCHAR(20)
);

-- Tabela: Purchases (Compras)
CREATE TABLE Purchases (
    Purchase_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Employee_ID INT,
    Purchase_Date DATE NOT NULL,
    Total_Price DECIMAL(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

-- Tabela: PurchaseDetails (Detalhes de Compra)
CREATE TABLE PurchaseDetails (
    PurchaseDetail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Purchase_ID INT,
    Product_ID INT,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Purchase_ID) REFERENCES Purchases(Purchase_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Etapa 3: Inserção de Dados

-- Dados: Suppliers
INSERT INTO Suppliers (Supplier_Name, Supply_Date, Contact_Email, Phone_Number) VALUES
('Vinyl Co.', '2024-01-15', 'contact@vinylco.com', '123456789'),
('Music House', '2024-02-10', 'info@musichouse.com', '987654321');

-- Dados: Products
INSERT INTO Products (Product_Name, Genre, Price, Stock, Supplier_ID) VALUES
('Abbey Road', 'Rock', 120.50, 20, 1),
('Thriller', 'Pop', 150.00, 15, 2);

-- Dados: Employees
INSERT INTO Employees (Employee_Name, Position, Hire_Date, Salary) VALUES
('Alice Johnson', 'Manager', '2023-03-01', 5000.00),
('Bob Smith', 'Salesperson', '2023-05-10', 3000.00);

-- Dados: Customers
INSERT INTO Customers (Customer_Name, Email, Phone_Number) VALUES
('John Doe', 'john.doe@example.com', '123123123'),
('Jane Roe', 'jane.roe@example.com', '321321321');

-- Dados: Purchases
INSERT INTO Purchases (Customer_ID, Employee_ID, Purchase_Date, Total_Price) VALUES
(1, 1, '2024-04-01', 240.50),
(2, 2, '2024-04-02', 150.00);

-- Dados: PurchaseDetails
INSERT INTO PurchaseDetails (Purchase_ID, Product_ID, Quantity, Subtotal) VALUES
(1, 1, 2, 241.00),
(2, 2, 1, 150.00);

-- Etapa 4: Views

-- View 1: Produtos disponíveis
CREATE VIEW AvailableProducts AS
SELECT Product_Name, Genre, Price, Stock
FROM Products
WHERE Stock > 0;

-- View 2: Compras realizadas
CREATE VIEW PurchaseSummary AS
SELECT p.Purchase_ID, c.Customer_Name, e.Employee_Name, p.Purchase_Date, p.Total_Price
FROM Purchases p
JOIN Customers c ON p.Customer_ID = c.Customer_ID
JOIN Employees e ON p.Employee_ID = e.Employee_ID;

-- View 3: Estoque por fornecedor
CREATE VIEW StockBySupplier AS
SELECT s.Supplier_Name, SUM(pr.Stock) AS Total_Stock
FROM Suppliers s
JOIN Products pr ON s.Supplier_ID = pr.Supplier_ID
GROUP BY s.Supplier_Name;

-- View 4: Faturamento total
CREATE VIEW TotalRevenue AS
SELECT SUM(Total_Price) AS Total_Revenue FROM Purchases;

-- View 5: Produtos mais vendidos
CREATE VIEW TopSellingProducts AS
SELECT pr.Product_Name, SUM(pd.Quantity) AS Total_Sold
FROM Products pr
JOIN PurchaseDetails pd ON pr.Product_ID = pd.Product_ID
GROUP BY pr.Product_Name
ORDER BY Total_Sold DESC;

-- Etapa 5: Funções

-- Função 1: Estoque total
DELIMITER //
CREATE FUNCTION GetTotalStock()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_stock INT;
    SELECT SUM(Stock) INTO total_stock FROM Products;
    RETURN total_stock;
END //
DELIMITER ;

-- Função 2: Compras de um cliente
DELIMITER //
CREATE FUNCTION GetCustomerPurchaseTotal(customer_id INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE customer_info VARCHAR(255);
    SELECT CONCAT(Customers.Customer_Name, ' - Total Purchases: $', SUM(Purchases.Total_Price))
    INTO customer_info
    FROM Customers
    JOIN Purchases ON Customers.Customer_ID = Purchases.Customer_ID
    WHERE Customers.Customer_ID = customer_id;
    RETURN customer_info;
END //
DELIMITER ;
