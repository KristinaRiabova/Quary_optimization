import mysql.connector
import uuid
from faker import Faker
from dotenv import load_dotenv
import random
from datetime import datetime, timedelta
import os

# Load environment variables
load_dotenv()

# Connection parameters
HOST = os.getenv('host')
USER = os.getenv('user')
PASSWORD = os.getenv('password')
DATABASE = os.getenv('database')

# Connect to the MySQL database
connection = mysql.connector.connect(
    host=HOST,
    user=USER,
    password=PASSWORD,
    database=DATABASE
)

cursor = connection.cursor()
fake = Faker()

# Inserting rows into the clients table
print("Inserting rows into clients...")
client_insert_query = """
    INSERT INTO clients (id, name, surname, email, phone, address, status) 
    VALUES (%s, %s, %s, %s, %s, %s, %s)
"""
clients_data = [
    (str(uuid.uuid4()), fake.first_name(), fake.last_name(), fake.email(), fake.phone_number(), fake.address(), random.choice(['active', 'inactive']))
    for _ in range(10000)
]
cursor.executemany(client_insert_query, clients_data)
connection.commit()
print("Inserted into clients.")

# Inserting rows into the products table
print("Inserting rows into products...")
product_insert_query = """
    INSERT INTO products (product_name, product_category, description) 
    VALUES (%s, %s, %s)
"""
categories = ['Category1', 'Category2', 'Category3', 'Category4', 'Category5']
products_data = [
    (fake.word(), random.choice(categories), fake.text())
    for _ in range(10000)
]
cursor.executemany(product_insert_query, products_data)
connection.commit()
print("Inserted into products.")

# Inserting rows into the orders table
print("Inserting rows into orders...")
order_insert_query = """
    INSERT INTO orders (order_date, client_id, product_id) 
    VALUES (%s, %s, %s)
"""
order_date_start = datetime.now() - timedelta(days=365 * 5)
orders_data = [
    (order_date_start + timedelta(days=random.randint(0, 365 * 5)), random.choice(clients_data)[0], random.randint(1, 10000))
    for _ in range(10000)
]
cursor.executemany(order_insert_query, orders_data)
connection.commit()
print("Inserted into orders.")

# Closing the cursor and connection
cursor.close()
connection.close()
