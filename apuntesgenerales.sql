-- ============================================================
-- 🧠 RESUMEN COMPLETO DE COMANDOS SQL + TIPOS DE DATOS
-- Comandos sin comentar | Explicaciones solo en comentarios
-- ============================================================


-- ============================================================
-- 🔹 COMANDOS SQL (EXPLICACIÓN ARRIBA, COMANDO DEBAJO)
-- ============================================================

-- Crea una base de datos
CREATE DATABASE;

-- Conectarse a una base de datos
\c;

-- Crea una tabla
CREATE TABLE;

-- Clave primaria
PRIMARY KEY;

-- Clave foránea
FOREIGN KEY;

-- Actualización en cascada
ON UPDATE CASCADE;

-- Si se borra el dato referenciado → poner NULL
ON DELETE SET NULL;

-- Si se borra el dato referenciado → borrar también los hijos
ON DELETE CASCADE;

-- Valor obligatorio (no puede ser NULL)
NOT NULL;

-- Valor único (no repetido)
UNIQUE;

-- Condición obligatoria para los valores
CHECK;

-- Valor por defecto
DEFAULT;

-- Insertar datos
INSERT INTO;

-- Consultar datos
SELECT;

-- Modificar datos existentes
UPDATE;

-- Eliminar filas
DELETE;

-- Combinar tablas relacionadas
JOIN;
INNER JOIN;
LEFT JOIN;
RIGHT JOIN;
FULL JOIN;

-- Mostrar tablas
\dt;

-- Mostrar estructura de tabla
\d;

-- Lista todas las bases de datos
\l;

-- Salir de psql
\q;


-- ============================================================
-- 🔹 TIPOS DE DATOS (EXPLICACIÓN ARRIBA, TIPO DEBAJO)
-- ============================================================

-- Texto con límite de caracteres
VARCHAR;

-- Texto de longitud fija
CHAR;

-- Texto largo sin límite
TEXT;

-- Número entero
INTEGER;
INT;

-- Número entero que se autoincrementa
SERIAL;

-- Entero pequeño
SMALLINT;

-- Entero grande
BIGINT;

-- Número con decimales exactos
NUMERIC;

-- Decimales aproximados
REAL;
DOUBLE PRECISION;

-- Verdadero / Falso
BOOLEAN;

-- Fecha (YYYY-MM-DD)
DATE;

-- Hora (HH:MM:SS)
TIME;

-- Fecha + hora
TIMESTAMP;

-- Intervalos de tiempo
INTERVAL;


-- ============================================================
-- 🔹 CONCEPTOS IMPORTANTES (SOLO COMENTARIOS)
-- ============================================================

-- Integridad referencial:
-- Garantiza que las relaciones entre tablas sean válidas usando claves foráneas.

-- Normalización:
-- Organización correcta de datos para evitar duplicados.

-- Cascada:
-- Permite que cambios o borrados se propaguen automáticamente a tablas relacionadas.

-- Restricciones:
-- Reglas aplicadas a columnas para asegurar la calidad de los datos.


-- ============================================================
-- 🧾 Fin del archivo de resumen SQL
-- ============================================================
