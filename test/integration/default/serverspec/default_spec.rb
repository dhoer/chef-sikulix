require 'serverspec_helper'

describe 'sikulix_test::default' do
  case os[:family]
  when 'windows'
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
  when 'darwin'
    describe file('/opt/SikuliX/SikuliX-1.1.0-SetupLog.txt') do
      it { should be_file }
    end

    describe file('/opt/SikuliX/sikulixsetup-1.1.0.jar') do
      it { should be_file }
    end

    describe file('/opt/SikuliX/runsikulix') do
      it { should be_file }
    end

    describe file('/opt/SikuliX/sikulixapi.jar') do
      it { should be_file }
    end

    describe file('/opt/SikuliX/SikuliX.app') do
      it { should be_directory }
    end

    describe file('/Applications/SikuliX.app') do
      it { should be_directory }
    end

    describe command('/opt/SikuliX/runsikulix -h') do
      its(:stdout) { should match(/running SikuliX/) }
    end
  else
    describe file('/opt/SikuliX/SikuliX-1.1.0-SetupLog.txt') do
      it { should be_file }
    end

    describe file('/opt/SikuliX/sikulixsetup-1.1.0.jar') do
      it { should be_file }
    end

    describe file('/opt/SikuliX/runsikulix') do
      it { should be_file }
    end

    describe file('/opt/SikuliX/sikulix.jar') do
      it { should be_file }
    end

    describe file('/opt/SikuliX/sikulixapi.jar') do
      it { should be_file }
    end

    describe command('/opt/SikuliX/runsikulix -h') do
      its(:stdout) { should match(/running SikuliX/) }
    end
  end
end
