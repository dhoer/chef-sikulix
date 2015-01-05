require 'spec_helper'

describe 'sikulix_test::default' do
  before do
    stub_command('netsh advfirewall firewall show rule name=sikulixremoteserver > nul').and_return(false)
    allow(::File).to receive(:exist?) { false }
  end

  context 'setup' do
    context 'windows' do
      let(:chef_run) do
        ChefSpec::Runner.new(platform: 'windows', version: '2008R2') do |node|
          node.set['java']['windows']['url'] = 'https://s3.amazonaws.com/prsnpublic/jdk-7u72-windows-i586.exe'
          node.set['sikulix']['setup']['java_api'] = true
          node.set['sikulix']['username'] = 'username'
          node.set['silulix']['password'] = 'password'
        end.converge(described_recipe)
      end

      it 'creates sikulix home directory' do
        expect(chef_run).to create_directory('C:/sikulix')
      end

      it 'downloads sikulix setup' do
        expect(chef_run).to create_remote_file('C:/sikulix/sikulixsetup.jar').with(
            source: 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar'
          )
      end

      it 'executes sikulix setup with options' do
        expect(chef_run).to run_execute(
          "\"C:/Windows/System32/java.exe\" -jar \"C:/sikulix/sikulixsetup.jar\""\
          ' options 1.1 1.2 1.3 2 3 4 4.1 4.2 4.3 5'
        )
      end
    end

    context 'ubuntu' do
      let(:chef_run) do
        ChefSpec::Runner.new(platform: 'ubuntu', version: '14.04') do |node|
          node.set['sikulix']['setup']['java_api'] = true
        end.converge(described_recipe)
      end

      it 'installs wmctrl package' do
        expect(chef_run).to install_package('wmctrl')
      end

      it 'installs libopencv-dev package' do
        expect(chef_run).to install_package('libopencv-dev')
      end

      it 'installs libtesseract-dev package' do
        expect(chef_run).to install_package('libtesseract-dev')
      end

      it 'creates sikulix home directory' do
        expect(chef_run).to create_directory('/usr/local/sikulix')
      end

      it 'downloads sikulix setup' do
        expect(chef_run).to create_remote_file('/usr/local/sikulix/sikulixsetup.jar').with(
            source: 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar'
          )
      end

      it 'executes sikulix setup with java_api option' do
        expect(chef_run).to run_execute(
            "\"/usr/bin/java\" -jar \"/usr/local/sikulix/sikulixsetup.jar\""\
          ' options 1.1 1.2 1.3 2 3 4 4.1 4.2 4.3 5'
          )
      end
    end
  end

  context 'remoteserver' do
    context 'windows' do
      let(:chef_run) do
        ChefSpec::Runner.new(platform: 'windows', version: '2008R2') do |node|
          node.set['java']['windows']['url'] = 'https://s3.amazonaws.com/prsnpublic/jdk-7u72-windows-i586.exe'
          node.set['sikulix']['username'] = 'username'
          node.set['silulix']['password'] = 'password'
        end.converge(described_recipe)
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

    context 'ubuntu' do
      let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

      it 'creates init.d' do
        expect(chef_run).to create_template('/etc/init.d/sikulixremoteserver').with(
            source: 'debian.erb',
            mode: '0755',
            variables: {
              jar: '/usr/local/sikulix/sikulixremoteserver.jar',
              port: 4041,
              display: ':0',
              java: '/usr/bin/java',
              jvm_args: nil
            }
          )
      end

      it 'creates service' do
        expect(chef_run).to start_service('sikulixremoteserver')
      end
    end

    context 'other' do
      let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '7.0').converge(described_recipe) }

      it 'warns if non-windows platform' do
        expect(chef_run).to write_log('SikuliX Remote Server cannot be installed on this platform.').with(
            level: :warn
          )
      end
    end
  end
end
