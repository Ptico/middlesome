require 'spec_helper'
require 'shared/middlewares'

describe Middlesome::MiddlewareWrapper, '#object' do
  let(:subject) { described_class.new(obj).object }

  context 'when string' do
    let(:obj) { 'Test::A' }

    it 'should be nil' do
      expect(subject).to be_nil
    end
  end

  context 'when object' do
    let(:obj) { MiddlewareOne }

    it 'should be constant' do
      expect(subject).to be_eql(MiddlewareOne)
    end
  end
end