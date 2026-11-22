SELECT 
    cc.name AS Categoria,
    CONCAT('%%WWWROOT%%/course/index.php%%Q%%categoryid=', cc.id) AS Categoria_link_url,
    COUNT(DISTINCT ra.userid) AS Estudiantes_Matriculados
FROM prefix_role_assignments ra 
JOIN prefix_role r ON ra.roleid = r.id
JOIN prefix_context ctx ON ra.contextid = ctx.id 
JOIN prefix_course c ON ctx.instanceid = c.id 
JOIN prefix_course_categories cc ON c.category = cc.id 
JOIN prefix_user u ON ra.userid = u.id
WHERE ctx.contextlevel = 50 
  AND r.shortname = 'student'
  AND u.deleted = 0
  AND u.suspended = 0
  AND c.visible = 1
  AND cc.visible = 1
GROUP BY cc.id, cc.name
ORDER BY Estudiantes_Matriculados DESC