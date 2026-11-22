SELECT 
    c.shortname AS Curso,
    CONCAT('%%WWWROOT%%/grade/report/grader/index.php%%Q%%id=', c.id) AS Curso_link_url,
    u.firstname AS Nombre,
    u.lastname AS Apellido,
    gi.itemname AS Item_Evaluado,
    gg.finalgrade AS Calificacion
FROM prefix_grade_grades gg
JOIN prefix_grade_items gi ON gg.itemid = gi.id
JOIN prefix_user u ON gg.userid = u.id
JOIN prefix_course c ON gi.courseid = c.id
JOIN prefix_context ctx ON ctx.instanceid = c.id AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra ON ra.contextid = ctx.id AND ra.userid = %%USERID%%
WHERE gi.itemtype IN ('mod', 'course')
  AND gg.finalgrade IS NOT NULL
ORDER BY c.shortname, u.lastname, gi.itemname