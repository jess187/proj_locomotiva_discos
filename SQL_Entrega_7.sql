-- Função 1: Calcula o estoque total de todos os produtos
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

-- Função 2: Retorna o nome do cliente e o total de compras realizadas por ele
DELIMITER //
CREATE FUNCTION GetCustomerPurchaseTotal(customer_id INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE customer_info VARCHAR(255);
    SELECT CONCAT(Customers.Name, ' - Total Purchases: $', SUM(Purchases.Total_Price))
    INTO customer_info
    FROM Customers
    JOIN Purchases ON Customers.Customer_ID = Purchases.Customer_ID
    WHERE Customers.Customer_ID = customer_id;
    RETURN customer_info;
END //
DELIMITER ;


-- DEFINIÇÕES
GetTotalStock:

Calcula o total de itens no estoque da loja.
Faz uso da função agregada SUM do SQL.
Retorna um valor inteiro que representa a soma de todos os valores na coluna Stock da tabela Products.
GetCustomerPurchaseTotal:

Recebe como entrada o ID de um cliente (customer_id).
Utiliza um JOIN entre as tabelas Customers e Purchases para calcular o total das compras de um cliente específico.
Retorna uma string com o nome do cliente e o total de compras realizadas por ele.