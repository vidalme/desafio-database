
## Resposta - Comandos para realização da tarefa

### 1. Cria tables
```SQL

CREATE TABLE price_changes (
    listing_id INT,
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    change_date DATE,
    details TEXT
);

CREATE TABLE build_area_used_area (
    listing_id INT,
    built_area DECIMAL(10, 2),
    used_area DECIMAL(10, 2),
);

CREATE TABLE detalhes (
    listing_id INT,
    details TEXT
);

```

### 2. Consulta 1

2.a Numero de imoveis que tiveram aumento de preço em 2016   
2.b aumento medio do percentual de preço/m2 desses imoveis

```SQL

-- filtra valores iniciais, valores que aumentaram em 2016 com tamanho superior a 200m
WITH price_increases AS (
    SELECT 
        pc.listing_id,
        (pc.new_price - pc.old_price) AS price_increase,
        bau.built_area,
        (pc.new_price / NULLIF(bau.built_area, 0)) AS new_price_per_sqm,
        (pc.old_price / NULLIF(bau.built_area, 0)) AS old_price_per_sqm
    FROM 
        price_changes pc
    JOIN 
        build_area_used_area bau ON pc.listing_id = bau.listing_id 
    WHERE 
        -- apenas os valores que aumentaram
        pc.new_price > pc.old_price                    
        -- apenas os aumentos de 2016 
        AND EXTRACT(YEAR FROM pc.change_date) = 2016
        -- apenas os que tem area superior a 200m 
        AND bau.built_area > 200                
)

SELECT 
    -- quantidade de imoveis que tiveram aumento em 2016
    COUNT(*) AS total_states_with_increase,  
    -- media do percentual de acrescimo do preço dos imoveis selecionados
    AVG((new_price_per_sqm - old_price_per_sqm) / NULLIF(old_price_per_sqm, 0) * 100) AS avg_percentual_increase
FROM 
    price_increases;

```


### 2. Consulta 2
2.c Numero de imoveis que tiveram decrescimo de preço em 2016  
2.d Redução média do percentual de preço/m2 desses imóveis.


```SQL
WITH price_decreases AS (
    SELECT 
        pc.listing_id,
        (pc.old_price - pc.new_price) AS price_decrease,
        bau.built_area,
        (pc.old_price / NULLIF(bau.built_area, 0)) AS old_price_per_sqm,
        (pc.new_price / NULLIF(bau.built_area, 0)) AS new_price_per_sqm
    FROM 
        price_changes pc
    JOIN 
        build_area_used_area bau ON pc.listing_id = bau.listing_id 
    WHERE 
        -- apenas os valores que diminuiram
        pc.new_price < pc.old_price
        -- apenas os decrescimos de 2016 
        AND EXTRACT(YEAR FROM pc.change_date) = 2016
        -- apenas os que tem area superior a 200m 
        AND bau.built_area > 200
)

SELECT 
    -- quantidade total de imoveis que tiveram descrescimo em 2016
    COUNT(*) AS total_states_with_decrease,
    -- media do percentual de descrescimo do preço dos imoveis selecionados
    AVG((old_price_per_sqm - new_price_per_sqm) / NULLIF(old_price_per_sqm, 0) * 100) AS avg_percentual_decrease
FROM 
    price_decreases;
```