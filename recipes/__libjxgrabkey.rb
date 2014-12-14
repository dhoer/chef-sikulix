home = node['sikulix']['linux']['home']

bz2 = "#{home}/jxgrabkey-0.3.2_src.tar.bz2"

remote_file bz2 do
  source node['sikulix']['src']['libjxgrabkey']
  mode '0755'
end

execute "tar xvjf #{bz2}" do
  cwd home
end

execute "chmod -R 755 #{home}/jxgrabkey-0.3.2 && chown -R root:root #{home}/jxgrabkey-0.3.2"

# Ubuntu 14.x usleep not found: include unistd.h
execute "echo '#include <unistd.h>'|cat - JXGrabKey.cpp > /tmp/out && mv /tmp/out JXGrabKey.cpp" do
  cwd "#{home}/jxgrabkey-0.3.2/JXGrabKey/C++/src"
end

execute 'chmod +x Makefile && make' do
  cwd "#{home}/jxgrabkey-0.3.2/JXGrabKey/C++"
end

execute "cp #{home}/jxgrabkey-0.3.2/JXGrabKey/C++/dist/Debug/GNU-Linux-x86/libJXGrabKey.so #{home}/libs"