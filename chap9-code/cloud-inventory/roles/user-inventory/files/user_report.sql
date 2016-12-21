USE keystone;
SELECT local_user.user_id, local_user.name as username, role.name as role, project.name as tenant from local_user 
INNER JOIN assignment ON 
local_user.user_id=assignment.actor_id INNER JOIN 
role ON assignment.role_id=role.id INNER JOIN
project ON assignment.target_id=project.id
ORDER BY tenant;