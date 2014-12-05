java = platform?('windows') ? node['sikulix']['windows']['java'] : node['sikulix']['linux']['java']

if platform?('windows')
  node.set['sikulix']['setup']['remoteserver'] = true

  include_recipe 'sikulix::default'

  startup = "C:\\Users\\#{node['sikulix']['username']}\\AppData\\Roaming\\Microsoft\\Windows"\
    '\\Start Menu\\Programs\\Startup\\sikulixremoteserver.lnk'

  home = platform?('windows') ? node['sikulix']['windows']['home'] : node['sikulix']['linux']['home']
  bin = "#{home}/bin"

  directory bin do
    action :create
  end

  cmd = "#{bin}/sikulixremoteserver.cmd"

  file cmd do
    content "\"#{java}\" #{node['sikulix']['remoteserver']['jvm_args']} -jar "\
      "\"#{home}/sikulixremoteserver.jar\" #{node['sikulix']['remoteserver']['port']}"
    action :create
    not_if { ::File.exist?(cmd) }
    notifies :request, 'windows_reboot[Reboot to start sikulixremoteserver]'
  end

  windows_shortcut startup do
    target cmd
    cwd home
    action :create
  end

  autologin_values = [
    { name: 'AutoAdminLogon', type: :string, data: '1' },
    { name: 'DefaultUsername', type: :string, data: node['sikulix']['username'] },
    { name: 'DefaultPassword', type: :string, data: node['sikulix']['password'] }
  ]

  autologin_values << {
    name: 'DefaultDomainName', type: :string, data: node['sikulix']['domain']
  } unless node['sikulix']['domain'].nil?

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

  windows_reboot 'Reboot to start sikulixremoteserver' do
    reason 'Reboot to start sikulixremoteserver'
    timeout node['windows']['reboot_timeout']
    action :nothing
  end
else
  log 'SikuliX Remote Server cannot be installed on this platform.' do
    level :warn
  end
end
