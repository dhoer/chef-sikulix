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
    describe file('C:/sikulix/Downloads') do
      it { should be_directory }
    end

    describe file('C:/sikulix/Lib') do
      it { should be_directory }
    end

    describe file('C:/sikulix/libs') do
      it { should be_directory }
    end

    describe file('C:/sikulix/runsikulix') do
      it { should be_file }
    end

    describe file('C:/sikulix/SikuliX-1.1.0-SetupLog.txt') do
      it { should be_file }
    end

    describe file(' sikulixapi.jar') do
      it { should be_file }
    end

    describe file('sikulix.jar') do
      it { should be_file }
    end

    describe file('sikulixremoteserver.jar') do
      it { should be_file }
    end

    describe file('sikulixsetup.jar') do
      it { should be_file }
    end
  end
end
