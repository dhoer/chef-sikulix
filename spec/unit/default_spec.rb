require 'spec_helper'

describe 'sikulix_test::default' do
  before do
    stub_command('netsh advfirewall firewall show rule name=sikulixremoteserver > nul').and_return(false)
    allow(::File).to receive(:exist?) { false }
  end

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['sikulix']['setup']['java_api'] = true
        node.set['sikulix']['windows']['home'] = 'C:/SikuliX'
        node.set['sikulix']['windows']['java'] = 'C:/java/bin/java.exe'
      end.converge(described_recipe)
    end

    it 'creates sikulix home directory' do
      expect(chef_run).to create_directory('C:/SikuliX')
    end

    it 'downloads sikulix setup' do
      expect(chef_run).to create_remote_file('C:/SikuliX/sikulixsetup-1.1.0.jar')
    end

    it 'executes sikulix setup with options' do
      expect(chef_run).to run_execute("\"C:/java/bin/java.exe\" -jar \"C:/SikuliX/sikulixsetup-1.1.0.jar\" options 2")
    end

    it 'creates SIKULIX_HOME' do
      expect(chef_run).to create_env('SIKULIX_HOME')
    end
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.set['sikulix']['username'] = 'username'
        node.set['sikulix']['setup']['java_api'] = true
      end.converge(described_recipe)
    end

    it 'installs wmctrl package' do
      expect(chef_run).to install_package('wmctrl')
    end

    it 'installs xdotool package' do
      expect(chef_run).to install_package('xdotool')
    end

    it 'installs libopencv-dev package' do
      expect(chef_run).to install_package('libopencv-dev')
    end

    it 'installs libtesseract-dev package' do
      expect(chef_run).to install_package('libtesseract-dev')
    end

    it 'creates sikulix home directory' do
      expect(chef_run).to create_directory('/home/username/SikuliX')
    end

    it 'downloads sikulix setup' do
      expect(chef_run).to create_remote_file('/home/username/SikuliX/sikulixsetup-1.1.0.jar')
        .with(source: 'https://launchpad.net/sikuli/sikulix/1.1.0/+download/sikulixsetup-1.1.0.jar')
    end

    it 'executes sikulix setup with java_api option' do
      expect(chef_run).to run_execute(
          "\"/usr/bin/java\" -jar \"/home/username/SikuliX/sikulixsetup-1.1.0.jar\" options 2")
    end

    it 'executes chown on directory' do
      expect(chef_run).to run_execute('chown -R username /home/username/SikuliX')
    end
  end

  context 'no options' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe)
    end

    it 'fails' do
      expect { chef_run }.to raise_error(RuntimeError, 'SikuliX setup has no options selected!')
    end
  end
end
