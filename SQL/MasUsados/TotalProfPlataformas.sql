SELECT 
    u.id AS ID_Profesor,
    CONCAT(u.firstname, ' ', u.lastname) AS Nombre_Profesor,
    CONCAT('%%WWWROOT%%/user/profile.php%%Q%%id=', u.id) AS Nombre_Profesor_link_url,
    u.email AS Correo,
    total_plataforma.Gran_Total_Docentes
FROM prefix_user u
JOIN prefix_role_assignments ra ON u.id = ra.userid
JOIN prefix_role r ON ra.roleid = r.id
JOIN prefix_context ctx ON ra.contextid = ctx.id

CROSS JOIN (
    SELECT COUNT(DISTINCT u2.id) AS Gran_Total_Docentes
    FROM prefix_user u2
    JOIN prefix_role_assignments ra2 ON u2.id = ra2.userid
    JOIN prefix_role r2 ON ra2.roleid = r2.id
    JOIN prefix_context ctx2 ON ra2.contextid = ctx2.id
    WHERE r2.shortname IN ('editingteacher', 'teacher')
      AND u2.deleted = 0
      AND u2.suspended = 0
      AND ctx2.contextlevel = 50
) AS total_plataforma

WHERE r.shortname IN ('editingteacher', 'teacher')
  AND u.deleted = 0
  AND u.suspended = 0
  AND ctx.contextlevel = 50

GROUP BY 
    u.id, 
    u.firstname, 
    u.lastname, 
    u.email, 
    total_plataforma.Gran_Total_Docentes
ORDER BY 
    u.lastname ASC, 
    u.firstname ASC