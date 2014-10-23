default['sikulix']['src'] = 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar'
default['sikulix']['home'] = 'C:/sikulix'

# SETUP

default['sikulix']['setup']['ide_scripting']['jython'] = false # (1.1)
default['sikulix']['setup']['ide_scripting']['jruby'] = false # (1.2)
default['sikulix']['setup']['ide_scripting']['jruby_addons'] = false # (1.3)
default['sikulix']['setup']['java_api'] = false # (2)
default['sikulix']['setup']['tesseract_ocr'] = false # (3)
default['sikulix']['setup']['system']['all'] = false  # (4)
default['sikulix']['setup']['system']['windows'] = false # (4.1)
default['sikulix']['setup']['system']['mac'] = false # (4.2)
default['sikulix']['setup']['system']['linux'] = false # (4.3)
default['sikulix']['setup']['remoteserver'] = false # (5)
default['sikulix']['setup']['jvm_args'] = '-Xmx128m'

# REMOTE SERVER

default['sikulix']['remoteserver']['domain'] = nil
default['sikulix']['remoteserver']['username'] = nil
default['sikulix']['remoteserver']['password'] = nil
default['sikulix']['remoteserver']['jvm_args'] = nil
default['sikulix']['remoteserver']['port'] = 4041
