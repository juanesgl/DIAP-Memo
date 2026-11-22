SELECT 
    c.fullname AS Curso,
    l.action AS Accion,
    COUNT(l.id) AS Interacciones_Docente
FROM prefix_logstore_standard_log l
JOIN prefix_course c ON l.courseid = c.id
WHERE l.userid = %%USERID%%
  AND l.timecreated >= :desde_date
  AND l.timecreated <= :hasta_date
GROUP BY c.fullname, l.action
ORDER BY Interacciones_Docente DESC