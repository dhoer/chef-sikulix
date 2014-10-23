require 'spec_helper'

describe 'sikulix::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['sikulix']['setup']['java_api'] = true
    end.converge(described_recipe)
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
      code: %r{java -Xmx128m -jar "C:/sikulix/sikulixsetup.jar" options 2})
  end
end
