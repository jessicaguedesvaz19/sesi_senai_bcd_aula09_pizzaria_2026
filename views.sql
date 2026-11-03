-- Relatório que mostra todos os pedidos e o nome de cada cliente
SELECT * FROM pedidos;
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;
-- Salvar a consulta como uma VIEW / Relatório
CREATE VIEW vw_pedidos1 AS
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;
-- Para ver o resultado
SELECT * FROM vw_pedidos1;


-- Desafio 1: Crie um relatório que mostre todos os pedidos, itens, nome dos - clientes e nome das pizzas.
SELECT pedidos.pedido_id, clientes.nome, pizzas.nome, itens_pedido.quantidade
FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
JOIN itens_pedido ON pedidos.pedido_id = itens_pedido.pedido_id
JOIN pizzas ON itens_pedido.pizza_id = pizzas.pizza_id;

-- Desafio 2: Acrescente uma coluna chamada subtotal que seja o calculo do preco - unitário da pizza vezes a quantidade
create view vw_relatorio_pedidos as
 SELECT 
    pedidos.pedido_id AS pedido,
    clientes.nome AS cliente,
    pizzas.nome AS pizza,
    itens_pedido.quantidade AS quantidade,
    pizzas.valor AS preco_unitario,
    (pizzas.valor * itens_pedido.quantidade) AS subtotal
FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
JOIN itens_pedido ON pedidos.pedido_id = itens_pedido.pedido_id
JOIN pizzas ON itens_pedido.pizza_id = pizzas.pizza_id;

SELECT * FROM vw_relatorio_pedidos;

-- Desafio 3: Agrupe os pedidos e calcule o valor total
create view vw_relatorio_pedidos_subtotal as 
SELECT
    pedidos.pedido_id AS pedido,
    SUM(pizzas.valor * itens_pedido.quantidade) AS valor_total
FROM pedidos
JOIN itens_pedido ON pedidos.pedido_id = itens_pedido.pedido_id
JOIN pizzas ON itens_pedido.pizza_id = pizzas.pizza_id
GROUP BY pedidos.pedido_id;

-- Desafio 4: Agrupe os pedidos e conte quantas pizzas cada pedido possui
create view vw_relatorio_pedidos_total as
SELECT
    pedido_id,
    SUM(quantidade) AS total_pizzas
FROM itens_pedido
GROUP BY pedido_id;