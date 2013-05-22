require 'spec_helper'

describe Middlesome::Middleware, '#args' do
  let(:subject) { described_class.new('Foo', *arguments).args }

  context 'when no arguments' do
    let(:arguments) { nil }

    it 'should be empty' do
      expect(subject.length).to be_eql(0)
    end
  end

  context 'when one argument' do
    let(:arguments) { 'foo' }
  
    it 'should have one argument' do
      expect(subject).to be_eql(['foo'])
    end
  end

  context 'when more arguments' do
    let(:arguments) { %w(foo bar) }

    it 'should have it all' do
      expect(subject).to be_eql(['foo', 'bar'])
    end
  end
end