require 'spec_helper'

describe Middlesome::Middleware, '#middleware_class' do
  let(:subject) { described_class.new(obj).middleware_class }

  context 'when with object' do
    let(:obj) { Object::Hash }

    it 'should return class' do
      expect(subject).to eql(Object::Hash)
    end
  end

  context 'when with string' do
    let(:obj) { 'Object::Hash' }

    it 'should return class' do
      expect(subject).to eql(Object::Hash)
    end
  end
end