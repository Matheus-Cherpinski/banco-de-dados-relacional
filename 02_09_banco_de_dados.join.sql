CREATE DATABASE loja_aula;

USE loja_aula;

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT,
    id_categoria INT,

    FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    data_cadastro DATE
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATE,
    id_cliente INT,

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto)
);

/*INSERINDO DADOS*/

INSERT INTO categoria (nome) VALUES
('Informática'),
('Acessórios'),
('Escritório'),
('Games'),
('Celulares'),
('Eletrônicos');

INSERT INTO produto (nome, preco, estoque, id_categoria) VALUES
('Notebook Lenovo', 3500.00, 10, 1),
('Mouse Logitech', 120.00, 30, 2),
('Teclado Mecânico', 280.00, 20, 2),
('Monitor 24', 950.00, 15, 1),
('Cadeira Gamer', 1250.00, 8, 4),
('Mouse Pad', 45.00, 50, 2),
('Caneta Azul', 3.50, 100, 3),
('Caderno Executivo', 35.00, 40, 3),
('Smartphone Samsung', 2200.00, 12, 5),
('Controle Gamer', 350.00, 25, 4);

INSERT INTO produto (nome, preco, estoque, id_categoria) VALUES
('Notebook Lenovo', 3500.00, 10, 1),
('Mouse Logitech', 120.00, 30, 2),
('Teclado Mecânico', 280.00, 20, 2),
('Monitor 24', 950.00, 15, 1),
('Cadeira Gamer', 1250.00, 8, 4),
('Mouse Pad', 45.00, 50, 2),
('Caneta Azul', 3.50, 100, 3),
('Caderno Executivo', 35.00, 40, 3),
('Smartphone Samsung', 2200.00, 12, 5),
('Controle Gamer', 350.00, 25, 4);

INSERT INTO cliente (nome, cidade, data_cadastro) VALUES
('Ana Silva', 'São Paulo', '2025-02-10'),
('Bruno Costa', 'Campinas', '2025-04-15'),
('Carlos Oliveira', 'Registro', '2025-05-20'),
('Amanda Souza', 'São Paulo', '2025-07-01'),
('Mariana Santos', 'Santos', '2024-11-25'),
('Pedro Lima', 'Campinas', '2026-01-10');

INSERT INTO pedido (data_pedido, id_cliente) VALUES
('2026-08-01', 1),
('2026-08-02', 2),
('2026-08-03', 1),
('2026-08-04', 3),
('2026-08-05', 4),
('2026-08-06', 5);

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 3500.00),
(1, 2, 2, 120.00),
(2, 3, 1, 280.00),
(2, 6, 3, 45.00),
(3, 4, 2, 950.00),
(3, 2, 1, 120.00),
(4, 7, 10, 3.50),
(4, 8, 3, 35.00),
(5, 5, 1, 1250.00),
(5, 10, 2, 350.00),

(6, 9, 1, 2200.00),
(6, 6, 2, 45.00);

/*Consultas no banco de dados*/
/*Listagem de produtos*/
select * from produto;

/*Listagem com campos especificos*/

select nome, preco from produto;

/*Listagem co condição - o gerente quer descobrir os produtos que custam mais de R$500,00*/
select nome, preco from produto where preco > 500;

/*Order by - ordenação dos dados decrescente (do maior para o menor)*/
select nome, preco from produto where preco > 500 order by preco desc;

/*Order by - ordenação dos dados ascendente (do menor para o maior)*/
select nome, preco from produto where preco > 500 order by preco asc;
#ou assim
select nome, preco from produto where preco > 500 order by preco ;
/*Between - Quais os produto que custam entre R$ 100 e R$ 1000*/
select nome, preco from produto where preco between 100 and 1000 order by preco;

/**IN - A empresa realizará uma campanha somente em São paulo e Campinas.
Quais clientes pertencem a essas cidades?/*/
select nome, cidade from cliente where cidade in ('são paulo', 'campinas');
select * from cliente;

#ou assim menos elegante
select nome, cidade from cliente where cidade = 'são paulo' or cidade='campinas';

