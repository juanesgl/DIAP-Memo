SELECT 
    u.id AS Estudiante_ID,
    u.firstname AS Nombre,
    u.lastname AS Apellido,
    CONCAT(u.firstname, ' ', u.lastname) AS Nombre_Completo,
    u.email AS Correo,

    CONCAT(
        '%%WWWROOT%%/user/profile.php%%Q%%id=',
        u.id
    ) AS Perfil_link_url,

    c.id AS Curso_ID,
    c.fullname AS Curso,
    c.shortname AS Codigo_Curso,

    CONCAT(
        '%%WWWROOT%%/course/view.php%%Q%%id=',
        c.id
    ) AS Curso_link_url,

    cc.name AS Categoria,

    c.startdate AS inicio_curso_date,
    c.enddate AS fin_curso_date,

    CASE 
        WHEN ccomp.timecompleted IS NOT NULL
            THEN 'Finalizado (Completado)'

        WHEN c.enddate > 0
             AND c.enddate < UNIX_TIMESTAMP()
            THEN 'Finalizado (Por Fecha)'

        WHEN c.startdate > UNIX_TIMESTAMP()
            THEN 'Futuro'

        ELSE 'En curso'
    END AS Estado_Temporal,

    COALESCE(notas.nota_final, 0) AS Nota_Actual,

    COALESCE(notas.nota_maxima, 0) AS Nota_Maxima_Posible,

    CASE 
        WHEN notas.nota_maxima > 0 THEN
            ROUND(
                (notas.nota_final / notas.nota_maxima) * 100,
                2
            )
        ELSE 0
    END AS Porcentaje_Calificacion,

    COALESCE(progreso.total_exigidas, 0) AS Actividades_Totales,

    COALESCE(progreso.completadas, 0) AS Actividades_Completadas,

    (
        COALESCE(progreso.total_exigidas, 0)
        -
        COALESCE(progreso.completadas, 0)
    ) AS Actividades_Pendientes,

    CASE 
        WHEN COALESCE(progreso.total_exigidas, 0) > 0 THEN
            ROUND(
                (
                    COALESCE(progreso.completadas, 0)
                    /
                    progreso.total_exigidas
                ) * 100,
                2
            )
        ELSE 0
    END AS Progreso_Porcentaje,

    COALESCE(
        pendientes.lista_pendientes,
        'Ninguna / Al día'
    ) AS Pendientes_Resumen,

    logs.ultima_actividad AS ultima_interaccion_date

FROM prefix_user u

JOIN prefix_user_enrolments ue
    ON ue.userid = u.id
    AND ue.status = 0

JOIN prefix_enrol e
    ON e.id = ue.enrolid
    AND e.status = 0

JOIN prefix_course c
    ON c.id = e.courseid
    AND c.category > 0

JOIN prefix_course_categories cc
    ON cc.id = c.category

JOIN prefix_context ctx
    ON ctx.instanceid = c.id
    AND ctx.contextlevel = 50


LEFT JOIN prefix_course_completions ccomp
    ON ccomp.userid = u.id
    AND ccomp.course = c.id


LEFT JOIN (
    SELECT 
        gg.userid,
        gi.courseid,
        gg.finalgrade AS nota_final,
        gi.grademax AS nota_maxima

    FROM prefix_grade_grades gg

    JOIN prefix_grade_items gi
        ON gg.itemid = gi.id

    WHERE gi.itemtype = 'course'
        AND gg.finalgrade IS NOT NULL

) notas
    ON notas.userid = u.id
    AND notas.courseid = c.id


LEFT JOIN (
    SELECT 
        ue_in.userid,
        cm_in.course,

        COUNT(cm_in.id) AS total_exigidas,

        SUM(
            CASE 
                WHEN cmc_in.completionstate IN (1, 2)
                    THEN 1
                ELSE 0
            END
        ) AS completadas

    FROM prefix_user_enrolments ue_in

    JOIN prefix_enrol e_in
        ON e_in.id = ue_in.enrolid
        AND e_in.status = 0

    JOIN prefix_course_modules cm_in
        ON cm_in.course = e_in.courseid
        AND cm_in.completion > 0
        AND cm_in.deletioninprogress = 0

    LEFT JOIN prefix_course_modules_completion cmc_in
        ON cmc_in.coursemoduleid = cm_in.id
        AND cmc_in.userid = ue_in.userid

    WHERE ue_in.status = 0

    GROUP BY 
        ue_in.userid,
        cm_in.course

) progreso
    ON progreso.userid = u.id
    AND progreso.course = c.id


LEFT JOIN (
    SELECT 
        ue_p.userid,
        cm_p.course,

        GROUP_CONCAT(
            DISTINCT md_p.name
            SEPARATOR ', '
        ) AS lista_pendientes

    FROM prefix_user_enrolments ue_p

    JOIN prefix_enrol e_p
        ON e_p.id = ue_p.enrolid
        AND e_p.status = 0

    JOIN prefix_course_modules cm_p
        ON cm_p.course = e_p.courseid
        AND cm_p.completion > 0
        AND cm_p.deletioninprogress = 0

    JOIN prefix_modules md_p
        ON md_p.id = cm_p.module

    LEFT JOIN prefix_course_modules_completion cmc_p
        ON cmc_p.coursemoduleid = cm_p.id
        AND cmc_p.userid = ue_p.userid

    WHERE ue_p.status = 0

        AND (
            cmc_p.id IS NULL
            OR cmc_p.completionstate IN (0, 3)
        )

    GROUP BY 
        ue_p.userid,
        cm_p.course

) pendientes
    ON pendientes.userid = u.id
    AND pendientes.course = c.id


LEFT JOIN (
    SELECT 
        userid,
        courseid,
        MAX(timecreated) AS ultima_actividad

    FROM prefix_logstore_standard_log

    WHERE userid > 0

    GROUP BY 
        userid,
        courseid

) logs
    ON logs.userid = u.id
    AND logs.courseid = c.id


WHERE u.deleted = 0
    AND u.suspended = 0
    AND u.id NOT IN (8, 9)

    AND EXISTS (
        SELECT 1

        FROM prefix_role_assignments ra

        JOIN prefix_role r
            ON r.id = ra.roleid

        WHERE ra.userid = u.id
            AND ra.contextid = ctx.id
            AND r.shortname = 'student'
    )


ORDER BY 
    u.lastname ASC,
    u.firstname ASC,
    c.startdate DESC