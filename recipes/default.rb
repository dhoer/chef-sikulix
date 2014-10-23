directory node['sikulix']['home'] do
  recursive true
  action :create
end

sikulixsetup_path = "#{node['sikulix']['home']}/sikulixsetup.jar"

remote_file sikulixsetup_path do
  source node['sikulix']['src']
  notifies :run, 'batch[sikulix_setup]'
end

opts = []
opts << '1.1' if node['sikulix']['setup']['ide_scripting']['jython']
opts << '1.2' if node['sikulix']['setup']['ide_scripting']['jruby']
opts << '1.3' if node['sikulix']['setup']['ide_scripting']['jruby_addons']
opts << '2' if node['sikulix']['setup']['java_api']
opts << '3' if node['sikulix']['setup']['tesseract_ocr']
opts << '4' if node['sikulix']['setup']['system']['all']
opts << '4.1' if node['sikulix']['setup']['system']['windows']
opts << '4.2' if node['sikulix']['setup']['system']['mac']
opts << '4.3' if node['sikulix']['setup']['system']['linux']
opts << '5' if node['sikulix']['setup']['remoteserver']

batch 'sikulix_setup' do
  code <<-EOH
    java #{node['sikulix']['setup']['jvm_args']} -jar "#{sikulixsetup_path}" options #{opts.join(' ')}
  EOH
end