/*Like*/
select nome from cliente where nome like "a%";
select nome from cliente where nome like "%silva%";

/*Combinando Filtros*/
/*Problema: Precisamos encontrar clientes de são paulo ou campinas , cujo o nome começe com a letra a*/
select nome, cidade from cliente where cidade in ("são paulo", "campinas") and nome like "a%";

/*count - Quantos produtos existem na loja?*/

select count(*) as total_produtos from produto;
/*Apelido de campo, todo campo ao ser utilizado as apelido_campo recebe o apelido de referencia ao campo, mudando ssim o titulo da coluna da tabela resultado temporariamente*/

select count(nome) from produto;
#ou assim
select count(*) as "total de produtos" from produto;

/*AVG - qual é o preço medio dos produtos*/
select avg(preco) as "Valor médio dos produtos" from produto;
/*Preço medi ocategoria especifica*/
select avg(preco) as "valor produto" from produto where id_categoria = 1;
/*Arredondar casas decimais*/
select round(avg(preco)) as "valor médio" from produto;

/*min e max - qual o produto mais caro e o mais barato dos produtos*/
select min(preco) as "menor preço", max(preco) as "maior valor" from produto;

/*Varias funções de agregação*/
select 
count(*) as "Quantidade de produtos",
round(avg(preco),2) as "preço Médio",
min(preco) as "menor preço", max(preco) as "maior preço" from produto;

/*SUM - qual o valor financeiro aproximado do estoque da loja?*/
select sum(preco) as "total Aproximado Estoque" from produto;
select sum(preco * estoque) as "total Aproximado Estoque" from produto;

/*Agrupamento de valores - grup by ()*/

select id_categoria, round (avg(preco), 2) as "preço medio" from produto group by id_categoria;

#ou assim trazendo o nome da categoria

select produto.id_categoria as "ID", categoria.nome as "categoria", round (avg(preco),2) as "preço médio" from produto
inner join categoria on categoria.id_categoria = produto.id_categoria
group by produto.id_categoria;

select produto.id_categoria as "ID", categoria.nome as "categoria", round (avg(preco),2) as "preço médio" from produto
inner join categoria using (id_categoria)
group by produto.id_categoria order by "ID";

/*Having - Quais categorias possuem preco maior que R$500,00*/
select id_categoria, round(avg(preco), 2) as "preco medio" from produto
group by id_categoria having avg(preco) > 500;

/*Inner join*/

select p.nome as "produto", c.nome as "categoria", p.preco as "valor" from produto p 
join categoria c on p.id_categoria = c.id_categoria;


select p.nome as "produto", c.nome as "categoria", p.preco as "valor" from produto p 
join categoria c using (id_categoria);

/*Group by + inner join - Quantos produtos existem em cada categoria*/
select c.nome as "categoria", count(p.id_produto) as Quantidade from categoria c
join produto p on c.id_categoria = p.id_categoria group by c.nome;

/*Left join*/
select c.nome as "categoria", p.nome as "produto" 
from categoria c left join produto p
on c.id_categoria = p.id_categoria;

