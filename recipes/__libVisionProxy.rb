package 'libopencv-dev'
package 'libtesseract-dev'

home = node['sikulix']['linux']['home']
zip = "#{home}/Sikuli-1.0.1-Supplemental-LinuxVisionProxy.zip"

remote_file zip do
  source node['sikulix']['src']['libvisionproxy']
  mode '0755'
end

execute "unzip -o #{zip}" do
  cwd home
end

execute "chmod -R 755 #{home}/Sikuli-1.0.1-Supplemental-LinuxVisionProxy"

execute 'chmod +x makeVisionProxy && libFolderO=/usr/lib/x86_64-linux-gnu libFolderT=/usr/lib ./makeVisionProxy' do
  cwd "#{home}/Sikuli-1.0.1-Supplemental-LinuxVisionProxy"
end

execute "cp #{home}/Sikuli-1.0.1-Supplemental-LinuxVisionProxy/dist/libVisionProxy.so #{home}/libs"
