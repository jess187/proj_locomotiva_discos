
-- View 1: Exibir detalhes de vendas incluindo cliente, disco e valor
-- Mostra informações detalhadas sobre as vendas, incluindo os clientes, os discos comprados e o valor total de cada venda.
CREATE VIEW SalesDetails AS
SELECT 
    Sales.sale_id AS SaleID,
    Customers.full_name AS CustomerName,
    Vinyls.title AS VinylTitle,
    Vinyls.artist AS Artist,
    Sales.sale_date AS SaleDate,
    Sales.total_amount AS TotalAmount
FROM 
    Sales
JOIN 
    Customers ON Sales.customer_id = Customers.customer_id
JOIN 
    Vinyls ON Sales.vinyl_id = Vinyls.vinyl_id;

-- View 2: Mostrar o estoque atual de vinis por fornecedor
-- Exibe o estoque atual de vinis organizado por fornecedor.
CREATE VIEW StockBySupplier AS
SELECT 
    Suppliers.supplier_name AS SupplierName,
    Vinyls.title AS VinylTitle,
    Vinyls.artist AS Artist,
    Inventory.stock_quantity AS StockQuantity
FROM 
    Vinyls
JOIN 
    Inventory ON Vinyls.vinyl_id = Inventory.vinyl_id
JOIN 
    Suppliers ON Vinyls.supplier_id = Suppliers.supplier_id;

-- View 3: Exibir o ranking de clientes por total de compras
-- Lista os clientes em ordem decrescente com base no valor total gasto e o número de compras.
CREATE VIEW CustomerRanking AS
SELECT 
    Customers.full_name AS CustomerName,
    SUM(Sales.total_amount) AS TotalSpent,
    COUNT(Sales.sale_id) AS NumberOfPurchases
FROM 
    Sales
JOIN 
    Customers ON Sales.customer_id = Customers.customer_id
GROUP BY 
    Customers.full_name
ORDER BY 
    TotalSpent DESC;

-- View 4: Detalhes de funcionários com o número de vendas realizadas
-- Mostra a performance dos funcionários no número de vendas realizadas.
CREATE VIEW EmployeeSalesStats AS
SELECT 
    Employees.full_name AS EmployeeName,
    Employees.job_title AS JobTitle,
    COUNT(Sales.sale_id) AS TotalSales
FROM 
    Sales
JOIN 
    Employees ON Sales.employee_id = Employees.employee_id
GROUP BY 
    Employees.full_name, Employees.job_title
ORDER BY 
    TotalSales DESC;

-- View 5: Exibir histórico de compras com informações detalhadas do fornecedor
-- Apresenta o histórico de compras, incluindo informações dos fornecedores e detalhes dos discos adquiridos.
CREATE VIEW PurchaseHistory AS
SELECT 
    Purchases.purchase_id AS PurchaseID,
    Suppliers.supplier_name AS SupplierName,
    Vinyls.title AS VinylTitle,
    Vinyls.artist AS Artist,
    Purchases.purchase_date AS PurchaseDate,
    Purchases.total_cost AS TotalCost
FROM 
    Purchases
JOIN 
    Vinyls ON Purchases.vinyl_id = Vinyls.vinyl_id
JOIN 
    Suppliers ON Vinyls.supplier_id = Suppliers.supplier_id;
