require 'spec_helper'

describe 'sikulix::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'creates sikulix home directory' do
    expect(chef_run).to create_directory('C:/sikulix')
  end

  it 'downloads sikulix setup' do
    expect(chef_run).to create_remote_file('C:/sikulix/sikulixsetup.jar').with(
      source: 'http://nightly.sikuli.de/sikulixsetup-1.1.0.jar')
  end

  it 'executes sikulix setup' do
    expect(chef_run).to run_batch('setup_sikulix').with(
      code: %r{java -jar "C:/sikulix/sikulixsetup.jar" options 2})
  end
end
