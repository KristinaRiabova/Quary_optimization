CREATE INDEX idx_developer ON games(developer_id);
CREATE INDEX idx_favorite_game ON players(favorite_game_id);

WITH DeveloperGames AS (
    SELECT g.game_id, g.title, d.name AS developer_name 
    FROM games g 
    JOIN developers d ON g.developer_id = d.developer_id
)
SELECT p.name, p.age, dg.title, dg.developer_name 
FROM players p 
JOIN DeveloperGames dg ON p.favorite_game_id = dg.game_id 
WHERE p.age > 25;
