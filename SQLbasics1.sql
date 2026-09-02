-- -- DRILLS SQL -- --
-- BLOQUE 1, Base --
SELECT count(*) FROM pagos

PRAGMA table_info(pagos);

-- reto 1
SELECT COUNT(*), COUNT(DISTINCT p.pago_id)
FROM clientes c
JOIN prestamos pr ON c.cliente_id = pr.cliente_id
JOIN pagos p ON pr.prestamo_id = p.prestamo_id;

SELECT COUNT(*)
FROM clientes c
JOIN prestamos pr ON c.cliente_id = pr.cliente_id
JOIN pagos p ON pr.prestamo_id = p.prestamo_id;

SELECT c.segmento, SUM(p.monto_pagado)
FROM clientes c
JOIN prestamos pr ON c.cliente_id = pr.cliente_id
JOIN pagos p ON pr.prestamo_id = p.prestamo_id
GROUP BY c.segmento;

SELECT pago_id, prestamo_id, fecha_pago, monto_esperado, monto_pagado
FROM pagos
WHERE prestamo_id = (
    SELECT prestamo_id
    FROM pagos
    GROUP BY prestamo_id
    HAVING COUNT(*) > 1
    LIMIT 1
)
ORDER BY fecha_pago;

SELECT * 
FROM clientes c
GROUP BY segmento as cliseg
ORDER BY cliseg DESC;

SELECT c.segmento,
       '$' || REPLACE(printf('%,d', SUM(p.monto_pagado)), ',', '.') AS total_pagado
FROM clientes c
JOIN prestamos pr ON c.cliente_id = pr.cliente_id
JOIN pagos p ON pr.prestamo_id = p.prestamo_id
GROUP BY c.segmento;

SELECT c.segmento,
       '$' || REPLACE(printf('%,d', SUM(pr.monto_desembolsado)), ',', '.') AS desembolsado_correcto
FROM clientes c
JOIN prestamos pr ON c.cliente_id = pr.cliente_id
GROUP BY c.segmento;

SELECT c.segmento, SUM(pr.monto_desembolsado) AS desembolsado_correcto
FROM clientes c
JOIN prestamos pr ON c.cliente_id = pr.cliente_id
GROUP BY c.segmento;

SELECT c.segmento,
       '$' || REPLACE(printf('%,d', SUM(pr.monto_desembolsado)), ',', '.') AS desembolsado_inflado
FROM clientes c
JOIN prestamos pr ON c.cliente_id = pr.cliente_id
JOIN pagos p ON pr.prestamo_id = p.prestamo_id
GROUP BY c.segmento;

SELECT c.segmento, SUM(pr.monto_desembolsado) AS desembolsado_inflado
FROM clientes c
JOIN prestamos pr ON c.cliente_id = pr.cliente_id
JOIN pagos p ON pr.prestamo_id = p.prestamo_id
GROUP BY c.segmento;


SELECT segmento, COUNT (*) AS cliXseg 
FROM clientes

-- reto 2
SELECT ciudad, COUNT(*) AS clieXcity, 
       '$' || REPLACE(printf('%,d', ROUND(AVG(ingreso_mensual),0)), ',', '.') AS PromIngrMes
FROM clientes
GROUP BY ciudad
HAVING clieXcity > 100;

-- reto 3
SELECT producto, monto_desembolsado, estado 
FROM prestamos
ORDER BY monto_desembolsado DESC
LIMIT 10;

--reto 4
SELECT COUNT(*) FROM clientes;

SELECT COUNT(ingreso_mensual) FROM clientes;

SELECT
  COUNT(*) AS total,
  COUNT(ingreso_mensual) AS no_null,
  SUM(CASE WHEN ingreso_mensual IS NULL THEN 1 ELSE 0 END) AS son_null,
  SUM(CASE WHEN ingreso_mensual = 0 THEN 1 ELSE 0 END) AS son_cero
FROM clientes;

-- BLOQUE 2. Joins y la trampa del LEFT JOIN --
-- reto 5
SELECT 
  c.segmento,
  COUNT(pr.prestamo_id) AS cantidad_préstamos, 
  SUM(CASE WHEN c.cliente_id IS NULL THEN 1 ELSE 0 END) AS prest_sin_clie
FROM prestamos pr
LEFT JOIN clientes c ON pr.cliente_id = c.cliente_id
GROUP BY c.segmento;

SELECT COUNT(*) FROM prestamos;

SELECT c.segmento, COUNT(pr.prestamo_id) AS cantidad_préstamos
FROM prestamos pr
LEFT JOIN clientes c ON pr.cliente_id = c.cliente_id
GROUP BY c.segmento;

-- reto 6
SELECT 
  COUNT(CASE WHEN pr.cliente_id NOT EXISTS THEN 1 ELSE 0 END) AS clie_sin_préstamos
FROM clientes c
LEFT JOIN prestamos pr ON c.cliente_id = pr.cliente_id;

SELECT c.cliente_id
WHERE pr.prestamo_id IS NULL
FROM clientes c
LEFT JOIN prestamos pr ON c.cliente_id = pr.cliente_id;

SELECT c.cliente_id
FROM clientes c
LEFT JOIN prestamos pr ON c.cliente_id = pr.cliente_id
WHERE pr.prestamo_id IS NULL;

SELECT COUNT(c.cliente_id) AS clie_sin_préstamos
FROM clientes c
WHERE NOT EXISTS (SELECT 1 FROM prestamos pr WHERE pr.cliente_id = c.cliente_id);

SELECT c.cliente_id
FROM clientes c
WHERE NOT EXISTS (SELECT 1 FROM prestamos pr WHERE pr.cliente_id = c.cliente_id);

-- reto 7
SELECT estado, COUNT(estado) AS Tipos_Est
from prestamos
GROUP by estado
order by Tipos_Est DESC;


SELECT c.segmento, COUNT(p.prestamo_id) AS n_prestamos
FROM clientes c
LEFT JOIN prestamos p ON c.cliente_id = p.cliente_id
WHERE p.estado = 'Vigente'
GROUP BY c.segmento;

--solución 1
SELECT c.segmento, COUNT(p.prestamo_id) AS n_prestamos
FROM clientes c
FULL OUTER JOIN prestamos p ON c.cliente_id = p.cliente_id
WHERE p.estado = 'Vigente'
GROUP BY c.segmento
ORDER BY n_prestamos DESC;

--solución 2
SELECT c.segmento, COUNT(p.prestamo_id) AS n_prestamos
FROM prestamos p
LEFT JOIN clientes c ON c.cliente_id = p.cliente_id
WHERE p.estado = 'Vigente'
GROUP BY c.segmento
ORDER BY n_prestamos DESC;

-- BLOQUE 3. Agregación de negocio --
--Reto 8



