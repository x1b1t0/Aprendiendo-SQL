-- ===============================================================
-- 🧠 APUNTES DE SQL EN POSTGRESQL
-- Autor: x1b1t0
-- Descripción: Comandos usados en clase para practicar SQL dentro de un contenedor LXC.
-- ===============================================================

-- 🧩 1️⃣ Entrar al contenedor y al usuario correcto
-- Desde el host, arrancamos y accedemos al contenedor:

-- lxc start bddpSQL
-- lxc shell bddpSQL

-- Entramos como usuario postgres (necesario para usar psql):
-- su postgres

-- Iniciar cliente de PostgreSQL:
-- psql

-- ===============================================================

-- 🧩 2️⃣ Crear una nueva base de datos
CREATE DATABASE asix0610;

-- Conectarse a la nueva base de datos
\c asix0610

-- ===============================================================

-- 🧩 3️⃣ Crear la tabla "tutors"
-- Esta tabla guarda la información de los tutores.
CREATE TABLE tutors (
  dni VARCHAR(9) PRIMARY KEY,
  nom VARCHAR(20),
  apellido VARCHAR(20)
);

-- ✅ PRIMARY KEY → Identifica de forma única a cada tutor.
-- No puede haber dos DNIs iguales y no puede ser NULL.

-- ===============================================================

-- 🧩 4️⃣ Crear la tabla "bebes"
-- Esta tabla guarda los datos de los bebés y se relaciona con la tabla tutors.
CREATE TABLE bebes (
  id INTEGER PRIMARY KEY,
  nom VARCHAR(20),
  apellido VARCHAR(20),
  dni_tutor VARCHAR(9),
  CONSTRAINT notutor FOREIGN KEY (dni_tutor)
    REFERENCES tutors(dni)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

-- ✅ FOREIGN KEY → Crea una relación entre bebes y tutors.
-- ✅ ON UPDATE CASCADE → Si el DNI del tutor cambia, se actualiza también en bebes.
-- ✅ ON DELETE SET NULL → Si se borra el tutor, el campo dni_tutor queda a NULL.
-- Esto mantiene la integridad referencial entre las tablas.

-- ===============================================================

-- 🧩 5️⃣ Consultar las tablas creadas
-- Mostrar todas las tablas en la base de datos:
\dt

-- Mostrar la estructura de una tabla (columnas, tipos, claves):
\d tutors
\d bebes

-- ===============================================================

-- 🧩 6️⃣ Insertar datos en la tabla tutors
INSERT INTO tutors (dni, nom, apellido) VALUES ('84719263P', 'Lucía', 'Martínez');
INSERT INTO tutors (dni, nom, apellido) VALUES ('59102748R', 'Javier', 'Santos');
INSERT INTO tutors (dni, nom, apellido) VALUES ('78291045Q', 'María', 'Ruiz');

-- Verificar el contenido de la tabla
SELECT * FROM tutors;

-- ===============================================================

-- 🧩 7️⃣ Insertar datos en la tabla bebes (con clave foránea)
INSERT INTO bebes (id, nom, apellido, dni_tutor) VALUES (1, 'Sofía', 'Martínez', '84719263P');
INSERT INTO bebes (id, nom, apellido, dni_tutor) VALUES (2, 'Diego', 'Santos', '59102748R');
INSERT INTO bebes (id, nom, apellido, dni_tutor) VALUES (3, 'Hugo', 'Ruiz', '78291045Q');

-- Comprobar los datos insertados:
SELECT * FROM bebes;

-- ===============================================================

-- 🧩 8️⃣ Probar actualización en cascada
-- Si modificamos el DNI de un tutor, también cambiará en la tabla bebes.
UPDATE tutors SET dni = '84719263T' WHERE apellido = 'Martínez';

-- Comprobamos los resultados:
SELECT * FROM tutors;
SELECT * FROM bebes;

-- ✅ El campo dni_tutor de Sofía se actualiza automáticamente gracias al ON UPDATE CASCADE.

-- ===============================================================

-- 🧩 9️⃣ Probar el ON DELETE SET NULL
-- Eliminamos un tutor y observamos que los bebés quedan con dni_tutor NULL.
DELETE FROM tutors WHERE dni = '59102748R';

-- Verificar:
SELECT * FROM bebes;

-- ✅ Los bebés cuyo tutor ha sido eliminado mantienen su registro,
-- pero su campo dni_tutor ahora está en NULL.

-- ===============================================================

-- 🧩 🔍 Consultas y comandos útiles dentro de psql

-- \l          → Lista todas las bases de datos.
-- \c nombre   → Conectarse a una base de datos específica.
-- \dt         → Ver las tablas existentes.
-- \d tabla    → Ver la estructura de una tabla.
-- \q          → Salir del cliente psql.

-- ===============================================================

-- 🧩 🚫 Errores comunes y notas importantes:

-- ❌ SHOW DATABASES; → No funciona en PostgreSQL (es de MySQL).
-- ✅ En PostgreSQL se usa: \l

-- ❌ SELECT name FROM sys.databases; → No existe en PostgreSQL.
-- ✅ Usa \l para ver bases de datos o \dt para ver tablas.

-- ❌ INSERT INTO tutors ([nom]) VALUES (Carlos); → Incorrecto.
-- ✅ INSERT INTO tutors (dni, nom, apellido) VALUES ('11111111A', 'Carlos', 'Arroyo'); → Correcto.

-- ✅ Las cadenas siempre van entre comillas simples (' ').

-- ===============================================================

-- 🧩  🔧 Extra: Consultas de repaso

-- Mostrar todas las tutoras y sus bebés
SELECT t.nom AS tutor, b.nom AS bebe
FROM tutors t
JOIN bebes b ON t.dni = b.dni_tutor;

-- Mostrar bebés sin tutor asignado
SELECT * FROM bebes WHERE dni_tutor IS NULL;

-- ===============================================================
-- 🧾 Fin de los apuntes de SQL en PostgreSQL 🧠
-- ===============================================================
