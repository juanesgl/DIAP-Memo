SELECT 
    c.fullname AS Curso, 
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    COUNT(l.id) AS Total_Clics, 
    MIN(l.timecreated) AS primer_acceso_date, 
    MAX(l.timecreated) AS ultimo_acceso_date 
FROM prefix_logstore_standard_log l 
JOIN prefix_course c ON l.courseid = c.id 
WHERE l.userid = %%USERID%% 
  AND c.category > 0 
GROUP BY c.id, c.fullname 
ORDER BY ultimo_acceso_date DESC