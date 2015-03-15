define role
{
  $node_classes = hiera("${name}_classes", '')
  if $node_classes {
    include $node_classes
    $s = join($node_classes, ' ')
    notice("Class(es): ${s}")
  }
}

class keystone_extras {
  $public_url   = hiera('control_public')
  $internal_url = hiera('control_internal')
  $admin_url    = hiera('control_admin')
  $password     = hiera('admin_password')

  keystone::resource::service_identity { 'keystone':
    public_url          => "http://${public_url}:5000/v2.0",
    internal_url        => "http://${internal_url}:35357/v2.0",
    admin_url           => "http://${admin_url}:5000/v2.0",
    service_type        => 'identity',
    service_description => 'OpenStack Identity Service',
    service_name        => 'services',
    email               => 'admin@example.com',
    auth_name           => 'admin',
    password            => $password,
  }
}

node /aio/ {
  role {'mysql':}
  role {'keystone':}
  role {'rabbitmq':}
  role {'glance_control':}
  role {'nova_core':}
  role {'nova_control':}
  role {'nova_compute':}
  role {'nova_neutron':}
  role {'nova_neutron_compute':}
  role {'neutron_core':}
  role {'neutron_control':}
  role {'neutron_ml2':}
#  role {'horizon':}
#  role {'memcached':}
}

node /control/ {
  role {'mysql':}
  role {'keystone':}
  role {'rabbitmq':}
#  role {'glance_control':}
#  role {'nova_core':}
#  role {'nova_control':}
#  role {'nova_neutron':}
#  role {'neutron_core':}
#  role {'neutron_control':}
#  role {'neutron_ml2':}
#  role {'horizon':}
#  role {'memcached':}
}

node /compute/ {
  role {'nova_core':}
  role {'nova_compute':}
  role {'nova_neutron':}
  role {'nova_neutron_compute':}
  role {'neutron_core':}
  role {'neutron_ml2':}
}
