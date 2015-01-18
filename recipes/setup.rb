root = platform?('windows') ? node['sikulix']['windows']['root'] : node['sikulix']['linux']['root']
java = platform?('windows') ? node['sikulix']['windows']['java'] : node['sikulix']['linux']['java']

match = /.*\/(.*).jar/.match(node['sikulix']['src']['sikulixsetup']).captures[0]
v = /.*\-(\d|.*).jar/.match(node['sikulix']['src']['sikulixsetup']).captures[0]
dir = "#{root}/sikulix-#{v}"
link = "#{root}/sikulix"

directory dir do
  recursive true
  mode '0775'
  action :create
end

link link do
  to dir
end

node['sikulix']['packages']['debian'].each do |pkg|
  package(pkg)
end if platform_family?('debian')

remote_file "#{dir}/#{match}.jar" do
  source node['sikulix']['src']['sikulixsetup']
end

opts = []
opts << '1.1' if node['sikulix']['setup']['ide_jython'] == true
opts << '1.2' if node['sikulix']['setup']['ide_jruby'] == true
opts << '2' if node['sikulix']['setup']['java_api'] == true
opts << '3' if node['sikulix']['setup']['tesseract_ocr'] == true
opts << '4' if node['sikulix']['setup']['system_all'] == true
opts << '4.1' if node['sikulix']['setup']['system_windows'] == true
opts << '4.2' if node['sikulix']['setup']['system_mac'] == true
opts << '4.3' if node['sikulix']['setup']['system_linux'] == true
opts << 'buildv' if node['sikulix']['setup']['buildv'] == true
opts << 'notest' if node['sikulix']['setup']['notest'] == true
opts << 'clean' if node['sikulix']['setup']['clean'] == true

execute "\"#{java}\" -jar \"#{link}/#{match}.jar\" options #{opts.join(' ')}"
