import psycopg2
from psycopg2 import sql
from faker import Faker
import random

# Configurar la conexión a la base de datos
conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="postgres",
    host="10.10.10.2",
    port="15432"
)

# Crear un cursor
cur = conn.cursor()

# Instanciar Faker
fake = Faker()

# Número de registros a insertar
num_usuarios = 10
num_promociones = 5
num_juegos = 5

# Función para insertar datos en la tabla Usuario
def insertar_usuarios(n):
    for _ in range(n):
        nombre = fake.name()
        fecha_nacimiento = fake.date_of_birth(minimum_age=18, maximum_age=90)
        correo = fake.email()
        cur.execute(
            "INSERT INTO ProyectoFinal.Usuario (Nombre, Fecha_Nacimiento, Correo) VALUES (%s, %s, %s) RETURNING ID_Usuario",
            (nombre, fecha_nacimiento, correo)
        )
        id_usuario = cur.fetchone()[0]
        usuarios.append(id_usuario)

# Función para insertar datos en la tabla Membresias
def insertar_membresias():
    for _ in range(num_usuarios):
        id_usuario = random.choice(usuarios)  # Escoger un ID de Usuario válido
        fecha_inicio = fake.date_this_year()
        fecha_fin = fake.date_between(start_date=fecha_inicio, end_date="+1y")
        tipo = random.choice(['Mensual', 'Semestral', 'Anual'])
        cur.execute(
            "INSERT INTO ProyectoFinal.Membresias (ID_Usuario, Fecha_Inicio, Fecha_Fin, Tipo) VALUES (%s, %s, %s, %s)",
            (id_usuario, fecha_inicio, fecha_fin, tipo)
        )

# Función para insertar datos en la tabla Promociones
def insertar_promociones(n):
    for _ in range(n):
        descripcion = fake.catch_phrase()
        fecha_inicio = fake.date_this_year()
        fecha_fin = fake.date_between(start_date=fecha_inicio, end_date="+1y")
        cur.execute(
            "INSERT INTO ProyectoFinal.Promociones (Descripcion, Fecha_Inicio, Fecha_Fin) VALUES (%s, %s, %s) RETURNING ID_Promocion",
            (descripcion, fecha_inicio, fecha_fin)
        )
        id_promocion = cur.fetchone()[0]
        promociones.append(id_promocion)

# Función para insertar datos en la tabla Entradas
def insertar_entradas():
    for _ in range(num_usuarios):
        id_usuario = random.choice(usuarios)
        id_promocion = random.choice([None] + promociones)
        fecha = fake.date_this_year()
        tipo = random.choice(['Adulto', 'Niño'])
        tiempo_limitado = fake.time()
        cur.execute(
            "INSERT INTO ProyectoFinal.Entradas (ID_Usuario, ID_Promocion, Fecha, Tipo, Tiempo_Limitado) VALUES (%s, %s, %s, %s, %s)",
            (id_usuario, id_promocion, fecha, tipo, tiempo_limitado)
        )

# Función para insertar datos en la tabla Juegos
def insertar_juegos(n):
    for _ in range(n):
        nombre = fake.word()
        puntos = random.randint(10, 100)
        cur.execute(
            "INSERT INTO ProyectoFinal.Juegos (Nombre, Puntos) VALUES (%s, %s) RETURNING ID_Juego",
            (nombre, puntos)
        )
        id_juego = cur.fetchone()[0]
        juegos.append(id_juego)

# Función para insertar datos en la tabla Registros_Juegos
def insertar_registros_juegos():
    for _ in range(num_usuarios):
        id_usuario = random.choice(usuarios)
        id_juego = random.choice(juegos)
        fecha = fake.date_this_year()
        puntos_ganados = random.randint(10, 100)
        cur.execute(
            "INSERT INTO ProyectoFinal.Registros_Juegos (ID_Usuario, ID_Juego, Fecha, Puntos_Ganados) VALUES (%s, %s, %s, %s)",
            (id_usuario, id_juego, fecha, puntos_ganados)
        )

# Función para insertar datos en la tabla Premios
def insertar_premios(n):
    for _ in range(n):
        descripcion = fake.catch_phrase()
        puntos_necesarios = random.randint(50, 200)
        cur.execute(
            "INSERT INTO ProyectoFinal.Premios (Descripcion, Puntos_Necesarios) VALUES (%s, %s) RETURNING ID_Premio",
            (descripcion, puntos_necesarios)
        )
        id_premio = cur.fetchone()[0]
        premios.append(id_premio)

# Función para insertar datos en la tabla Canje_Premios
def insertar_canje_premios():
    for _ in range(num_usuarios):
        id_usuario = random.choice(usuarios)
        id_premio = random.choice(premios)
        fecha = fake.date_this_year()
        puntos_utilizados = random.randint(50, 200)
        cur.execute(
            "INSERT INTO ProyectoFinal.Canje_Premios (ID_Usuario, ID_Premio, Fecha, Puntos_Utilizados) VALUES (%s, %s, %s, %s)",
            (id_usuario, id_premio, fecha, puntos_utilizados)
        )

# Listas para almacenar IDs válidos
usuarios = []
promociones = []
juegos = []
premios = []

# Llamar a las funciones para insertar datos
insertar_usuarios(num_usuarios)
insertar_membresias()
insertar_promociones(num_promociones)
insertar_entradas()
insertar_juegos(num_juegos)
insertar_registros_juegos()
insertar_premios(num_juegos)
insertar_canje_premios()

# Confirmar los cambios
conn.commit()

# Cerrar el cursor y la conexión
cur.close()
conn.close()

