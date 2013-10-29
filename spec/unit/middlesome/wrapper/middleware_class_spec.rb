require 'spec_helper'

describe Middlesome::Wrapper, '#middleware_class' do
  let(:instance) { described_class.new(obj)  }
  let(:subject)  { instance.middleware_class }

  context 'when with object' do
    let(:obj) { Object::Hash }

    it 'should return class' do
      expect(subject).to be_equal(Object::Hash)
    end
  end

  context 'when with string' do
    let(:obj) { 'Object::Hash' }

    it 'should return class' do
      expect(subject).to be_equal(Object::Hash)
    end

    it 'should assign object' do
      subject
      expect(instance.object).to be_equal(Object::Hash)
    end
  end

  context 'when constant not exists' do
    let(:obj) { 'Lol::Const' }

    it 'should raise exception' do
      expect { subject }.to raise_error
    end
  end
end
