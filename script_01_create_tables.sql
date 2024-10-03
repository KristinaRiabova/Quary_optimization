CREATE DATABASE IF NOT EXISTS game_db;
USE game_db;

CREATE TABLE IF NOT EXISTS players (
    player_id CHAR(36) PRIMARY KEY,
    player_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_name VARCHAR(255) NOT NULL,
    genre ENUM('Action', 'Adventure', 'Strategy', 'Puzzle', 'RPG') NOT NULL,
    release_year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS game_orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    player_id CHAR(36),
    game_id INT,
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);
