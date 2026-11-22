SELECT
    u.auth AS auth,
    c.shortname AS course1,
    c.id AS ID_Curso,
    CONCAT('https://virtual.escuelaing.edu.co/course/view.php', CHAR(63), 'id=', c.id) AS URL_Curso,
    u.firstname AS Nombre,
    u.lastname AS Apellidos,
    u.idnumber AS Identificacion,
    c.fullname AS Curso,
    r.name AS Nombre_Rol,
    r.shortname AS Nombre_Corto_Rol,
    e.enrol AS Tipo_Matriculacion,
    FROM_UNIXTIME(ue.timecreated) AS Fecha_Inscripcion,
    FROM_UNIXTIME(ue.timestart) AS Fecha_Inicio_Vigencia,
    CASE
        WHEN ue.timeend = 0 THEN 'Ilimitada / Sin fin'
        ELSE FROM_UNIXTIME(ue.timeend)
    END AS Fecha_Finalizacion,
    CASE
        WHEN ue.timeend = 0 THEN 0
        ELSE ROUND((ue.timeend - ue.timestart) / 86400)
    END AS enrolperiod1,
    CASE
        WHEN u.lastaccess = 0 THEN 'Nunca ha ingresado'
        ELSE FROM_UNIXTIME(u.lastaccess)
    END AS Ultimo_Acceso_Plataforma

FROM prefix_course AS c
JOIN prefix_context AS ctx
    ON c.id = ctx.instanceid
    AND ctx.contextlevel = 50
JOIN prefix_role_assignments AS ra
    ON ra.contextid = ctx.id
JOIN prefix_role AS r
    ON r.id = ra.roleid
JOIN prefix_user AS u
    ON u.id = ra.userid
JOIN prefix_enrol AS e
    ON e.courseid = c.id
JOIN prefix_user_enrolments AS ue
    ON ue.enrolid = e.id
    AND ue.userid = u.id

ORDER BY
    c.fullname,
    r.sortorder,
    u.lastname,
    u.firstname