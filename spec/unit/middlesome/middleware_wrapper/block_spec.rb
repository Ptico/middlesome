require 'spec_helper'

describe Middlesome::MiddlewareWrapper, '#block' do
  let(:subject)  { instance.block }

  context 'when block received' do
    let(:instance) { described_class.new('Foo') { puts } }

    it 'should store the block' do
      expect(subject).to be_instance_of(Proc)
    end
  end

  context 'when block is not received' do
    let(:instance) { described_class.new('Foo') }

    it 'should be nil' do
      expect(subject).to be_nil
    end
  end
end