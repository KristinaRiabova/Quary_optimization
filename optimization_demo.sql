CREATE INDEX idx_game_orders_game_id ON game_orders(game_id);
CREATE INDEX idx_games_genre ON games(genre);
CREATE INDEX idx_games_release_year ON games(release_year);


 EXPLAIN WITH order_counts AS (
    SELECT 
        game_id, 
        COUNT(*) AS cnt
    FROM 
        game_orders
    GROUP BY 
        game_id
),
ranked_counts AS (
    SELECT 
        game_id,
        cnt,
        MIN(cnt) OVER () AS min_cnt,
        MAX(cnt) OVER () AS max_cnt
    FROM 
        order_counts
)
SELECT 
    g.game_name,
    g.genre,
    g.release_year,
    rc.cnt
FROM 
    ranked_counts rc
JOIN 
    games g ON rc.game_id = g.game_id
WHERE 
    (rc.cnt = rc.min_cnt OR rc.cnt = rc.max_cnt)
    AND g.genre IN ('Action', 'Adventure') 
    AND g.release_year >= 2010
ORDER BY 
    rc.cnt;
