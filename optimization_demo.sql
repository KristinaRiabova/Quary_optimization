
CREATE INDEX idx_game_orders_game_id ON game_orders(game_id);
CREATE INDEX idx_games_genre ON games(genre);
CREATE INDEX idx_games_release_year ON games(release_year);


WITH order_counts AS (
    SELECT game_id, COUNT(*) AS cnt
    FROM game_orders
    GROUP BY game_id
),
min_max AS (
    SELECT MIN(cnt) AS min_cnt, MAX(cnt) AS max_cnt
    FROM order_counts
)

SELECT 
    g.game_name,
    g.genre,
    g.release_year,
    oc.cnt
FROM 
    order_counts oc
JOIN 
    games g ON oc.game_id = g.game_id
JOIN 
    min_max mm ON oc.cnt = mm.min_cnt OR oc.cnt = mm.max_cnt
WHERE 
    g.genre IN ('Action', 'Adventure') 
    AND g.release_year >= 2010           
ORDER BY 
    oc.cnt;

