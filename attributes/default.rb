default['sikulix']['src'] = 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar'
default['sikulix']['home'] = 'C:/sikulix'

### OPTIONS

# Pack1: I want SikuliX, containing the Sikuli IDE and allowing to run Sikuli scripts from commandline
default['sikulix']['option']['ide_scripting']['jython'] = false # (1.1)
default['sikulix']['option']['ide_scripting']['jruby'] = false # (1.2)
default['sikulix']['option']['ide_scripting']['jruby_addons'] = false # rspec, cucumber, ... (1.3)

# Pack2: I want to develop in Java, Jython or other Java aware scripting language using NetBeans, Eclipse, or
# other IDE's
default['sikulix']['option']['java_api'] = false # (2)

# For Mac and Windows only: I plan to use the Tesseract based OCR features (You Should know what you are doing!)
default['sikulix']['option']['tesseract_ocr'] = false # (3)

# I want the packages to be usable on Windows, Mac, Linux (they contain the stuff for all systems - one pack for all)
# With this option not selected, the setup process will only add system specific native stuff (Windows: support for
# both Java 32-Bit and Java 64-Bit is added)
default['sikulix']['option']['system']['all'] = false  # (4)
default['sikulix']['option']['system']['windows'] = false # (4.1)
default['sikulix']['option']['system']['mac'] = false # (4.2)
default['sikulix']['option']['system']['linux'] = false # (4.3)

# I want to try the experimental Sikuli Remote feature (getting sikulixremoteserver.jar)
default['sikulix']['option']['remoteserver'] = false # (5)

### REMOTE SERVER

default['sikulix']['remoteserver']['domain'] = nil
default['sikulix']['remoteserver']['username'] = nil
default['sikulix']['remoteserver']['password'] = nil
default['sikulix']['remoteserver']['port'] = 4041
