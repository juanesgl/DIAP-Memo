SELECT 
    c.shortname AS Curso,
    f.name AS Foro,
    CONCAT('%%WWWROOT%%/mod/forum/view.php%%Q%%f=', f.id) AS Foro_link_url,
    COUNT(DISTINCT fd.id) AS Hilos_Iniciados,
    COUNT(fp.id) AS Total_Respuestas
FROM prefix_forum f
JOIN prefix_course c ON f.course = c.id
JOIN prefix_context ctx ON ctx.instanceid = c.id AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra ON ra.contextid = ctx.id AND ra.userid = %%USERID%%
LEFT JOIN prefix_forum_discussions fd ON fd.forum = f.id
LEFT JOIN prefix_forum_posts fp ON fp.discussion = fd.id
GROUP BY c.id, c.shortname, f.id, f.name
ORDER BY Total_Respuestas DESC