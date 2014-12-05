default['sikulix']['src'] = 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar'

default['sikulix']['windows']['home'] = 'C:/sikulix'
default['sikulix']['windows']['java'] = 'C:/Windows/System32/java.exe'

default['sikulix']['linux']['home'] = '/usr/local/sikulix'
default['sikulix']['linux']['java'] = '/usr/bin/java'

# Setup

default['sikulix']['setup']['ide_jython'] = false # (1.1)
default['sikulix']['setup']['ide_jruby'] = false # (1.2)
default['sikulix']['setup']['ide_jruby_addons'] = false # (1.3)
default['sikulix']['setup']['java_api'] = false # (2)
default['sikulix']['setup']['tesseract_ocr'] = false # (3)
default['sikulix']['setup']['system_all'] = false  # (4)
default['sikulix']['setup']['system_windows'] = false # (4.1)
default['sikulix']['setup']['system_mac'] = false # (4.2)
default['sikulix']['setup']['system_linux'] = false # (4.3)
default['sikulix']['setup']['remoteserver'] = false # (5)

# Remote Server

default['sikulix']['remoteserver']['jvm_args'] = nil
default['sikulix']['remoteserver']['port'] = 4041

# Windows Auto-Login

default['sikulix']['username'] = nil
default['sikulix']['password'] = nil
default['sikulix']['domain'] = nil
