require 'spec_helper'

describe 'sikulix::remoteserver' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['sikulix']['remoteserver']['username'] = 'username'
      node.set['silulix']['remoteserver']['password'] = 'password'
    end.converge(described_recipe)
  end

  before do
    stub_command('netsh advfirewall firewall show rule name=sikulixremoteserver > nul').and_return(false)
    allow(::File).to receive(:exist?) { false }
  end

  it 'creates sikulix home directory' do
    expect(chef_run).to create_directory('C:/sikulix')
  end

  it 'downloads sikulix setup' do
    expect(chef_run).to create_remote_file('C:/sikulix/sikulixsetup.jar').with(
      source: 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar')
  end

  it 'executes sikulix setup with java_api option' do
    expect(chef_run).to run_batch('sikulix_setup').with(
      code: %r{java -Xmx128m -jar "C:/sikulix/sikulixsetup.jar" options 5})
  end

  it 'creates sikulix bin directory' do
    expect(chef_run).to create_directory('C:/sikulix/bin')
  end

  it 'creates sikulix cmd file' do
    expect(chef_run).to create_file('C:/sikulix/bin/sikulixremoteserver.cmd').with(
      content: 'java  -jar "C:/sikulix/sikulixremoteserver.jar" 4041'
    )
  end

  it 'creates auto login registry_key' do
    expect(chef_run).to create_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon')
  end

  it 'creates firewall rule' do
    expect(chef_run).to run_execute('Firewall rule sikulixremoteserver for port 4041')
  end

  it 'creates shortcut to cmd file' do
    expect(chef_run).to create_windows_shortcut(
      'C:\Users\username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\sikulixremoteserver.lnk'
    )
  end

  it 'reboots windows server' do
    expect(chef_run).to_not request_windows_reboot('Reboot to start sikulixremoteserver').with(
      timeout: 60
    )
  end
end
