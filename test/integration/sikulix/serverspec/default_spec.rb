require 'serverspec_helper'

describe 'sikulix_test::default' do
  if os[:family] == 'windows'
    describe file('C:/SikuliX/sikulix-1.1.0/SikuliX-1.1.0-SetupLog.txt') do
      it { should be_file }
    end

    describe file('C:/SikuliX/sikulix-1.1.0/sikulixsetup-1.1.0.jar') do
      it { should be_file }
    end

    describe file('/opt/sikulix/sikulix-1.1.0/runsikulix.cmd') do
      it { should be_file }
    end

    describe file('C:/SikuliX/sikulix-1.1.0/sikulix.jar') do
      it { should be_file }
    end

    describe file('C:/SikuliX/sikulix-1.1.0/sikulixapi.jar') do
      it { should be_file }
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
  end
end
