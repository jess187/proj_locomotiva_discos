
-- Banco de Dados: Projeto Final - Locomotiva Discos

-- Tabelas LOG
-- LOG para operações na tabela `albums`
CREATE TABLE log_albums (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_type VARCHAR(50),
    album_id INT,
    user VARCHAR(100),
    operation_date DATE,
    operation_time TIME
);

-- LOG para operações na tabela `customers`
CREATE TABLE log_customers (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_type VARCHAR(50),
    customer_id INT,
    user VARCHAR(100),
    operation_date DATE,
    operation_time TIME
);

-- TRIGGERS

-- BEFORE INSERT na tabela `albums`
DELIMITER $$
CREATE TRIGGER before_insert_album
BEFORE INSERT ON albums
FOR EACH ROW
BEGIN
    INSERT INTO log_albums (operation_type, album_id, user, operation_date, operation_time)
    VALUES ('INSERT', NEW.album_id, USER(), CURDATE(), CURTIME());
END$$
DELIMITER ;

-- AFTER UPDATE na tabela `albums`
DELIMITER $$
CREATE TRIGGER after_update_album
AFTER UPDATE ON albums
FOR EACH ROW
BEGIN
    INSERT INTO log_albums (operation_type, album_id, user, operation_date, operation_time)
    VALUES ('UPDATE', NEW.album_id, USER(), CURDATE(), CURTIME());
END$$
DELIMITER ;

-- BEFORE DELETE na tabela `customers`
DELIMITER $$
CREATE TRIGGER before_delete_customer
BEFORE DELETE ON customers
FOR EACH ROW
BEGIN
    INSERT INTO log_customers (operation_type, customer_id, user, operation_date, operation_time)
    VALUES ('DELETE', OLD.customer_id, USER(), CURDATE(), CURTIME());
END$$
DELIMITER ;

-- AFTER INSERT na tabela `customers`
DELIMITER $$
CREATE TRIGGER after_insert_customer
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
    INSERT INTO log_customers (operation_type, customer_id, user, operation_date, operation_time)
    VALUES ('INSERT', NEW.customer_id, USER(), CURDATE(), CURTIME());
END$$
DELIMITER ;

-- EXPLICAÇÕES

/*
1. Trigger `before_insert_album`:
   - Controla a ação antes da inserção de um novo registro na tabela `albums`.
   - Registra no log o tipo de operação (INSERT), o ID do álbum, o usuário que realizou a ação, e a data e hora.

2. Trigger `after_update_album`:
   - Controla a ação após a atualização de um registro na tabela `albums`.
   - Registra no log o tipo de operação (UPDATE), o ID do álbum atualizado, o usuário que realizou a ação, e a data e hora.

3. Trigger `before_delete_customer`:
   - Controla a ação antes da exclusão de um registro na tabela `customers`.
   - Registra no log o tipo de operação (DELETE), o ID do cliente excluído, o usuário que realizou a ação, e a data e hora.

4. Trigger `after_insert_customer`:
   - Controla a ação após a inserção de um novo registro na tabela `customers`.
   - Registra no log o tipo de operação (INSERT), o ID do cliente, o usuário que realizou a ação, e a data e hora.
*/
