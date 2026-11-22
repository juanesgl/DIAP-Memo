SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    COUNT(l.id) AS Total_Interacciones
FROM prefix_logstore_standard_log l
JOIN prefix_course c ON l.courseid = c.id
WHERE c.category > 0
GROUP BY c.id, c.fullname
ORDER BY Total_Interacciones DESC