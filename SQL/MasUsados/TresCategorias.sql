SELECT 
    u.id AS usuario_id,
    CONCAT(u.firstname, ' ', u.lastname) AS estudiante,
    CONCAT('%%WWWROOT%%/user/view.php%%Q%%id=', u.id, '&course=', c.id) AS estudiante_link_url,
    u.email AS correo,
    c.fullname AS curso,
    gc.fullname AS nivel_trayectoria,
    ROUND(gi.aggregationcoef * 100, 0) AS peso_porcentaje,
    COALESCE(ROUND(gg.finalgrade, 2), 0.00) AS nota_actual,
    CASE 
        WHEN gg.finalgrade >= 3.0 THEN 'Aprobado'
        WHEN gg.finalgrade > 0 THEN 'En riesgo'
        ELSE 'Sin calificar'
    END AS estado_academico,
    u.lastaccess AS ultimo_acceso_date
FROM {course} c
JOIN {grade_items} gi ON gi.courseid = c.id AND gi.itemtype = 'category'
JOIN {grade_categories} gc ON gc.id = gi.iteminstance AND gc.depth = 2
JOIN {enrol} e ON e.courseid = c.id
JOIN {user_enrolments} ue ON ue.enrolid = e.id
JOIN {user} u ON u.id = ue.userid AND u.deleted = 0
LEFT JOIN {grade_grades} gg ON gg.itemid = gi.id AND gg.userid = u.id
WHERE c.fullname LIKE '%Diplomado en competencias digitales%'
ORDER BY estudiante, gc.id