SELECT 
    u.id AS Profesor_ID,
    u.firstname AS Nombre,
    u.lastname AS Apellido,
    u.email AS Correo,
    CONCAT('%%WWWROOT%%/user/profile.php%%Q%%id=', u.id) AS Perfil_link_url,
    total_plataforma.Gran_Total_Docentes,
    
    COALESCE(resumen_profesor.total_cursos_dictados, 0) AS Cursos_Como_Profesor,
    resumen_profesor.nombres_cursos_dictados AS Lista_Cursos_Dictados,
    
    COALESCE(resumen_estudiante.total_cursos_tomados, 0) AS Cursos_Como_Estudiante,
    resumen_estudiante.nombres_cursos_tomados AS Lista_Cursos_Tomados,

    c.id AS Curso_ID,
    c.fullname AS Curso,
    c.shortname AS Codigo_Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url,
    cc.id AS Categoria_ID,
    cc.name AS Categoria,
    CASE WHEN c.visible = 1 THEN 'Activo' ELSE 'Oculto' END AS Estado_Curso,
    c.startdate AS inicio_curso_date,
    c.enddate AS fin_curso_date,
    r.name AS Nombre_Rol_Docente,

    COALESCE(metrica_estudiantes.total_matriculados, 0) AS Total_Estudiantes,
    COALESCE(metrica_actividades.total_actividades, 0) AS Total_Actividades,
    COALESCE(metrica_logs.ultima_actividad, 0) AS ultima_actividad_curso_date

FROM prefix_user u
JOIN prefix_role_assignments ra ON u.id = ra.userid
JOIN prefix_context ctx ON ra.contextid = ctx.id AND ctx.contextlevel = 50
JOIN prefix_role r ON ra.roleid = r.id AND r.shortname IN ('editingteacher', 'teacher')
JOIN prefix_course c ON ctx.instanceid = c.id
JOIN prefix_course_categories cc ON c.category = cc.id

CROSS JOIN (
    SELECT COUNT(DISTINCT u_tot.id) AS Gran_Total_Docentes
    FROM prefix_user u_tot
    JOIN prefix_role_assignments ra_tot ON u_tot.id = ra_tot.userid
    JOIN prefix_context ctx_tot ON ra_tot.contextid = ctx_tot.id AND ctx_tot.contextlevel = 50
    JOIN prefix_role r_tot ON ra_tot.roleid = r_tot.id AND r_tot.shortname IN ('editingteacher', 'teacher')
    WHERE u_tot.deleted = 0 
      AND u_tot.suspended = 0
      AND u_tot.id NOT IN (8, 9)
) total_plataforma

LEFT JOIN (
    SELECT 
        ra_in.userid, 
        COUNT(DISTINCT ctx_in.instanceid) AS total_cursos_dictados,
        GROUP_CONCAT(DISTINCT c_in.fullname SEPARATOR ' | ') AS nombres_cursos_dictados
    FROM prefix_role_assignments ra_in
    JOIN prefix_context ctx_in ON ra_in.contextid = ctx_in.id AND ctx_in.contextlevel = 50
    JOIN prefix_role r_in ON ra_in.roleid = r_in.id AND r_in.shortname IN ('editingteacher', 'teacher')
    JOIN prefix_course c_in ON ctx_in.instanceid = c_in.id
    GROUP BY ra_in.userid
) resumen_profesor ON resumen_profesor.userid = u.id

LEFT JOIN (
    SELECT 
        ra_stu.userid, 
        COUNT(DISTINCT ctx_stu.instanceid) AS total_cursos_tomados,
        GROUP_CONCAT(DISTINCT c_stu.fullname SEPARATOR ' | ') AS nombres_cursos_tomados
    FROM prefix_role_assignments ra_stu
    JOIN prefix_context ctx_stu ON ra_stu.contextid = ctx_stu.id AND ctx_stu.contextlevel = 50
    JOIN prefix_role r_stu ON ra_stu.roleid = r_stu.id AND r_stu.shortname = 'student'
    JOIN prefix_course c_stu ON ctx_stu.instanceid = c_stu.id
    GROUP BY ra_stu.userid
) resumen_estudiante ON resumen_estudiante.userid = u.id

LEFT JOIN (
    SELECT e.courseid, COUNT(DISTINCT ue.userid) AS total_matriculados
    FROM prefix_enrol e
    JOIN prefix_user_enrolments ue ON e.id = ue.enrolid
    WHERE ue.status = 0 AND e.status = 0
    GROUP BY e.courseid
) metrica_estudiantes ON metrica_estudiantes.courseid = c.id

LEFT JOIN (
    SELECT course, COUNT(id) AS total_actividades
    FROM prefix_course_modules
    WHERE deletioninprogress = 0
    GROUP BY course
) metrica_actividades ON metrica_actividades.course = c.id

LEFT JOIN (
    SELECT courseid, MAX(timecreated) AS ultima_actividad
    FROM prefix_logstore_standard_log
    GROUP BY courseid
) metrica_logs ON metrica_logs.courseid = c.id

WHERE u.deleted = 0 
  AND u.suspended = 0
  AND u.id NOT IN (8, 9)
ORDER BY u.lastname, u.firstname, c.shortname
