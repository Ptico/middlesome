require 'spec_helper'

describe Middlesome::Manager, '#delete' do
  include_context 'manager_context'

  before do
    instance.push('M1')
    instance.push(:M2)
    instance.push(:M3)
  end

  context 'when middleware exists' do
    before { instance.delete(:M2) }

    it 'should delete middleware' do
      expect(names).to eql(['M1', 'M3'])
    end
  end

  context 'when middleware does not exists' do
    before { instance.delete(:M4) }

    it 'should do nothing' do
      expect(names).to eql %w(M1 M2 M3)
    end
  end

  context 'when more than one match' do
    before do
      instance.push(:M2)
      instance.delete(:M2)
    end

    it 'should delete first' do
      expect(names).to eql %w(M1 M3 M2)
    end
  end
end
