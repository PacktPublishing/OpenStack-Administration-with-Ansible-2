USE keystone;
SELECT count(*) as total_users from user WHERE user.enabled=1;
SELECT count(*) as total_projects from project WHERE project.enabled=1;
USE cinder;
SELECT count(*) as total_volumes, SUM(volumes.size) as total_volume_usage_GB from volumes
WHERE volumes.status='available';
USE neutron;
SELECT count(*) as total_networks from networks WHERE networks.status='ACTIVE';
USE nova;
SELECT SUM(instances.vcpus) as total_vCPU, SUM(instances.memory_mb) as total_memory_MB, SUM(instances.root_gb) as total_disk_GB from instances
WHERE instances.vm_state='active';