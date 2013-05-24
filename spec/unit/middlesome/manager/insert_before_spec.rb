require 'spec_helper'
require 'shared/middlewares'

describe Middlesome::Manager, '#insert_before' do
  let(:instance)   { described_class.new }
  let(:names)      { instance.middlewares.map(&:name) }
  let(:middleware) { instance[0] }

  before do
    instance.push('M1')
    instance.push(:M2)
  end

  it 'should insert middleware before given string name' do
    instance.insert_before('M2', :M3)

    expect(names).to eql(%w(M1 M3 M2))
  end

  it 'should insert middleware before given symbol name' do
    instance.insert_before(:M2, 'M3')

    expect(names).to eql(%w(M1 M3 M2))
  end

  it 'should insert middleware before given const name' do
    instance.push(MiddlewareOne)
    instance.insert_before(MiddlewareOne, :M3)

    expect(names).to eql(%w(M1 M2 M3 MiddlewareOne))
  end

  it 'should insert middleware before first match' do
    instance.push(:M2)
    instance.insert_before(:M2, :M3)

    expect(names).to eql(%w(M1 M3 M2 M2))
  end

  it 'should pass arguments for middleware' do
    instance.insert_before(:M1, :M3, 'foo', 'bar')

    expect(middleware.args).to eql(['foo', 'bar'])
  end

  it 'should pass block for middleware' do
    instance.insert_before(:M1, :M3) { puts }

    expect(middleware.block).to be_a(Proc)
  end

  it 'should pass both args and block' do
    instance.insert_before(:M1, :M3, 'foo', 'bar') { puts }

    expect(middleware.block).to be_a(Proc)
    expect(middleware.args).to  eql(['foo', 'bar'])
  end
end
