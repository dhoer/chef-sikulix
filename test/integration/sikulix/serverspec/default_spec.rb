require 'serverspec_helper'

describe 'sikulix_test::default' do
  if os[:family] == 'windows'
    describe file('C:/sikulix/Downloads') do
      it { should be_directory }
    end

    describe file('C:/sikulix/Lib') do
      it { should be_directory }
    end

    describe file('C:/sikulix/libs') do
      it { should be_directory }
    end

    describe file('C:/sikulix/runsikulix.cmd') do
      it { should be_directory }
    end

    describe file('C:/sikulix/SikuliX-1.1.0-SetupLog.txt') do
      it { should be_directory }
    end

    describe file(' sikulixapi.jar') do
      it { should be_directory }
    end

    describe file('sikulix.jar') do
      it { should be_directory }
    end

    describe file('sikulixremoteserver.jar') do
      it { should be_directory }
    end

    describe file('sikulixsetup.jar') do
      it { should be_directory }
    end
  else
    describe file('/usr/local/sikulix/Downloads') do
      it { should be_directory }
    end

    describe file('/usr/local/sikulix/Lib') do
      it { should be_directory }
    end

    describe file('/usr/local/sikulix/libs/tessdata') do
      it { should be_directory }
    end

    describe file('/usr/local/sikulix/runsikulix') do
      it { should be_file }
    end

    describe file('/usr/local/sikulix/SikuliX-1.1.0-SetupLog.txt') do
      it { should be_file }
    end

    # describe file('/usr/local/sikulix/sikulixapi.jar') do
    #   it { should be_file }
    # end

    describe file('/usr/local/sikulix/sikulix.jar') do
      it { should be_file }
    end

    describe file('/usr/local/sikulix/sikulixremoteserver.jar') do
      it { should be_file }
    end

    describe file('/usr/local/sikulix/sikulixsetup.jar') do
      it { should be_file }
    end
  end
end
