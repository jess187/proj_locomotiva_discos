
-- Projeto Locomotiva Discos
-- Introdução
-- Este arquivo contém a estrutura e os dados do banco de dados relacional desenvolvido para o modelo de negócio Locomotiva Discos.

-- Objetivo
-- Criar e manter um banco de dados que represente a estrutura de um e-commerce de discos, permitindo consultas e relatórios gerenciais.

-- Tabelas
-- Tabela: artistas
CREATE TABLE artistas (
    id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    genero VARCHAR(100)
);

-- Tabela: albuns
CREATE TABLE albuns (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    ano INT,
    id_artista INT,
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista)
);

-- Tabela: vendas
CREATE TABLE vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_venda DATE,
    id_album INT,
    quantidade INT,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_album) REFERENCES albuns(id_album)
);

-- Inserção de dados
-- Tabela: artistas
INSERT INTO artistas (nome, genero) VALUES
('The Beatles', 'Rock'),
('Elis Regina', 'MPB'),
('Miles Davis', 'Jazz');

-- Tabela: albuns
INSERT INTO albuns (titulo, ano, id_artista) VALUES
('Abbey Road', 1969, 1),
('Falso Brilhante', 1976, 2),
('Kind of Blue', 1959, 3);

-- Tabela: vendas
INSERT INTO vendas (data_venda, id_album, quantidade, valor_total) VALUES
('2025-01-01', 1, 2, 159.98),
('2025-01-02', 2, 1, 79.99),
('2025-01-03', 3, 3, 239.97);

-- Consultas e relatórios
-- Relatório: Total de vendas por álbum
SELECT a.titulo, SUM(v.quantidade) AS total_vendido, SUM(v.valor_total) AS receita_total
FROM albuns a
JOIN vendas v ON a.id_album = v.id_album
GROUP BY a.titulo;

-- Relatório: Artistas e seus gêneros com o total de vendas
SELECT ar.nome, ar.genero, SUM(v.quantidade) AS total_vendas
FROM artistas ar
JOIN albuns al ON ar.id_artista = al.id_artista
JOIN vendas v ON al.id_album = v.id_album
GROUP BY ar.nome, ar.genero;
