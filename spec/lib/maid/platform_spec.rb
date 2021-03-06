require 'spec_helper'

module Maid
  describe Platform do
    def stub_host_os(value)
      RbConfig::CONFIG.stub(:[]).with('host_os') { value }
    end

    describe 'determining the host OS' do
      it 'delegates to RbConfig' do
        stub_host_os('foo')
        subject.host_os.should == 'foo'
      end
    end

    context 'when running on Ubuntu' do
      before do
        stub_host_os('linux-gnu')
      end

      it 'is identified as Linux' do
        subject.linux?.should be_true
      end

      it 'is not identified as OS X' do
        subject.osx?.should be_false
      end

      it 'locate is "locate"' do
        Platform::Commands.locate.should match(/locate/)
      end
    end

    context 'when running on Mac OS X' do
      before do
        stub_host_os('darwin10.0')
      end

      it 'is not identified as Linux' do
        subject.linux?.should be_false
      end

      it 'is identified as OS X' do
        subject.osx?.should be_true
      end

      it 'locate is "mdfind"' do
        Platform::Commands.locate.should match(/mdfind/)
      end
    end
  end
end
