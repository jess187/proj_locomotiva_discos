
-- Criação do primeiro usuário com permissões apenas de leitura
CREATE USER 'leitor_user'@'%' IDENTIFIED BY 'senha_leitor';
-- O comando acima cria um usuário chamado 'leitor_user' com acesso de qualquer host e a senha especificada.

GRANT SELECT ON locomotiva_discos.* TO 'leitor_user'@'%';
-- O comando acima concede permissão de leitura (SELECT) para todas as tabelas no banco de dados 'locomotiva_discos'.

-- Criação do segundo usuário com permissões de leitura, inserção e modificação de dados
CREATE USER 'editor_user'@'%' IDENTIFIED BY 'senha_editor';
-- O comando acima cria um usuário chamado 'editor_user' com acesso de qualquer host e a senha especificada.

GRANT SELECT, INSERT, UPDATE ON locomotiva_discos.* TO 'editor_user'@'%';
-- O comando acima concede permissões de leitura (SELECT), inserção (INSERT) e modificação (UPDATE) para todas as tabelas no banco de dados 'locomotiva_discos'.

-- Negando permissão de exclusão para ambos os usuários
REVOKE DELETE ON locomotiva_discos.* FROM 'leitor_user'@'%';
-- O comando acima garante que o usuário 'leitor_user' não possa excluir registros.

REVOKE DELETE ON locomotiva_discos.* FROM 'editor_user'@'%';
-- O comando acima garante que o usuário 'editor_user' não possa excluir registros.

-- Finalizando as permissões e aplicando as mudanças
FLUSH PRIVILEGES;
-- O comando acima recarrega todas as permissões para garantir que as mudanças sejam aplicadas imediatamente.
