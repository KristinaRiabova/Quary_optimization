CREATE DATABASE IF NOT EXISTS games_2;
USE games_2;

CREATE TABLE developers (
    developer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100)
);

CREATE TABLE games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    developer_id INT,
    release_year INT,
    FOREIGN KEY (developer_id) REFERENCES developers(developer_id)
);

CREATE TABLE players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT,
    favorite_game_id INT,
    FOREIGN KEY (favorite_game_id) REFERENCES games(game_id)
);
