require 'serverspec_helper'

describe 'sikulix_test::default' do
  if os[:family] == 'windows'
    describe file('C:/SikuliX/SikuliX-1.1.0-SetupLog.txt') do
      it { should be_file }
    end

    describe file('C:/SikuliX/sikulixsetup-1.1.0.jar') do
      it { should be_file }
    end

    describe file('C:/SikuliX/runsikulix.cmd') do
      it { should be_file }
    end

    describe file('C:/SikuliX/sikulix.jar') do
      it { should be_file }
    end

    describe file('C:/SikuliX/sikulixapi.jar') do
      it { should be_file }
    end

    describe command('C:\SikuliX\runsikulix.cmd -h') do
      its(:stdout) { should match(/Running SikuliX/) }
    end
  else
    describe file('/home/vagrant/SikuliX/SikuliX-1.1.0-SetupLog.txt') do
      it { should be_file }
      it { should be_owned_by 'vagrant' }
    end

    describe file('/home/vagrant/SikuliX/sikulixsetup-1.1.0.jar') do
      it { should be_file }
      it { should be_owned_by 'vagrant' }
    end

    describe file('/home/vagrant/SikuliX/runsikulix') do
      it { should be_file }
      it { should be_owned_by 'vagrant' }
    end

    describe file('/home/vagrant/SikuliX/sikulix.jar') do
      it { should be_file }
      it { should be_owned_by 'vagrant' }
    end

    describe file('/home/vagrant/SikuliX/sikulixapi.jar') do
      it { should be_file }
      it { should be_owned_by 'vagrant' }
    end

    describe command('/home/vagrant/SikuliX/runsikulix -h') do
      its(:stdout) { should match(/running SikuliX/) }
    end
  end
end
