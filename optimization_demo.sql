WITH FilteredOrders AS (
    SELECT 
        o.order_id, 
        o.client_id, 
        o.product_id
    FROM 
        orders o
    JOIN 
        products p ON o.product_id = p.product_id
    WHERE 
        p.product_category = 'Category2'
),
FilteredClients AS (
    SELECT 
        id, 
        name, 
        surname
    FROM 
        clients
    WHERE 
        status = 'active'
)
SELECT 
    fc.name, 
    fc.surname, 
    p.product_name, 
    COUNT(fo.order_id) AS total_orders
FROM 
    FilteredClients fc
JOIN 
    FilteredOrders fo ON fc.id = fo.client_id
JOIN 
    products p ON fo.product_id = p.product_id
GROUP BY 
    fc.id, p.product_id
ORDER BY 
    total_orders DESC;
