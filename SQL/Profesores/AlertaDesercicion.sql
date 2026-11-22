SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/user/view.php%%Q%%id=', u.id, '&course=', c.id) AS Perfil_link_url,
    u.firstname AS Nombre,
    u.lastname AS Apellido,
    u.email AS Correo
FROM prefix_user_enrolments ue
JOIN prefix_enrol e ON ue.enrolid = e.id
JOIN prefix_course c ON e.courseid = c.id
JOIN prefix_user u ON ue.userid = u.id
JOIN prefix_context ctx ON ctx.instanceid = c.id AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra_teacher ON ra_teacher.contextid = ctx.id AND ra_teacher.userid = %%USERID%%
WHERE u.deleted = 0 
  AND u.suspended = 0
  AND NOT EXISTS (
      SELECT 1 
      FROM prefix_user_lastaccess ul 
      WHERE ul.courseid = c.id AND ul.userid = u.id
  )
ORDER BY c.fullname, u.lastname