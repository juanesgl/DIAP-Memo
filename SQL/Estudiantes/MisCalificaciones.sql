SELECT 
    c.fullname AS Curso, 
    gi.itemname AS Item_Evaluado, 
    gg.finalgrade AS Calificacion, 
    gg.timemodified AS modificacion_date 
FROM prefix_grade_grades gg 
JOIN prefix_grade_items gi ON gg.itemid = gi.id 
JOIN prefix_course c ON gi.courseid = c.id 
WHERE gg.userid = %%USERID%% 
  AND gi.itemtype IN ('mod', 'course') 
  AND gg.finalgrade IS NOT NULL
ORDER BY c.fullname, gi.itemname