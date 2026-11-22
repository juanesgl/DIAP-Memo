SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    m.name AS Tipo_Recurso,
    COUNT(cm.id) AS Cantidad
FROM prefix_course_modules cm
JOIN prefix_modules m ON cm.module = m.id
JOIN prefix_course c ON cm.course = c.id
JOIN prefix_context ctx ON ctx.instanceid = c.id AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra ON ra.contextid = ctx.id AND ra.userid = %%USERID%%
GROUP BY c.id, c.fullname, m.name
ORDER BY c.fullname, Cantidad DESC