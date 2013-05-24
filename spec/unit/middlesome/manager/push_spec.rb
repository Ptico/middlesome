require 'spec_helper'

describe Middlesome::Manager, '#push' do
  let(:instance) { described_class.new }
  let(:names)    { instance.middlewares.map(&:name) }
  let(:middleware_one) { instance[0] }
  let(:middleware_two) { instance[1] }

  it 'should push middlewares to stack' do
    instance.push(:MiddlewareOne)
    instance.push(:MiddlewareTwo)

    expect(instance.length).to eql(2)
    expect(names).to eql(%w(MiddlewareOne MiddlewareTwo))
  end

  it 'should pass arguments for middlewares' do
    instance.push(:MiddlewareOne, 'foo', 'bar')
    instance.push(:MiddlewareTwo, {})

    expect(middleware_one.args).to eql(['foo', 'bar'])
    expect(middleware_two.args).to eql([{}])
  end

  it 'should pass block for middlewares' do
    instance.push(:MiddlewareOne) { puts }
    instance.push(:MiddlewareTwo)

    expect(middleware_one.block).to be_a(Proc)
    expect(middleware_two.block).to be_nil
  end

  it 'should pass both args and block' do
    instance.push(:MiddlewareOne, 'foo', 'bar') { puts }

    expect(middleware_one.block).to be_a(Proc)
    expect(middleware_one.args).to  eql(['foo', 'bar'])
  end
end
