SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    cc.name AS Categoria,
    FROM_UNIXTIME(c.startdate, '%d/%m/%Y %H:%i') AS Fecha_Inicio
FROM prefix_course c
JOIN prefix_course_categories cc ON c.category = cc.id
WHERE c.category > 0 
  AND c.startdate > UNIX_TIMESTAMP()
  AND c.visible = 1
  AND cc.visible = 1
ORDER BY c.startdate ASC