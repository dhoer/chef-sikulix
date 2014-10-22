node.set['sikulix']['option']['remoteserver'] = true

include_recipe 'sikulix::default'

startup = "C:\\Users\\#{node['sikulix']['remoteserver']['username']}\\AppData\\Roaming\\Microsoft\\Windows"\
  '\\Start Menu\\Programs\\Startup\\sikulixremoteserver.lnk'

bin = "#{node['sikulix']['home']}/bin"

directory bin do
  action :create
end

cmd = "#{bin}/sikulixremoteserver.cmd"

file cmd do
  content %(java -jar "#{node['sikulix']['home']}/sikulixremoteserver.jar" #{node['sikulix']['remoteserver']['port']})
  action :create
  not_if { ::File.exist?(cmd) }
  notifies :request, 'windows_reboot[run sikulixremoteserver in foreground]'
end

windows_shortcut startup do
  target cmd
  cwd node['sikulix']['home']
  action :create
end

autologin_values = [
  { name: 'AutoAdminLogon', type: :string, data: '1' },
  { name: 'DefaultUsername', type: :string, data: node['sikulix']['remoteserver']['username'] },
  { name: 'DefaultPassword', type: :string, data: node['sikulix']['remoteserver']['password'] }
]

autologin_values << {
  name: 'DefaultDomainName', type: :string, data: node['sikulix']['remoteserver']['domain']
} unless node['sikulix']['remoteserver']['domain'].nil?

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' do
  values autologin_values
  action :create
end

execute "Firewall rule sikulixremoteserver for port #{node['sikulix']['remoteserver']['port']}" do
  command 'netsh advfirewall firewall add rule name=sikulixremoteserver protocol=TCP dir=in profile=any'\
          " localport=#{node['sikulix']['remoteserver']['port']} remoteip=any localip=any action=allow"
  action :run
  not_if 'netsh advfirewall firewall show rule name=sikulixremoteserver > nul'
end

include_recipe 'windows::reboot_handler'

windows_reboot 'run sikulixremoteserver in foreground' do
  reason 'Reboot to start sikulixremoteserver'
  timeout node['windows']['reboot_timeout']
  action :nothing
end
