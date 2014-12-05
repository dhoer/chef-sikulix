if platform_family?('debian')
  package 'libopencv-dev'
  package 'libtesseract-dev'
  user node['sikulix']['username']
end

home = platform?('windows') ? node['sikulix']['windows']['home'] : node['sikulix']['linux']['home']

directory home do
  recursive true
  owner node['sikulix']['username'] unless platform?('windows')
  action :create
end

sikulixsetup_path = "#{home}/sikulixsetup.jar"

remote_file sikulixsetup_path do
  source node['sikulix']['src']
end

opts = []
opts << '1.1' if node['sikulix']['setup']['ide_jython']
opts << '1.2' if node['sikulix']['setup']['ide_jruby']
opts << '1.3' if node['sikulix']['setup']['ide_jruby_addons']
opts << '2' if node['sikulix']['setup']['java_api']
opts << '3' if node['sikulix']['setup']['tesseract_ocr']
opts << '4' if node['sikulix']['setup']['system_all']
opts << '4.1' if node['sikulix']['setup']['system_windows']
opts << '4.2' if node['sikulix']['setup']['system_mac']
opts << '4.3' if node['sikulix']['setup']['system_linux']
opts << '5' if node['sikulix']['setup']['remoteserver']

java = platform?('windows') ? node['sikulix']['windows']['java'] : node['sikulix']['linux']['java']
cmd = "\"#{java}\" -jar \"#{sikulixsetup_path}\" options #{opts.join(' ')}"

batch 'sikulix_setup' do
  code cmd
  action :run
  only_if { platform?('windows') }
end

execute 'sikulix_setup' do
  command cmd
  action :run
  not_if { platform?('windows') }
end
