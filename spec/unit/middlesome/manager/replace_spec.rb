require 'spec_helper'

describe Middlesome::Manager, '#replace' do
  include_context 'manager_context'

  before do
    instance.push('M1')
    instance.push(:M2)
    instance.push(:M3)
  end

  it 'should replace one middleware with another' do
    instance.replace(:M2, :M4)

    expect(names).to eql %w(M1 M4 M3)
  end

  it 'should pass arguments for middleware' do
    instance.replace(:M2, :M4, 'foo', 'bar')

    expect(middleware_two.args).to eql(['foo', 'bar'])
  end

  it 'should pass block for middleware' do
    instance.replace(:M2, :M4) { puts }

    expect(middleware_two.block).to be_a(Proc)
  end

  it 'should pass both args and block' do
    instance.replace(:M2, :M4, 'foo', 'bar') { puts }

    expect(middleware_two.block).to be_a(Proc)
    expect(middleware_two.args).to  eql(['foo', 'bar'])
  end
end
