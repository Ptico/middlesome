require 'spec_helper'
require 'shared/middlewares'

describe Middlesome::Manager, '#insert_after' do
  let(:instance)   { described_class.new }
  let(:names)      { instance.middlewares.map(&:name) }
  let(:middleware) { instance[1] }

  before do
    instance.push('M1')
    instance.push(:M2)
  end

  it 'should insert middleware after given string name' do
    instance.insert_after('M1', :M3)

    expect(names).to eql(%w(M1 M3 M2))
  end

  it 'should insert middleware after given symbol name' do
    instance.insert_after(:M1, 'M3')

    expect(names).to eql(%w(M1 M3 M2))
  end

  it 'should insert middleware after given const name' do
    instance.push(MiddlewareOne)
    instance.push(:M4)
    instance.insert_after(MiddlewareOne, :M3)

    expect(names).to eql(%w(M1 M2 MiddlewareOne M3 M4))
  end

  it 'should insert middleware after last match' do
    instance.push(:M2)
    instance.push(:M4)
    instance.insert_after(:M2, :M3)

    expect(names).to eql(%w(M1 M2 M2 M3 M4))
  end

  it 'should pass arguments for middleware' do
    instance.insert_after(:M1, :M3, 'foo', 'bar')

    expect(middleware.args).to eql(['foo', 'bar'])
  end

  it 'should pass block for middleware' do
    instance.insert_after(:M1, :M3) { puts }

    expect(middleware.block).to be_a(Proc)
  end

  it 'should pass both args and block' do
    instance.insert_after(:M1, :M3, 'foo', 'bar') { puts }

    expect(middleware.block).to be_a(Proc)
    expect(middleware.args).to  eql(['foo', 'bar'])
  end
end
