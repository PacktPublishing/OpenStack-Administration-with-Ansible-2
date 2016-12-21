USE nova;
SELECT SUM(instances.vcpus) as vCPU, SUM(instances.memory_mb) as memory_MB, SUM(instances.root_gb) as disk_GB, keystone.project.name as tenant from instances
INNER JOIN keystone.project ON
instances.project_id=keystone.project.id 
WHERE instances.vm_state='active' GROUP BY tenant;