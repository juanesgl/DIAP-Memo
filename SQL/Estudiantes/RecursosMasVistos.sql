SELECT 
    m.name AS Tipo_Modulo, 
    cm.module, 
    COUNT(l.id) AS Vistas 
FROM prefix_logstore_standard_log l 
JOIN prefix_course_modules cm ON l.contextinstanceid = cm.id 
JOIN prefix_course c ON cm.course = c.id 
JOIN prefix_modules m ON cm.module = m.id 
WHERE l.userid = %%USERID%%
  AND l.target = 'course_module' 
  AND l.action = 'viewed' 
GROUP BY m.name, cm.module 
ORDER BY Vistas DESC