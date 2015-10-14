require 'spec_helper'

describe 'sikulix_test::default' do
  before do
    stub_command('netsh advfirewall firewall show rule name=sikulixremoteserver > nul').and_return(false)
    allow(::File).to receive(:exist?) { false }
  end

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['java']['windows']['url'] = 'https://s3.amazonaws.com/prsnpublic/jdk-7u72-windows-i586.exe'
        node.set['sikulix']['setup']['java_api'] = true
        node.set['sikulix']['username'] = 'username'
        node.set['sikulix']['password'] = 'password'
      end.converge(described_recipe)
    end

    it 'creates sikulix home directory' do
      expect(chef_run).to create_directory('C:/sikulix-1.1.0')
    end

    it 'downloads sikulix setup' do
      expect(chef_run).to create_remote_file('C:/sikulix-1.1.0/sikulixsetup-1.1.0.jar')
    end

    it 'executes sikulix setup with options' do
      expect(chef_run).to run_execute(
        "\"C:/Windows/System32/java.exe\" -jar \"C:/sikulix/sikulixsetup-1.1.0.jar\" options 2")
    end

    it 'creates sikulix link to home directory' do
      expect(chef_run).to create_link('C:/sikulix').with(to: 'C:/sikulix-1.1.0')
    end
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
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
      expect(chef_run).to create_directory('/usr/local/sikulix-1.1.0')
    end

    it 'downloads sikulix setup' do
      expect(chef_run).to create_remote_file('/usr/local/sikulix-1.1.0/sikulixsetup-1.1.0.jar')
        .with(source: 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar')
    end

    it 'executes sikulix setup with java_api option' do
      expect(chef_run).to run_execute(
        "\"/usr/bin/java\" -jar \"/usr/local/sikulix/sikulixsetup-1.1.0.jar\" options 2")
    end

    it 'creates sikulix link to home directory' do
      expect(chef_run).to create_link('/usr/local/sikulix')
        .with(to: '/usr/local/sikulix-1.1.0')
    end
  end

  context 'no_opts' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe)
    end

    it 'writes a log warning' do
      expect(chef_run).to write_log('SikuliX setup has no options selected - nothing to do').with(level: :warn)
    end
  end
end
