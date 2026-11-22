SELECT 
    r.name AS Rol,
    COUNT(DISTINCT u.id) AS Total_Usuarios_Activos
FROM {user} u
JOIN {role_assignments} ra ON u.id = ra.userid
JOIN {role} r ON ra.roleid = r.id
WHERE r.shortname = 'student' AND u.deleted = 0 AND u.suspended = 0
GROUP BY r.name