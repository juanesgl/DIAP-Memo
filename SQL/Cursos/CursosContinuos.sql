SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    FROM_UNIXTIME(c.startdate, '%Y-%m-%d') AS Fecha_Inicio
FROM prefix_course c
WHERE c.category > 0 
  AND c.enddate = 0
ORDER BY c.startdate ASC