SELECT 
    c.fullname AS Curso, 
    COUNT(l.id) AS Interacciones_En_Periodo 
FROM prefix_logstore_standard_log l 
JOIN prefix_course c ON l.courseid = c.id 
WHERE l.userid = %%USERID%% 
  AND l.timecreated >= :desde_date 
  AND l.timecreated <= :hasta_date 
GROUP BY c.id, c.fullname 
ORDER BY Interacciones_En_Periodo DESC