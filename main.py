import mysql.connector
from faker import Faker
from dotenv import load_dotenv
import random
import os

load_dotenv()

HOST = os.getenv('host')
USER = os.getenv('user')
PASSWORD = os.getenv('password')
DATABASE = 'games_2'  # Set the database name directly

connection = mysql.connector.connect(
    host=HOST,
    user=USER,
    password=PASSWORD,
    database=DATABASE
)

cursor = connection.cursor()
fake = Faker()

print("Inserting data into developers table...")
developer_insert_query = """
    INSERT INTO developers (name, country) 
    VALUES (%s, %s)
"""
developers_data = [
    (fake.company(), fake.country())
    for _ in range(100000)
]
try:
    cursor.executemany(developer_insert_query, developers_data)
    connection.commit()
    print("Data inserted into developers table.")
except mysql.connector.Error as err:
    print(f"Error inserting into developers table: {err}")

print("Inserting data into games table...")
game_insert_query = """
    INSERT INTO games (title, developer_id, release_year) 
    VALUES (%s, %s, %s)
"""
games_data = [
    (fake.catch_phrase(), random.randint(1, 100000), random.randint(1990, 2024))
    for _ in range(10000)
]
try:
    cursor.executemany(game_insert_query, games_data)
    connection.commit()
    print("Data inserted into games table.")
except mysql.connector.Error as err:
    print(f"Error inserting into games table: {err}")

print("Inserting data into players table...")
player_insert_query = """
    INSERT INTO players (name, age, favorite_game_id) 
    VALUES (%s, %s, %s)
"""
players_data = [
    (fake.name(), random.randint(18, 40), random.randint(1, 1000))
    for _ in range(10000)
]
try:
    cursor.executemany(player_insert_query, players_data)
    connection.commit()
    print("Data inserted into players table.")
except mysql.connector.Error as err:
    print(f"Error inserting into players table: {err}")

cursor.close()
connection.close()
