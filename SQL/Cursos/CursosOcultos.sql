SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    COUNT(DISTINCT ra.userid) AS Estudiantes_Matriculados
FROM prefix_course c
JOIN prefix_context ctx ON ctx.instanceid = c.id AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra ON ra.contextid = ctx.id
JOIN prefix_role r ON ra.roleid = r.id
WHERE c.category > 0 
  AND c.visible = 0 
  AND r.shortname = 'student'
GROUP BY c.id, c.fullname