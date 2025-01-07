
-- Projeto Locomotiva Discos: Modificações e Transações

-- Primeira tabela: Operação de eliminação/inserção com transação
-- Tabela escolhida: clientes

-- Início da transação
START TRANSACTION;

-- Eliminando registros da tabela clientes (se aplicável)
DELETE FROM clientes WHERE cliente_id = 1;
DELETE FROM clientes WHERE cliente_id = 2;

-- Preparando as sentenças para reinserir os registros eliminados, caso necessário
-- INSERT INTO clientes (cliente_id, nome, email, telefone) VALUES (1, 'João Silva', 'joao@email.com', '123456789');
-- INSERT INTO clientes (cliente_id, nome, email, telefone) VALUES (2, 'Maria Santos', 'maria@email.com', '987654321');

-- Revertendo a transação
ROLLBACK;

-- Confirmando a transação
COMMIT;

-- Segunda tabela: Operação de inserção com transação e savepoints
-- Tabela escolhida: vendas

-- Início da transação
START TRANSACTION;

-- Inserindo 8 registros na tabela vendas
INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES (1, 1, '2025-01-01', 150.00);
INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES (2, 2, '2025-01-02', 200.00);
INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES (3, 1, '2025-01-03', 250.00);
INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES (4, 3, '2025-01-04', 300.00);

-- Savepoint após a inserção do registro #4
SAVEPOINT insercao_4;

INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES (5, 4, '2025-01-05', 350.00);
INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES (6, 2, '2025-01-06', 400.00);
INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES (7, 3, '2025-01-07', 450.00);
INSERT INTO vendas (venda_id, cliente_id, data_venda, valor_total) VALUES (8, 1, '2025-01-08', 500.00);

-- Savepoint após a inserção do registro #8
SAVEPOINT insercao_8;

-- Eliminando o savepoint dos primeiros 4 registros inseridos (opcional)
-- RELEASE SAVEPOINT insercao_4;

-- Revertendo toda a transação (opcional)
-- ROLLBACK;

-- Confirmando a transação
COMMIT;
