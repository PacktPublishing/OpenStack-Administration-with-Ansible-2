USE neutron;
SELECT networks.id, networks.name, subnets.name as subnet, subnets.cidr, networks.status, keystone.project.name as tenant from networks
INNER JOIN keystone.project ON networks.project_id COLLATE utf8_unicode_ci = keystone.project.id 
INNER JOIN subnets ON networks.id=subnets.network_id
ORDER BY tenant;