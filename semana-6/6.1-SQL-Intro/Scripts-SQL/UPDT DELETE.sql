SELECT * from clientes;
UPDATE clientes
SET provincia = 'Asturias'
WHERE idclientes = 1;

DELETE FROM clientes
WHERE nombre='Daniel';

SET SQL_SAFE_UPDATES = 0;