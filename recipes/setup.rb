home = platform?('windows') ? node['sikulix']['windows']['home'] : node['sikulix']['linux']['home']
java = platform?('windows') ? node['sikulix']['windows']['java'] : node['sikulix']['linux']['java']

directory home do
  recursive true
  mode '0775'
  action :create
end

node['sikulix']['packages']['debian'].each do |pkg|
  package(pkg)
end if platform_family?('debian')

remote_file "#{home}/sikulixsetup.jar" do
  source node['sikulix']['src']['sikulixsetup']
end

opts = []
opts << '1.1' if node['sikulix']['setup']['ide_jython'] == true
opts << '1.2' if node['sikulix']['setup']['ide_jruby'] == true
opts << '1.3' if node['sikulix']['setup']['ide_jruby_addons'] == true
opts << '2' if node['sikulix']['setup']['java_api'] == true
opts << '3' if node['sikulix']['setup']['tesseract_ocr'] == true
opts << '4' if node['sikulix']['setup']['system_all'] == true
opts << '4.1' if node['sikulix']['setup']['system_windows'] == true
opts << '4.2' if node['sikulix']['setup']['system_mac'] == true
opts << '4.3' if node['sikulix']['setup']['system_linux'] == true
opts << '5' if node['sikulix']['setup']['remoteserver'] == true

execute "\"#{java}\" -jar \"#{home}/sikulixsetup.jar\" options #{opts.join(' ')}"
