USE pizzaria;
SHOW TABLES;

-- A Quantas tabelas o banco de dados possui?
SELECT COUNT(*) AS quantidade_tabelas
FROM information_schema.tables
WHERE table_schema = 'pizzaria';

--B Quantos Clientes cadastrados?
SELECT COUNT(*) AS quantidade_clientes
FROM clientes;

--C Quantas pizzas Cadastradas?
SELECT COUNT(*) AS quantidade_pizzas
FROM pizzas;

--D Quantas pizzas o pedido nº 3 possui?
SELECT SUM(quantidade) AS total_pizzas
FROM itens_pedido
WHERE pedido_id = 3;

--E Qual nome do cliente que fez o pedido nº 3?
SELECT * FROM Clientes WHERE cliente_id = 3;

--F Quais os nomes das pizzas do pedido nº 3?
SELECT pizzas.nome
FROM pizzas
JOIN itens_pedido
ON pizzas.pizza_id = itens_pedido.pizza_id
WHERE itens_pedido.pedido_id = 3;

--DML - Manipulando Dados

insert into clientes (
    nome, logradouro, numero, bairro, referencia, telefone
) values (
    'Gaspar Oliveira',
    'Rua Lizandro Silva',
    21,
    'São Dimas',
    'Ao lado da igrejinha',
    '19 99898-1141'
);

insert into pedidos (cliente_id) values (10);

insert into Itens_Pedido (pedido_id, pizza_id, quantidade) values (15, 1, 1), (15, 2, 2);

insert into pizzas (
    nome,
    descricao,
    valor
) values (
    'a moda do chef',
    'molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas',
    41.90
);


insert into pedidos (cliente_id)
select cliente_id
from clientes
where nome = 'gaspar oliveira';



insert into itens_pedido (
    pedido_id,
    pizza_id,
    quantidade
)
select
    (select max(pedido_id) from pedidos),
    pizza_id,
    2
from pizzas
where nome = 'a moda do chef';


update itens_pedido
set quantidade = 3
where pedido_id = (
    select max(pedido_id) from pedidos
)
and pizza_id = (
    select pizza_id
    from pizzas
    where nome = 'a moda do chef'
);


insert into itens_pedido (
    pedido_id,
    pizza_id,
    quantidade
)
select
    (select max(pedido_id) from pedidos),
    pizza_id,
    1
from pizzas
where nome = 'margherita';

-- Verificando

select * from clientes
where nome like '%Gaspar%';

select * from pizzas
where nome like '%chef%';