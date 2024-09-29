SELECT 
    c.name, 
    c.surname, 
    p.product_name, 
    COUNT(o.order_id) AS total_orders
FROM 
    clients c
JOIN 
    orders o ON c.id = o.client_id
JOIN 
    products p ON o.product_id = p.product_id
WHERE 
    p.product_category = 'Category2' AND c.status = 'active'
GROUP BY 
    c.id, p.product_id
ORDER BY 
    total_orders DESC;
