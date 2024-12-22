
-- Stored Procedure 1: Ordenação dinâmica de uma tabela
DELIMITER $$
CREATE PROCEDURE OrdenarTabela (
    IN tableName VARCHAR(50),
    IN orderByColumn VARCHAR(50),
    IN orderDirection VARCHAR(10)
)
BEGIN
    -- Comando dinâmico para ordenar uma tabela baseada nos parâmetros
    SET @query = CONCAT('SELECT * FROM ', tableName, ' ORDER BY ', orderByColumn, ' ', orderDirection);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$
DELIMITER ;

-- Como usar:
-- CALL OrdenarTabela('Albums', 'release_year', 'ASC');
-- CALL OrdenarTabela('Employees', 'last_name', 'DESC');

-- Stored Procedure 2: Inserção ou Exclusão de registros
DELIMITER $$
CREATE PROCEDURE GerenciarRegistros (
    IN operationType VARCHAR(10), -- 'INSERT' ou 'DELETE'
    IN tableName VARCHAR(50),
    IN recordID INT, -- ID do registro a ser manipulado
    IN columnData JSON -- Dados no formato JSON para inserção
)
BEGIN
    IF operationType = 'INSERT' THEN
        -- Inserção de um novo registro
        SET @query = CONCAT(
            'INSERT INTO ', tableName, ' ',
            '(SELECT * FROM JSON_TABLE('', columnData, '', '$.*' COLUMNS (col1 VARCHAR(255) PATH '$.col1', col2 VARCHAR(255) PATH '$.col2'))) AS tmp'
        );
    ELSEIF operationType = 'DELETE' THEN
        -- Exclusão de um registro com base no ID
        SET @query = CONCAT('DELETE FROM ', tableName, ' WHERE id = ', recordID);
    END IF;

    -- Preparação e execução do comando dinâmico
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$
DELIMITER ;

-- Como usar:
-- Para Inserir:
-- CALL GerenciarRegistros('INSERT', 'Albums', NULL, '{"col1": "Title", "col2": "Artist"}');
-- Para Deletar:
-- CALL GerenciarRegistros('DELETE', 'Albums', 5, NULL);
