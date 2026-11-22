SELECT 
    l.action AS Accion,
    l.ip AS Direccion_IP,
    FROM_UNIXTIME(l.timecreated) AS registro_date
FROM {logstore_standard_log} l
WHERE l.userid = %%USERID%%
  AND l.action IN ('loggedin', 'loggedout')
ORDER BY l.timecreated DESC