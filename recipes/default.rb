home = platform?('windows') ? node['sikulix']['windows']['home'] : node['sikulix']['linux']['home']
java = platform?('windows') ? node['sikulix']['windows']['java'] : node['sikulix']['linux']['java']

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

if platform?('windows')
  env 'SIKULIX_HOME' do
    value home
  end
else
  execute "chown -R #{node['sikulix']['username']} #{home}" do
    only_if { platform_family?('debian') }
  end
end
