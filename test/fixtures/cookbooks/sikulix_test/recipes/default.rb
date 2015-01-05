node.set['sikulix']['setup']['ide_jython'] = true # (1.1)
node.set['sikulix']['setup']['ide_jruby'] = true # (1.2)
node.set['sikulix']['setup']['ide_jruby_addons'] = true # (1.3)
node.set['sikulix']['setup']['java_api'] = true # (2)
node.set['sikulix']['setup']['tesseract_ocr'] = true # (3)
node.set['sikulix']['setup']['system_all'] = true  # (4)
node.set['sikulix']['setup']['system_windows'] = true # (4.1)
node.set['sikulix']['setup']['system_mac'] = true # (4.2)
node.set['sikulix']['setup']['system_linux'] = true # (4.3)
node.set['sikulix']['setup']['remoteserver'] = true # (5)

include_recipe 'apt' unless platform?('windows') # performs apt-get update
include_recipe 'windows' if platform?('windows')
include_recipe 'java'
include_recipe 'xvfb' unless platform?('windows')
include_recipe 'sikulix'
