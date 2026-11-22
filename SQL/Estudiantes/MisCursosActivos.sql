SELECT 
    c.fullname AS Curso, 
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url, 
    c.startdate AS inicio_date 
FROM prefix_course c 
JOIN prefix_context ctx ON ctx.instanceid = c.id 
JOIN prefix_role_assignments ra ON ra.contextid = ctx.id 
WHERE ctx.contextlevel = 50 
  AND ra.userid = %%USERID%% 
  AND c.visible = 1
ORDER BY c.startdate DESC