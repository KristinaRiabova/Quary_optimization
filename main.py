import mysql.connector
import uuid
from faker import Faker
import random
from datetime import datetime, timedelta

HOST = 'localhost'
USER = 'root'
PASSWORD = '123'
DATABASE = 'game_db'

connection = mysql.connector.connect(
    host=HOST,
    user=USER,
    password=PASSWORD,
    database=DATABASE
)

cursor = connection.cursor()
fake = Faker()


print("Inserting into players...")
player_insert_query = """
    INSERT INTO players (player_id, player_name, email) 
    VALUES (%s, %s, %s)
"""
players_data = [
    (str(uuid.uuid4()), fake.name(), fake.email())
    for _ in range(10000)
]
cursor.executemany(player_insert_query, players_data)
connection.commit()
print("Inserted into players.")


print("Inserting into games...")
game_insert_query = """
    INSERT INTO games (game_name, genre, release_year) 
    VALUES (%s, %s, %s)
"""
games_data = [
    (fake.word(), random.choice(['Action', 'Adventure', 'Strategy', 'Puzzle', 'RPG']), random.randint(2000, 2023))
    for _ in range(10000)
]
cursor.executemany(game_insert_query, games_data)
connection.commit()
print("Inserted into games.")


print("Inserting into game_orders...")
order_insert_query = """
    INSERT INTO game_orders (order_date, player_id, game_id) 
    VALUES (%s, %s, %s)
"""
order_date_start = datetime.now() - timedelta(days=365 * 5)
orders_data = [
    (order_date_start + timedelta(days=random.randint(0, 365 * 5)), random.choice(players_data)[0], random.randint(1, 10000))
    for _ in range(10000)
]
cursor.executemany(order_insert_query, orders_data)
connection.commit()
print("Inserted into game_orders.")

cursor.close()
connection.close()
