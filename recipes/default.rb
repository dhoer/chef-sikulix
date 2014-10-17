directory node['sikulix']['home'] do
  recursive true
  action :create
end

sikulixsetup_path = "#{node['sikulix']['home']}/sikulixsetup.jar"

remote_file sikulixsetup_path do
  source node['sikulix']['src']
end

opts = []
opts << '1.1' if node['sikulix']['option']['ide_scripting']['jython']
opts << '1.2' if node['sikulix']['option']['ide_scripting']['jruby']
opts << '1.3' if node['sikulix']['option']['ide_scripting']['jruby_addons']
opts << '2' if node['sikulix']['option']['java_api']
opts << '3' if node['sikulix']['option']['tesseract_ocr']
opts << '4' if node['sikulix']['option']['system']['all']
opts << '4.1' if node['sikulix']['option']['system']['windows']
opts << '4.2' if node['sikulix']['option']['system']['mac']
opts << '4.3' if node['sikulix']['option']['system']['linux']
opts << '5' if node['sikulix']['option']['remote_server'] || node.recipes.include?('sikulix::remoteserver')

batch 'setup_sikulix' do
  code <<-EOH
    java -jar "#{sikulixsetup_path}" options #{opts.join(' ')}
  EOH
end
