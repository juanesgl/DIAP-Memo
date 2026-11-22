SELECT 
    m.name AS Actividad_o_Recurso,
    COUNT(cm.id) AS Total_Utilizados
FROM prefix_course_modules cm
JOIN prefix_modules m ON cm.module = m.id
JOIN prefix_course c ON cm.course = c.id
WHERE c.visible = 1
GROUP BY m.name
ORDER BY Total_Utilizados DESC