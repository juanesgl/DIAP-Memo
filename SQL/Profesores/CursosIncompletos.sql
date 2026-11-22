SELECT 
    c.fullname AS Curso,
    CONCAT('%%WWWROOT%%/course/view.php%%Q%%id=', c.id) AS Curso_link_url
FROM prefix_course c
JOIN prefix_context ctx ON ctx.instanceid = c.id AND ctx.contextlevel = 50
JOIN prefix_role_assignments ra ON ra.contextid = ctx.id AND ra.userid = %%USERID%%
WHERE c.visible = 1
  AND NOT EXISTS (
      SELECT 1 
      FROM prefix_resource r 
      WHERE r.course = c.id AND (LOWER(r.name) LIKE '%syllabus%' OR LOWER(r.name) LIKE '%programa%')
  )