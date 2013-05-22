require 'spec_helper'

describe Middlesome::Wrapper, '#name' do
  let(:subject) { described_class.new(obj).name }

  context 'when string' do
    let(:obj) { 'Array' }

    it 'should be the same' do
      expect(subject).to be_eql('Array')
    end
  end

  context 'when symbol' do
    let(:obj) { :Array }

    it 'should be string' do
      expect(subject).to be_eql('Array')
    end
  end

  context 'when root const string' do
    let(:obj) { '::Array' }

    it 'should normalize name' do
      expect(subject).to be_eql('Array')
    end
  end

  context 'when string with spaces' do
    let(:obj) { ' Array ' }

    it 'should normalize name' do
      expect(subject).to be_eql('Array')
    end
  end

  context 'when const' do
    let(:obj) { Array }

    it 'should convert to string' do
      expect(subject).to be_eql('Array')
    end
  end
end
