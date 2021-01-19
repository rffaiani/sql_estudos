--Treinando SQL 1
--usando VSCode e extensão SQLite-dataset-olist
--fonte: canal TeoMeWhy https://www.youtube.com/watch?v=PXftBr56Tow&t=1693s

--seleciona todas as colunas da tabela tb_orders
select *
from tb_orders

--seleciona todas as colunas de tb_orders (só trazendo 5 ocorrências)
select *
from tb_orders
limit 5

--colunas da tabela tb_orders:
--seller_id	
--seller_zip_code_prefix	
--seller_city	
--seller_state

select *
from tb_sellers
limit 5

--seleciona apenas as colunas id e state de tb_sellers
select seller_id,
       seller_state
from tb_sellers

--selecionando toda a tabela de produtos
select *
from tb_products

--colunas da tabela produtos
--product_id	
--product_category_name	
--product_name_lenght	
--product_description_lenght	
--product_photos_qty	
--product_weight_g	
--product_length_cm	
--product_height_cm	
--product_width_cm

--selecionado apenas algumas colunas
select product_id, product_category_name, product_photos_qty
from tb_products
limit 5

--usando o WHERE (para filtrar categorias)
select product_id, product_category_name, product_photos_qty
from tb_products
where product_category_name = 'bebes'
--limit 5

--filtrando apenas categoria bebes com produtos que tenham mais que 1 foto
select product_id, product_category_name, product_photos_qty
from tb_products
where product_category_name = 'bebes'
and product_photos_qty > 1

select product_id, product_category_name, product_photos_qty
from tb_products
where (product_category_name = 'bebes'
       or product_category_name = 'perfumaria')
and product_photos_qty > 1

--usando apelido AS
--usando COUNT
--(usa-se o count para responder a pergunta QUANTOS?
--ex: QUANTOS PRODUTOS TEMOS DA CATEGORIA ARTES?

select count(*) as qtde_linhas
from tb_products as t1
where t1.product_category_name = 'artes'
--resposta: 55

--usando DISTINCT (exemplo: ao puxar por id, desconsidera a contagem caso outra linha possua o mesmo id)
--CONTAR QTDE DE LINHAS, QTDE DE PRODUTOS DISTINTOS PELO ID E QTDE PRODUTOS DISTINTOS POR CATEGORIA
select count(*) as qtde_linhas,
       count(product_id) as qtde_produtos,
       count(distinct product_id) as qtde_produtos_distintos,
       count(distinct product_category_name) as qtde_categorias_distintas
from tb_products
where product_category_name = 'artes'

--QTOS PRODUTOS DE "BELEZ-SAUDE" COM MAIS DE 1 LITRO?
--product_length_cm	
--product_height_cm	
--product_width_cm

select count(*) as qtde_linhas
from tb_products
where product_category_name = 'beleza_saude'
and product_length_cm	 * product_height_cm * product_width_cm / 1000 > 1
--resposta: 2311

--usando MAX, MIN, AVG (máximo, mínimo, média)
select max(product_weight_g) as maior_peso,
       min(product_weight_g) as menor_peso,
       avg(product_weight_g) as media_peso
from tb_products
where product_category_name = 'artes'
--exemplo acima trouxe apenas categoria artes
--para sabermos de todas as categorias
--precisamos agrupar por categoria.
--para isso...

--usando GROUP BY
--e adicionando coluna nova com a qtde de produtos que categpria tem.
select product_category_name,
       count(*) as qtde_produtos,
       max(product_weight_g) as maior_peso,
       min(product_weight_g) as menor_peso,
       avg(product_weight_g) as media_peso
from tb_products
where product_category_name is not null
group by product_category_name
--limit 10

--usando IN
--filtrar apenas qtde vendedores nos estados de SP, RJ e PR.

select *
from tb_sellers
limit 5

--colunas da tabela tb_sellers
--seller_id	
--seller_zip_code_prefix	
--seller_city	
--seller_state

select seller_state,
       count(*) as qtde_vendedores
from tb_sellers
where seller_state IN ('SP','RJ','PR')
group by seller_state

--usando HAVING
--Filtrar estados que tenham mais que 200 vendedores usando filtro (SP/RJ/PR)
--note que o RJ vai ficar fora, pois tem menos que 200 vendedores.

select seller_state,
       count(*) as qtde_vendedores
from tb_sellers
where seller_state IN ('SP', 'RJ', 'PR')
group by seller_state
having count(*) > 200

--BASICAMENTE:
--WHERE - filtro usado antes da agregação (group by)
--GROUP BY --agregação
--HAVING -- filtro usando depois da agregação.


--Até agora foi visto:
--SELECT 
--FROM
--AS
-- WHERE --AND --OR --IN
--GROUP BY
--HAVING
--LIMIT

--PARTE 1 FINALIZADA--
