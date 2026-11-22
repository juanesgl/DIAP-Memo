SELECT 
    r.name AS Rol,
    COUNT(DISTINCT u.id) AS Total_Usuarios_Activos
FROM prefix_user u
JOIN prefix_user_enrolments ue ON u.id = ue.userid
JOIN prefix_enrol e ON ue.enrolid = e.id
JOIN prefix_context ctx ON ctx.instanceid = e.courseid AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra ON ra.userid = u.id AND ra.contextid = ctx.id
JOIN prefix_role r ON ra.roleid = r.id
WHERE r.shortname IN ('student', 'teacher', 'editingteacher', 'manager')
  AND u.deleted = 0 
  AND u.suspended = 0
  AND ue.status = 0 
  AND e.status = 0  
  AND e.courseid = 4
GROUP BY r.name