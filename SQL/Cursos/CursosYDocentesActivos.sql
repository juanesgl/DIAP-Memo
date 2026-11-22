SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    CASE r.shortname
        WHEN 'editingteacher' THEN 'Profesor'
        WHEN 'teacher' THEN 'Profesor sin edición'
        ELSE r.shortname
    END AS Rol,
    u.firstname AS Nombre,
    u.lastname AS Apellido,
    u.email AS Correo
FROM prefix_course c
JOIN prefix_enrol e ON e.courseid = c.id
JOIN prefix_user_enrolments ue ON ue.enrolid = e.id
JOIN prefix_context ctx ON ctx.instanceid = c.id AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra ON ra.contextid = ctx.id AND ra.userid = ue.userid
JOIN prefix_role r ON ra.roleid = r.id
JOIN prefix_user u ON ue.userid = u.id
WHERE c.id = 4
  AND u.deleted = 0
  AND u.suspended = 0
  AND ue.status = 0
  AND e.status = 0
  AND r.shortname IN ('editingteacher', 'teacher')
ORDER BY Rol, u.lastname, u.firstname