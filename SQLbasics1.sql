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


