--Treinando SQL 2
--usando VSCode e extensão SQLite-dataset-olist
--fonte: canal TeoMeWhy https://www.youtube.com/watch?v=PXftBr56Tow&t=1693s

--básico:
--seleciona todas as colunas da tabela tb_orders
select *
from tb_products 
limit 10

--seleciona as categorias e coloca em ordem decrescente (sem repetir a ocorrência = distinct)
select 
      distinct product_category_name
from tb_products
order by product_category_name desc

--se a categoria tiver valor nulo preencher com outros
--senão preencher com o próprio nóme da categoria
select 
      distinct case when product_category_name is null then 'outros'
               else product_category_name
               end as categorias
from tb_products
order by categorias

--outro exemplo, usando várias formas:
select 
      distinct case when product_category_name is null then 'outros'
                    when product_category_name = 'alimentos' 
                        or product_category_name = 'alimentos_bebidas' then 'alimentos'
                    when product_category_name in ('artes', 'artes_e_artesanato') then 'artes'
                    when product_category_name like "%artigos" then "artigos"
                    else product_category_name
                end as categoria_fillna
from tb_products
order by categoria_fillna


--COALESCE (exemplo sem coalesce)
select distinct 
    case when product_category_name is null then 'outros'
    else product_category_name
    end as categoria_fillna
from tb_products
order by product_category_name

--COALESCE (exemplo com coalesce)
--COALESCE substitui o que é nulo na coluna product_category_name por 'outros'
select distinct 
    coalesce(product_category_name, 'outros') as categoria_fillna
from tb_products
order by product_category_name
--limit 10


--USANDO JOIN
--JOIN LEFT
--exemplo: QUAL A RECEITA DE CADA CATEGORIA DE PRODUTO?
--E O TOTAL DE VENDAS? EM UNIDADES E PEDIDOS?

select *
from tb_order_items as t1
left join tb_products as t2
on t1.product_id = t2.product_id
limit 5
--une tabela order_items com tb produtos (mantendo t1 à esquerda)

--QUAL O VALOR TOTAL DA RECEITA GERADA POR CLIENTES DE CADA ESTADO?
select t2.customer_state,
       sum(t3.price) / count(distinct t1.customer_id) as avg_receita_cliente,
       sum(t3.price) as receita_total_estado
from tb_orders as t1

left join tb_customers as t2
on t1.customer_id = t2.customer_id

left join tb_order_items as t3
on t1.order_id = t3.order_id

where t1.order_status = 'delivered'
group by t2.customer_state

--QUAL O VALOR TOTAL DE RECEITA GERADA POR SELLERS DE CADA ESTADO?
--CONSIDERE APENAS PEDIDOS ENTREGUES.

select t3.seller_state,
       sum(t2.price) as receita_total       
from tb_orders as t1

left join tb_order_items as t2
on t1.order_id = t2.order_id

left join tb_sellers as t3
on t2.seller_id = t3.seller_id

where t1.order_status = 'delivered'
group by t3.seller_state
