SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    CASE WHEN c.visible = 1 THEN 'Visible' ELSE 'Oculto' END AS Estado,
    cc.name AS Categoria,
    c.startdate AS inicio_date
FROM prefix_course c
JOIN prefix_course_categories cc ON c.category = cc.id
WHERE c.category > 0 
ORDER BY Estado DESC, c.fullname ASC