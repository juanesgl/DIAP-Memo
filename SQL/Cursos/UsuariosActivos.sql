SELECT 
    COUNT(DISTINCT l.userid) AS Usuarios_Unicos_Conectados
FROM prefix_logstore_standard_log l
JOIN prefix_user u ON l.userid = u.id
WHERE l.action = 'loggedin'
  AND l.target = 'user'
  AND u.deleted = 0
  AND u.suspended = 0
  AND l.timecreated >= :desde_date
  AND l.timecreated <= :hasta_date