require 'spec_helper'

describe 'sikulix_test::remoteserver' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['java']['windows']['url'] = 'https://s3.amazonaws.com/prsnpublic/jdk-7u72-windows-i586.exe'
        node.set['sikulix']['username'] = 'username'
        node.set['silulix']['password'] = 'password'
      end.converge(described_recipe)
    end

    before do
      stub_command('netsh advfirewall firewall show rule name=sikulixremoteserver > nul').and_return(false)
      allow(::File).to receive(:exist?) { false }
    end

    it 'executes sikulix setup with java_api option' do
      expect(chef_run).to run_batch('sikulix_setup').with(
        code: %r{"C:/Windows/System32/java.exe" -jar "C:/sikulix/sikulixsetup.jar" options 5})
    end

    it 'creates sikulix bin directory' do
      expect(chef_run).to create_directory('C:/sikulix/bin')
    end

    it 'creates sikulix cmd file' do
      expect(chef_run).to create_file('C:/sikulix/bin/sikulixremoteserver.cmd').with(
        content: '"C:/Windows/System32/java.exe"  -jar "C:/sikulix/sikulixremoteserver.jar" 4041'
      )
    end

    it 'creates auto login registry_key' do
      expect(chef_run).to create_registry_key(
        'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
      )
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

  context 'non-windows' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

    it 'warns if non-windows platform' do
      expect(chef_run).to write_log('SikuliX Remote Server cannot be installed on this platform.').with(
        level: :warn
      )
    end
  end

end
