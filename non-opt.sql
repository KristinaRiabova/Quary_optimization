SELECT 
    g.game_name,
    g.genre,
    g.release_year,
    oc.cnt
FROM 
    (SELECT game_id, COUNT(*) AS cnt
     FROM game_orders
     GROUP BY game_id) AS oc
JOIN 
    games g ON oc.game_id = g.game_id
WHERE 
    (oc.cnt = (SELECT MIN(cnt) 
                FROM (SELECT COUNT(*) AS cnt FROM game_orders GROUP BY game_id) AS temp)
     OR oc.cnt = (SELECT MAX(cnt) 
                   FROM (SELECT COUNT(*) AS cnt FROM game_orders GROUP BY game_id) AS temp))
    AND g.genre IN ('Action', 'Adventure')  
    AND g.release_year >= 2010              
ORDER BY 
    oc.cnt;
