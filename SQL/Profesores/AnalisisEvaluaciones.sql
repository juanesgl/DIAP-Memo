SELECT 
    c.shortname AS Curso,
    q.name AS Cuestionario,
    CONCAT('%%WWWROOT%%/mod/quiz/report.php%%Q%%id=', cm.id) AS Reporte_link_url,
    COUNT(qa.id) AS Intentos_Realizados,
    AVG(qa.sumgrades) AS Promedio_Calificaciones
FROM prefix_quiz_attempts qa
JOIN prefix_quiz q ON qa.quiz = q.id
JOIN prefix_course c ON q.course = c.id
JOIN prefix_course_modules cm ON cm.instance = q.id AND cm.module = (SELECT id FROM prefix_modules WHERE name = 'quiz')
JOIN prefix_context ctx ON ctx.instanceid = c.id AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra ON ra.contextid = ctx.id AND ra.userid = %%USERID%%
WHERE qa.state = 'finished'
GROUP BY c.shortname, q.id, q.name, cm.id
ORDER BY c.shortname, Promedio_Calificaciones ASC