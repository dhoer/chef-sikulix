if platform?('windows')
  home = node['sikulix']['windows']['home']
  java = node['sikulix']['windows']['java']
else
  home = node['sikulix']['unix']['home']
  java = node['sikulix']['unix']['java']
end

match = %r{.*/(.*).jar}.match(node['sikulix']['setup']['url']).captures[0]

directory home do
  recursive true
  mode '0775'
  action :create
end

node['sikulix']['packages']['debian'].each do |pkg|
  package(pkg)
end if platform_family?('debian')

remote_file "#{home}/#{match}.jar" do
  source node['sikulix']['setup']['url']
end

opts = []
opts << '1.1' if node['sikulix']['setup']['ide_jython']
opts << '1.2' if node['sikulix']['setup']['ide_jruby']
opts << '2' if node['sikulix']['setup']['java_api']
opts << '3' if node['sikulix']['setup']['tesseract_ocr']
opts << '4' if node['sikulix']['setup']['system_all']

opts << 'buildv' if node['sikulix']['setup']['buildv']
opts << 'not' if node['sikulix']['setup']['notest']
opts << 'clean' if node['sikulix']['setup']['clean']

if opts.size == 0
  fail('SikuliX setup has no options selected!')
else
  execute "\"#{java}\" -jar \"#{home}/#{match}.jar\" options #{opts.join(' ')}"
end

case node['platform']
when 'mac_os_x'
  execute "chmod -R 755 #{home} && cp -R #{home}/SikuliX.app /Applications"
when 'windows'
  env 'SIKULIX_HOME' do
    value home
  end
else # linux
  execute "chmod -R 755 #{home}"
end
