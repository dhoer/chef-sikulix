name 'sikulix'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs/Configures SikuliX'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '3.1.0'

supports 'windows'
supports 'mac_os_x'
supports 'ubuntu'

depends 'apt', '~> 2.6'
depends 'windows', '~> 1.34'

source_url 'https://github.com/dhoer/chef-sikulix' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-sikulix/issues' if respond_to?(:issues_url)
