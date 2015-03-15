# To replace keystone::endpoints
# wrapping custom resource into a class
class keystone_extra {
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
