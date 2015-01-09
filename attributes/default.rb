default['sikulix']['src']['sikulixsetup'] = 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar'

default['sikulix']['windows']['home'] = 'C:'
default['sikulix']['windows']['java'] = 'C:/Windows/System32/java.exe'

default['sikulix']['linux']['home'] = '/usr/local'
default['sikulix']['linux']['java'] = '/usr/bin/java'

default['sikulix']['packages']['debian'] = %w(wmctrl libopencv-dev libtesseract-dev)

# Setup

default['sikulix']['setup']['ide_jython'] = false # (1.1)
default['sikulix']['setup']['ide_jruby'] = false # (1.2)
default['sikulix']['setup']['java_api'] = false # (2)
default['sikulix']['setup']['tesseract_ocr'] = false # (3)
default['sikulix']['setup']['system_all'] = false  # (4)
default['sikulix']['setup']['system_windows'] = false # (4.1)
default['sikulix']['setup']['system_mac'] = false # (4.2)
default['sikulix']['setup']['system_linux'] = false # (4.3)
