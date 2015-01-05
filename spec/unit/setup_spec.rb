require 'spec_helper'

describe 'sikulix::setup' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['java']['windows']['url'] = 'https://s3.amazonaws.com/prsnpublic/jdk-7u72-windows-i586.exe'
        node.set['sikulix']['setup']['java_api'] = true
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

    it 'executes sikulix setup with java_api option' do
      expect(chef_run).to run_execute(
        "\"C:/Windows/System32/java.exe\" -jar \"C:/sikulix/sikulixsetup.jar\" options 2"
      )
    end
  end

  context 'debian' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.set['sikulix']['setup']['java_api'] = true
      end.converge(described_recipe)
    end

    it 'installs unzip package' do
      expect(chef_run).to install_package('unzip')
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

    it 'creates sikulix libs directory' do
      expect(chef_run).to create_directory('/usr/local/sikulix/libs')
    end

    it 'downloads sikulix setup' do
      expect(chef_run).to create_remote_file('/usr/local/sikulix/sikulixsetup.jar').with(
        source: 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar'
      )
    end

    it 'executes sikulix setup with java_api option' do
      expect(chef_run).to run_execute(
        "\"/usr/bin/java\" -jar \"/usr/local/sikulix/sikulixsetup.jar\" options 2"
      )
    end
  end
end
