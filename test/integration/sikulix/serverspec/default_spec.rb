require 'serverspec_helper'

describe 'sikulix_test::default' do
  if os[:family] == 'windows'
    describe file('C:/sikulix-1.1.0/Downloads') do
      it { should be_directory }
    end

    describe file('C:/sikulix-1.1.0/Build') do
      it { should be_directory }
    end

    # describe file('C:/sikulix-1.1.0/libs/libJXGrabKey.so') do
    #   it { should be_file }
    # end

    describe file('C:/sikulix-1.1.0/libs/libVisionProxy..so') do
      it { should be_file }
    end

    describe file('C:/sikulix-1.1.0/sikulix.jar') do
      it { should be_file }
    end

    describe file('C:/sikulix-1.1.0/sikulixapi.jar') do
      it { should be_file }
    end
  else
    describe file('/usr/local/sikulix-1.1.0/Downloads') do
      it { should be_directory }
    end

    describe file('/usr/local/sikulix-1.1.0/Build') do
      it { should be_directory }
    end

    # describe file('/usr/local/sikulix-1.1.0/libs/libJXGrabKey.so') do
    #   it { should be_file }
    # end

    describe file('/usr/local/sikulix-1.1.0/libs/libVisionProxy.so') do
      it { should be_file }
    end

    describe file('/usr/local/sikulix-1.1.0/sikulix.jar') do
      it { should be_file }
    end

    describe file('/usr/local/sikulix-1.1.0/sikulixapi.jar') do
      it { should be_file }
    end
  end
end
