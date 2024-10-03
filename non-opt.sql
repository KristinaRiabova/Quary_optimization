SELECT p.name, p.age, g.title, d.name AS developer_name 
FROM players p 
JOIN games g ON p.favorite_game_id = g.game_id 
JOIN developers d ON g.developer_id = d.developer_id 
WHERE p.age > 25;
