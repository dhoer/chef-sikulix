home = platform?('windows') ? node['sikulix']['windows']['home'] : node['sikulix']['linux']['home']

directory home do
  recursive true
  action :create
end

unless platform?('windows')
  package 'unzip'
  directory "#{home}/libs"
  include_recipe 'sikulix::__libvisionproxy'
  include_recipe 'sikulix::__libjxgrabkey'
end

remote_file "#{home}/sikulixsetup.jar" do
  source node['sikulix']['src']['sikulixsetup']
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

execute "\"#{java}\" -jar \"#{home}/sikulixsetup.jar\" options #{opts.join(' ')}"