/*Quais clientes estã ocadastrados, mas nunca compraram*/
select c.nome as "cliente" from cliente c left join pedido p
 on c.id_cliente = p.id_cliente where p.id_pedido is null;
 
 /*Quem comprou e em qual pedido comprou?**/
 select c.nome as "cliente", p.id_pedido, p.data_pedido from cliente c
 join pedido p on c.id_cliente = p.id_cliente order by p.data_pedido;
 
 #subconsultas
 select nome, preco from produto where preco > (select avg(preco) from produto);
 
 /*Nesse exemplo, a subconsulta calcula o preco médio e a consulta externa retorna os produtos acima dessa media*/
 
 #subconsultas com listas e existencias
 /*Quando a subconsulta retorna vários valoresm usam-se os operadores IN, EXISTS, ANY E ALL. o in VERIFICA SE UM VALOR PERTENCE AO CONJULTO RETORNADO
 o EXISTS testa apenas se a subconsulta produz alguma linha sendo bastante eficiente para verificar existência. O exemplo busc clientes que fizeram ao menos um pedido*/
 
 select nome from cliente c where exists
 (select 1 from pedido p where p.id_cliente = c.id_cliente);
 
 #consulta no from e no select
 /*A subconsulta também pode aparecer na cláusula FROM,
 funcionanod como uma tabela temporária, ou nalista de colunas do SELECT, retornando um valor único por linha. 
 O exemplo a seguir mostra cada categoria ao lado da quantidade de produtos calculada por uma subconsulta no SELECT: */
 
 select c.nome,(select count(*) from produto p where p.id_categoria = c.id_categoria) as "Quantidade de Produtos" from categoria c; 
 
 # Organizando com CTEs e combinando com Union
 /*Consultas longas tornam-se difíceis de ler quando muitas subconsultas se aninham.
 A common Table Expression (CTE) introduzida pela cláusula WITH, da nome a um resultado intermediario e melhora a clareza.
 ELa é especialmente útil quando o mesmo sobreresultado é rederenciado mais de uma vez*/
 
 with faturamento_cliente as (
 select p.id_cliente, sum(ip.quantidade * ip.preco) as "total" from pedido p
 join item_pedido ip on p.id_pedido = ip.id_pedido
 group by p.id_cliente)
 select c.nome, f.total from faturamento_cliente f
 join cliente c on c.id.cliente = f.id_cliente
 where f.total > 500;
 
 # funções internas
 /*OS SGBDs oferecem um conjunto amplo de funções internas que processam valores durante a consulta. As funcções de texto manipulam cadeias de caracteres.
 CONCAT junta stings, UPPER e LOWER slteram a caixa, SUBSTRING extrai um trecho, LENGHT mede o comprimento e TRIM remove os espaços nas extremidades. */
 select concat(nome, '(', cidade,')')as "identificação", upper(cidade) as "cidade em Maiusculo" from cliente;
 
 #Função interna d edata
 /*As funções de data permitem extrair e calcular informações temporais. 
 NOW retorna o instante atual, DATEDIFF calcula a diferença entre datas e funções de formatação ajustam a exibição.
 O exemplo apura há quantos dias cada cliente está cadastrado*/
 select nome, datediff(current_date,data_cadastro) as "dias de Cadastro" from cliente;
 
 #funções numéricas e condicionais
/*As funções numéricas arredondam e ajustam valores:
ROUND arredonda, FLOOR e CEIL aproximam oara baixo e para cima.
Já as funções condicionais decidem o valor de saída conforme uma regra.altero comando CASE funciona como uma estrutura de decisão dentro da consulta, e COALESCE substitui valores nulos por uma alternativa*/

select nome, preco,
case 
when preco >= 500 then "Premium"
when preco >= 100 then "Intermediário"
else "Econômico"
end as "faixa",
coalesce(id_categoria,0) as "Categoria Segura"
from produto;

#Visões - o que são visões?"
/*Uma visão, ou view, é uma consulta armazenada que se comporta como um atabela virtual.
 Ela não guarda dados próprios, mas sim a definição de um SELECT que é executado sempre que a visão é consultada.
 Silberschatz e colaboradores destacam que visões cumprem dois papéis centrais: simplificar consultas complexas e controlar o que cada usuário pode enxergar*/
 
 create view vw_produtos_categoria as
 select p.id_produto, p.nome as "produto",
 p.preco, c.nome as "categoria" from produto p
 join categoria c on p.id_categoria = c.id_categoria;

/*Depois de criada, a visão é consultada como se fosse uma tabela comum, 
o que dispensa repetir a junção a cada uso:*/
select*FROM vw_produtos_categoria WHERE preco > 200;
#Visões como camada de segurança
/*Além de simplificar, as visões protegem dados.
É possivel expor apenas algumas colunas de uma tabela, escondendo informações sensiveis. Uma visão que mosrea clientes sem revear o email, por exemplo, permite que relatorios sejam gerados sem dar acesso ao dado privado.
A cláudula WITH CHECK POINT, por sua vez, impede que atualizações feitas atrravés da sua visão violem a codição que a define.
*/

create view vw_cliente_publico as
select id_cliente, nome, cidade from cliente;

select * from vw_cliente_publico;