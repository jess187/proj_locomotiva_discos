-- Entrega 2: Projeto Locomotiva Discos

-- ========================
-- 1. CRIAÇÃO DO BANCO DE DADOS
-- ========================
CREATE DATABASE LocomotivaDiscos;
USE LocomotivaDiscos;

-- ========================
-- 2. CRIAÇÃO DAS TABELAS
-- ========================
CREATE TABLE Artistas (
    id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    genero_musical VARCHAR(50),
    nacionalidade VARCHAR(50)
);

CREATE TABLE Albuns (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    ano_lancamento YEAR,
    id_artista INT,
    FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista)
);

CREATE TABLE Vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_album INT,
    data_venda DATE,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_album) REFERENCES Albuns(id_album)
);

CREATE TABLE Logs (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    tabela VARCHAR(50),
    operacao VARCHAR(50),
    usuario VARCHAR(50),
    data_hora DATETIME
);

-- ========================
-- 3. INSERÇÃO DE DADOS
-- ========================
INSERT INTO Artistas (nome, genero_musical, nacionalidade)
VALUES
('The Beatles', 'Rock', 'Inglaterra'),
('Elis Regina', 'MPB', 'Brasil'),
('Miles Davis', 'Jazz', 'EUA');

INSERT INTO Albuns (titulo, ano_lancamento, id_artista)
VALUES
('Abbey Road', 1969, 1),
('Elis & Tom', 1974, 2),
('Kind of Blue', 1959, 3);

INSERT INTO Vendas (id_album, data_venda, quantidade, preco_unitario)
VALUES
(1, '2025-01-01', 10, 50.00),
(2, '2025-01-02', 5, 60.00),
(3, '2025-01-03', 8, 70.00);

-- ========================
-- 4. VIEWS
-- ========================
-- View para verificar vendas totais por álbum
CREATE VIEW VendasTotais AS
SELECT 
    Albuns.titulo AS Album,
    SUM(Vendas.quantidade) AS TotalVendas,
    SUM(Vendas.quantidade * Vendas.preco_unitario) AS ReceitaTotal
FROM Vendas
JOIN Albuns ON Vendas.id_album = Albuns.id_album
GROUP BY Albuns.titulo;

-- ========================
-- 5. FUNÇÕES
-- ========================
-- Função para calcular a receita total de um álbum
DELIMITER //
CREATE FUNCTION ReceitaAlbum(album_id INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE receita DECIMAL(10,2);
    SELECT SUM(quantidade * preco_unitario) INTO receita
    FROM Vendas
    WHERE id_album = album_id;
    RETURN receita;
END //
DELIMITER ;

-- ========================
-- 6. STORED PROCEDURES
-- ========================
-- Procedure para ordenação de tabelas
DELIMITER //
CREATE PROCEDURE OrdenarTabela(tabela VARCHAR(50), campo VARCHAR(50), ordem VARCHAR(4))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tabela, ' ORDER BY ', campo, ' ', ordem);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

-- Procedure para inserir novo artista
DELIMITER //
CREATE PROCEDURE InserirArtista(nome VARCHAR(100), genero VARCHAR(50), nacionalidade VARCHAR(50))
BEGIN
    INSERT INTO Artistas (nome, genero_musical, nacionalidade)
    VALUES (nome, genero, nacionalidade);
END //
DELIMITER ;

-- ========================
-- 7. TRIGGERS
-- ========================
-- Trigger BEFORE INSERT em Vendas
DELIMITER //
CREATE TRIGGER BeforeInsertVendas
BEFORE INSERT ON Vendas
FOR EACH ROW
BEGIN
    INSERT INTO Logs (tabela, operacao, usuario, data_hora)
    VALUES ('Vendas', 'INSERT', USER(), NOW());
END //
DELIMITER ;

-- Trigger AFTER DELETE em Artistas
DELIMITER //
CREATE TRIGGER AfterDeleteArtistas
AFTER DELETE ON Artistas
FOR EACH ROW
BEGIN
    INSERT INTO Logs (tabela, operacao, usuario, data_hora)
    VALUES ('Artistas', 'DELETE', USER(), NOW());
END //
DELIMITER ;