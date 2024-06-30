CREATE TABLE ProyectoFinal.Membresias (
    ID_Membresia SERIAL PRIMARY KEY,
    ID_Usuario INTEGER REFERENCES ProyectoFinal.Usuario(ID_Usuario),
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    Tipo VARCHAR(50)
);


CREATE TABLE ProyectoFinal.Promociones (
    ID_Promocion SERIAL PRIMARY KEY,
    Descripcion TEXT,
    Fecha_Inicio DATE,
    Fecha_Fin DATE
);

-- Crear la tabla Entradas
CREATE TABLE ProyectoFinal.Entradas (
    ID_Entrada SERIAL PRIMARY KEY,
    ID_Usuario INTEGER REFERENCES ProyectoFinal.Usuario(ID_Usuario),
    ID_Promocion INTEGER,
    Fecha DATE,
    Tipo VARCHAR(50),
    Tiempo_Limitado TIME,
    FOREIGN KEY (ID_Promocion) REFERENCES ProyectoFinal.Promociones(ID_Promocion)
);

-- Crear la tabla Juegos
CREATE TABLE ProyectoFinal.Juegos (
    ID_Juego SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    Puntos INTEGER
);

-- Crear la tabla Registros_Juegos
CREATE TABLE ProyectoFinal.Registros_Juegos (
    ID_Registro SERIAL PRIMARY KEY,
    ID_Usuario INTEGER REFERENCES ProyectoFinal.Usuario(ID_Usuario),
    ID_Juego INTEGER REFERENCES ProyectoFinal.Juegos(ID_Juego),
    Fecha DATE,
    Puntos_Ganados INTEGER
);

-- Crear la tabla Premios
CREATE TABLE ProyectoFinal.Premios (
    ID_Premio SERIAL PRIMARY KEY,
    Descripcion TEXT,
    Puntos_Necesarios INTEGER
);

-- Crear la tabla Canje_Premios
CREATE TABLE ProyectoFinal.Canje_Premios (
    ID_Canje SERIAL PRIMARY KEY,
    ID_Usuario INTEGER REFERENCES ProyectoFinal.Usuario(ID_Usuario),
    ID_Premio INTEGER REFERENCES ProyectoFinal.Premios(ID_Premio),
    Fecha DATE,
    Puntos_Utilizados INTEGER
);

