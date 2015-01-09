node.set['sikulix']['setup']['java_api'] = true # (2)

include_recipe 'apt' unless platform?('windows') # performs apt-get update
include_recipe 'windows' if platform?('windows')
include_recipe 'java'
include_recipe 'sikulix'
