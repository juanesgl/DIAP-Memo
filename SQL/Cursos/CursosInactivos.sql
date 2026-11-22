SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    c.enddate AS finalizacion_date
FROM prefix_course c
WHERE c.category > 0 
  AND c.enddate > 0 
  AND c.enddate < UNIX_TIMESTAMP()
ORDER BY c.enddate DESC