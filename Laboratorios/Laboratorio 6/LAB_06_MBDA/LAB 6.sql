/*1. DTD Corregido y Ampliado  */

/*
<!ELEMENT detalle (producto+)>
<!ELEMENT producto (unidades, preciounitario, comentario?)>
<!ATTLIST producto 
    nombre CDATA #REQUIRED
    codigo CDATA #IMPLIED
>
<!ELEMENT unidades (#PCDATA)>
<!ELEMENT preciounitario (#PCDATA)>
<!ELEMENT comentario (#PCDATA)>
*/


/* 2. Inserción de Facturas */ 

-- Factura válida con DTD ampliado (OK)
DECLARE
   v_detalle_ok CLOB := 
   '<?xml version="1.0"?>
    <!DOCTYPE detalle SYSTEM "factura.dtd">
    <detalle>
        <producto nombre="P1" codigo="PROD-001">
            <unidades>3</unidades>
            <preciounitario>100.00</preciounitario>
            <comentario>Urgente para evento</comentario>
        </producto>
        <producto nombre="P2" codigo="PROD-002">
            <unidades>2</unidades>
            <preciounitario>200.00</preciounitario>
        </producto>
    </detalle>';
BEGIN
   INSERT INTO Factura (
       numero, fecha, entrega, unidades, 
       hora, detalle, total, boleta, estado, cedula_cliente
   ) VALUES (
       101, SYSDATE, SYSDATE + 5, 5,
       SYSTIMESTAMP, v_detalle_ok, 700.00, 'B2025', 'Pendiente', 1
   );
   COMMIT;
END;
/

-- Factura inválida (NoOK) - Falta atributo nombre
DECLARE
   v_detalle_nook CLOB := 
   '<?xml version="1.0"?>
    <detalle>
        <producto codigo="PROD-003">
            <unidades>1</unidades>
            <preciounitario>150.00</preciounitario>
        </producto>
    </detalle>';
BEGIN
   -- Bloque protegido para manejar error
   BEGIN
       INSERT INTO Factura (
           numero, fecha, entrega, unidades, 
           hora, detalle, total, boleta, estado, cedula_cliente
       ) VALUES (
           102, SYSDATE, SYSDATE + 3, 1,
           SYSTIMESTAMP, v_detalle_nook, 150.00, 'B2026', 'Pendiente', 2
       );
       COMMIT;
   EXCEPTION
       WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('Error al insertar factura inválida: ' || SQLERRM);
   END;
END;
/


/* 3. Consulta Productos Solicitados */

SELECT 
    f.numero AS factura_numero,
    f.boleta,
    TO_CHAR(f.fecha, 'DD/MM/YYYY') AS fecha_emision,
    x.nombre AS producto,
    x.codigo AS codigo_producto,
    x.unidades,
    x.preciounitario,
    ROUND(x.unidades * x.preciounitario, 2) AS subtotal,
    x.comentario
FROM 
    Factura f,
    XMLTABLE(
        '/detalle/producto'
        PASSING XMLTYPE(f.detalle)
        COLUMNS
            nombre VARCHAR2(50) PATH '@nombre',
            codigo VARCHAR2(20) PATH '@codigo',
            unidades NUMBER PATH 'unidades',
            preciounitario NUMBER PATH 'preciounitario',
            comentario VARCHAR2(200) PATH 'comentario'
    ) x
WHERE 
    f.estado = 'Pagado'
ORDER BY 
    f.fecha DESC, f.numero;


/* 4. Nueva Consulta: Resumen por Producto (Usando TDetalle) */

SELECT 
    x.nombre AS producto,
    NVL(x.codigo, 'SIN-CODIGO') AS codigo,
    SUM(x.unidades) AS total_unidades_vendidas,
    SUM(x.unidades * x.preciounitario) AS total_ventas,
    COUNT(DISTINCT f.numero) AS veces_solicitado
FROM 
    Factura f,
    XMLTABLE(
        '/detalle/producto'
        PASSING XMLTYPE(f.detalle)
        COLUMNS
            nombre VARCHAR2(50) PATH '@nombre',
            codigo VARCHAR2(20) PATH '@codigo',
            unidades NUMBER PATH 'unidades',
            preciounitario NUMBER PATH 'preciounitario'
    ) x
GROUP BY 
    x.nombre, x.codigo
HAVING 
    SUM(x.unidades) > 0
ORDER BY 
    total_ventas DESC;


/* 5. Extensión y Nueva Consulta con Datos Ampliados */

-- Insertar factura con datos extendidos
DECLARE
   v_detalle_ext CLOB := 
   '<?xml version="1.0"?>
    <!DOCTYPE detalle SYSTEM "factura.dtd">
    <detalle>
        <producto nombre="P3" codigo="PROD-003" tipo="Electrónico">
            <unidades>5</unidades>
            <preciounitario>300.00</preciounitario>
            <comentario>Cliente preferencial</comentario>
            <descuento>10</descuento>
        </producto>
    </detalle>';
BEGIN
   INSERT INTO Factura (
       numero, fecha, entrega, unidades, 
       hora, detalle, total, boleta, estado, cedula_cliente
   ) VALUES (
       103, SYSDATE, SYSDATE + 2, 5,
       SYSTIMESTAMP, v_detalle_ext, 1350.00, 'B2027', 'Pagado', 3
   );
   COMMIT;
END;
/

-- Consulta que aprovecha los nuevos campos
SELECT 
    f.numero AS factura,
    f.boleta,
    c.nombre AS cliente,
    x.nombre AS producto,
    x.tipo AS categoria,
    x.unidades,
    x.preciounitario,
    NVL(x.descuento, 0) AS descuento,
    ROUND(x.unidades * x.preciounitario * (1 - NVL(x.descuento, 0)/100, 2)) AS total,
    x.comentario
FROM 
    Factura f
JOIN 
    Cliente c ON f.cedula_cliente = c.cedula,
    XMLTABLE(
        '/detalle/producto'
        PASSING XMLTYPE(f.detalle)
        COLUMNS
            nombre VARCHAR2(50) PATH '@nombre',
            tipo VARCHAR2(30) PATH '@tipo',
            unidades NUMBER PATH 'unidades',
            preciounitario NUMBER PATH 'preciounitario',
            descuento NUMBER PATH 'descuento',
            comentario VARCHAR2(200) PATH 'comentario'
    ) x
WHERE 
    f.fecha BETWEEN TO_DATE('01/05/2025', 'DD/MM/YYYY') AND SYSDATE
ORDER BY 
    f.fecha DESC;



