require 'spec_helper'

describe Middlesome::Manager, '#delete' do
  include_context 'manager_context'

  before do
    instance.push('M1')
    instance.push(:M2)
    instance.push(:M1)
  end

  context 'when middleware exists' do
    before { instance.delete_all(:M1) }

    it 'should delete middleware' do
      expect(names).to eql(['M2'])
    end
  end

  context 'when middleware does not exists' do
    before { instance.delete_all(:M3) }

    it 'should do nothing' do
      expect(names).to eql(['M1', 'M2', 'M1'])
    end
  end

  context 'when no middlewares given' do
    before { instance.delete_all }

    it 'should delete all' do
      expect(names).to eql([])
    end
  end
end
