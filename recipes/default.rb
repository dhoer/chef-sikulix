include_recipe 'sikulix::setup'
include_recipe 'sikulix::remoteserver' if node['sikulix']['setup']['remoteserver'] == true
