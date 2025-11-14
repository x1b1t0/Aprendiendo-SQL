-- ===============================================================
-- 🧠 APUNTES DE SQL – Hospital + Gimnas
-- Contiene SOLO contenido nuevo que NO aparecía en la base de datos de bebés.
-- ===============================================================


-- ===============================================================
-- 🏥 1️⃣ BASE DE DATOS: HOSPITAL
-- ===============================================================

-- Crear la base de datos Hospital
CREATE DATABASE Hospital;

-- Conectarse
\c hospital;


-- ===============================================================
-- 1.1 TABLA doctore
-- Contiene información de los doctores
-- ===============================================================

CREATE TABLE doctore (
    nif TEXT PRIMARY KEY,        -- Identificador único del doctor
    nom TEXT,                    -- Nombre
    cognom TEXT,                 -- Apellido
    expecialitat TEXT,           -- Especialidad médica
    n_colegiat INTEGER           -- Número de colegiado
);


-- ===============================================================
-- 1.2 TABLA infermers
-- Información de enfermeros/as
-- ===============================================================

CREATE TABLE infermers (
    nif TEXT PRIMARY KEY,        -- Identificador único del enfermero
    nom TEXT,
    cognom TEXT,
    n_col_inf INTEGER            -- Número de colegiado de enfermería
);


-- ===============================================================
-- 1.3 TABLA pacient
-- Usa dos claves foráneas: doctor + enfermero
-- ===============================================================

CREATE TABLE pacient (
    n_tarj INTEGER PRIMARY KEY,    -- Tarjeta sanitaria (única)
    nom TEXT,
    cognom TEXT,
    nif_doctor TEXT,
    nif_infermera TEXT,

    -- Relación con doctores
    CONSTRAINT no_doctor FOREIGN KEY (nif_doctor)
        REFERENCES doctore(nif)
        ON UPDATE CASCADE          -- Si cambia el nif en doctore → cambia aquí
        ON DELETE SET NULL,        -- Si se borra el doctor → el paciente queda sin doctor

    -- Relación con enfermeros
    CONSTRAINT no_infermeres FOREIGN KEY (nif_infermera)
        REFERENCES infermers(nif)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


-- ===============================================================
-- 1.4 INSERTAR DATOS EN Hospital
-- ===============================================================

-- Doctores
INSERT INTO doctore VALUES ('389123', 'Diego', 'Santos', 'Traumatologo', 6312);
INSERT INTO doctore VALUES ('389122', 'Manu', 'Vivar', 'Dermatologo', 6322);

-- Enfermeros
INSERT INTO infermers VALUES ('389121', 'Manuel', 'Arroyo', 6323);
INSERT INTO infermers VALUES ('389128', 'Pepe', 'Acedo', 6326);

-- Pacientes
INSERT INTO pacient VALUES (1, 'Pepe', 'Benavente', '389123', '389121');
INSERT INTO pacient VALUES (2, 'Pepe', 'Jacinto', '389122', '389128');


-- ===============================================================
-- 1.5 EJEMPLO DE ON UPDATE CASCADE
-- Cambiar el NIF de un enfermero → se actualiza automáticamente en pacient
-- ===============================================================

UPDATE infermers
SET nif = '389189'
WHERE nom = 'Manuel';


-- ===============================================================
-- 🏋️‍♂️ 2️⃣ BASE DE DATOS: GIMNAS
-- ===============================================================

-- Crear tablas para gestión de socios y deportes


-- ===============================================================
-- 2.1 TABLA soci
-- Socios del gimnasio
-- ===============================================================

CREATE TABLE soci (
    passaport TEXT PRIMARY KEY,   -- Identificador del socio
    data_alta DATE                -- Fecha de inscripción
);


-- ===============================================================
-- 2.2 TABLA esport
-- Lista de deportes disponibles
-- ===============================================================

CREATE TABLE esport (
    nesport TEXT PRIMARY KEY,     -- Nombre del deporte
    preu NUMERIC(5,2),            -- Precio con dos decimales
    jugadors SMALLINT             -- Jugadores necesarios
);


-- ===============================================================
-- 2.3 TABLA fa (relación N:M entre soci y esport)
-- Un socio puede practicar varios deportes y cada deporte tiene muchos socios
-- ===============================================================

CREATE TABLE fa (
    nesport TEXT NOT NULL,        -- Deporte
    passaport TEXT NOT NULL,      -- Socio
    quota NUMERIC(5,2),           -- Cuota a pagar por ese deporte

    -- Clave foránea hacia soci
    CONSTRAINT nosoci FOREIGN KEY(passaport)
        REFERENCES soci(passaport)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    -- Clave foránea hacia esport
    CONSTRAINT noesport FOREIGN KEY(nesport)
        REFERENCES esport(nesport)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    -- Evita duplicar (soci + deporte)
    UNIQUE(nesport, passaport)
);


-- ===============================================================
-- 2.4 INSERTAR DATOS EN Gimnas
-- ===============================================================

-- Deportes
INSERT INTO esport VALUES ('Futbol', 20, 11);
INSERT INTO esport VALUES ('Basket', 300, 6);
INSERT INTO esport VALUES ('Golf',   150, 8);
INSERT INTO esport VALUES ('Padel',  400, 2);

-- Socios
INSERT INTO soci VALUES ('12', '2025-05-03');
INSERT INTO soci VALUES ('13', '2025-08-03');

-- Asociaciones (socios ↔ deportes)
INSERT INTO fa (nesport, passaport, quota) VALUES ('Futbol', '12', 20);
INSERT INTO fa (nesport, passaport, quota) VALUES ('Golf',   '13', 150);


-- ===============================================================
-- 🧩 3️⃣ CONCEPTOS NUEVOS IMPORTANTES
-- (No estaban en la base de datos de bebés)
-- ===============================================================


-- ===============================================================
-- 3.1 JOINs (muy importantes)
-- ===============================================================

-- INNER JOIN → Solo coincidentes
SELECT * FROM pacient
INNER JOIN doctore ON pacient.nif_doctor = doctore.nif;

-- LEFT JOIN → Todos los pacientes, tengan doctor o no
SELECT * FROM pacient
LEFT JOIN doctore ON pacient.nif_doctor = doctore.nif;

-- RIGHT JOIN → Todos los doctores, tengan pacientes o no
SELECT * FROM pacient
RIGHT JOIN doctore ON pacient.nif_doctor = doctore.nif;


-- ===============================================================
-- 3.2 VIEWS (vistas)
-- Tabla virtual que almacena una consulta
-- ===============================================================

CREATE VIEW vista_pacients AS
SELECT p.nom, p.cognom, d.nom AS doctor
FROM pacient p
LEFT JOIN doctore d ON p.nif_doctor = d.nif;

-- Usar la vista como si fuera una tabla
SELECT * FROM vista_pacients;


-- ===============================================================
-- 3.3 CHECK (validación de datos)
-- ===============================================================

ALTER TABLE esport
ADD CONSTRAINT chk_jugadors CHECK (jugadors > 0);


-- ===============================================================
-- 3.4 UNIQUE compuesto (evita duplicados combinados)
-- Ya lo usaste en la tabla fa
-- ===============================================================

-- Un ejemplo genérico:
-- UNIQUE(campo1, campo2) evita pares duplicados


-- ===============================================================
-- 🧾 FIN DEL ARCHIVO COMPLETO
-- ===============================================================
