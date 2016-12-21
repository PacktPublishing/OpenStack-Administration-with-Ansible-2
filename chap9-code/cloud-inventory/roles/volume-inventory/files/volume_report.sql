USE cinder;
SELECT volumes.id, volumes.display_name as volume_name, volumes.size as size_GB, volume_types.name as volume_type, keystone.project.name as tenant from volumes
INNER JOIN keystone.project ON volumes.project_id=keystone.project.id 
INNER JOIN volume_types ON volumes.volume_type_id=volume_types.id
WHERE volumes.status='available' 
ORDER BY tenant;
SELECT SUM(volumes.size) as volume_usage_GB, keystone.project.name as tenant from volumes
INNER JOIN keystone.project ON volumes.project_id=keystone.project.id
WHERE volumes.status='available' 
GROUP BY tenant;
SELECT volume_types.name as volume_type, SUM(volumes.size) as volume_usage_GB from volumes
INNER JOIN volume_types ON volumes.volume_type_id=volume_types.id
WHERE volumes.status='available' 
GROUP BY volume_type;