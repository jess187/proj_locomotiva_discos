
-- Backup do Banco de Dados Locomotiva Discos
-- Tabelas incluídas no backup: vendas, clientes, estoque, discos, fornecedores

-- Dados da tabela vendas
INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES
(1, 1, '2024-01-01', 150.00),
(2, 2, '2024-01-02', 200.00);

-- Dados da tabela clientes
INSERT INTO clientes (cliente_id, nome, email, telefone) VALUES
(1, 'João Silva', 'joao@email.com', '123456789'),
(2, 'Maria Souza', 'maria@email.com', '987654321');

-- Dados da tabela estoque
INSERT INTO estoque (estoque_id, disco_id, quantidade, fornecedor_id) VALUES
(1, 1, 50, 1),
(2, 2, 30, 2);

-- Dados da tabela discos
INSERT INTO discos (disco_id, nome, artista, preco) VALUES
(1, 'Álbum A', 'Artista X', 50.00),
(2, 'Álbum B', 'Artista Y', 70.00);

-- Dados da tabela fornecedores
INSERT INTO fornecedores (fornecedor_id, nome, contato) VALUES
(1, 'Fornecedor A', 'fornecedorA@email.com'),
(2, 'Fornecedor B', 'fornecedorB@email.com');
