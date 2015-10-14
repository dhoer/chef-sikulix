default['sikulix']['setup']['url'] =
  'https://launchpad.net/sikuli/sikulix/1.1.0/+download/sikulixsetup-1.1.0.jar'

default['sikulix']['username'] = nil

default['sikulix']['windows']['root'] = 'C:/SikuliX'
default['sikulix']['windows']['java'] = 'C:/java/bin/java.exe'

default['sikulix']['linux']['root'] = "/home/#{node['sikulix']['username']}/SikuliX"
default['sikulix']['linux']['java'] = '/usr/bin/java'

default['sikulix']['packages']['debian'] = %w(wmctrl xdotool libopencv-dev libtesseract-dev)

# https://github.com/RaiMan/SikuliX-2014/blob/master/Setup/src/main/java/org/sikuli/setup/RunSetup.java
default['sikulix']['setup']['ide_jython'] = false # (1.1)
default['sikulix']['setup']['ide_jruby'] = false # (1.2)
default['sikulix']['setup']['java_api'] = false # (2)
default['sikulix']['setup']['tesseract_ocr'] = false # (3)
default['sikulix']['setup']['system_all'] = false  # (4)
default['sikulix']['setup']['buildv'] = false
default['sikulix']['setup']['notest'] = false
default['sikulix']['setup']['clean'] = false
