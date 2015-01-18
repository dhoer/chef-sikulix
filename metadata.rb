name 'sikulix'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs/Configures SikuliX'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.1'

supports 'windows'
supports 'ubuntu'

suggests 'apt', '~> 2.6'
suggests 'java', '~> 1.29'
suggests 'aws', '~> 2.5' # https://github.com/agileorbit-cookbooks/java#windows
suggests 'windows', '~> 1.34'
