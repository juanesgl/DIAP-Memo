SELECT 
    c.fullname AS Curso, 
    l.component AS Componente, 
    l.action AS Accion, 
    COUNT(l.id) AS Total_Interacciones 
FROM prefix_logstore_standard_log l 
JOIN prefix_course c ON l.courseid = c.id 
WHERE l.userid = %%USERID%% 
GROUP BY c.fullname, l.component, l.action 
ORDER BY Total_Interacciones DESC