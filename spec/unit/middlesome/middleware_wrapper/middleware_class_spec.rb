require 'spec_helper'

describe Middlesome::MiddlewareWrapper, '#middleware_class' do
  let(:subject) { described_class.new(obj).middleware_class }

  context 'when with object' do
    let(:obj) { Object::Hash }

    it 'should return class' do
      expect(subject).to be_eql(Object::Hash)
    end
  end

  context 'when with string' do
    let(:obj) { 'Object::Hash' }

    it 'should return class' do
      expect(subject).to be_eql(Object::Hash)
    end
  end

  context 'when constant not exists' do
    let(:obj) { 'Lol::Const' }

    it 'should raise exception' do
      expect { subject }.to raise_error
    end
  end
end