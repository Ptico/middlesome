require 'spec_helper'

describe Middlesome::Manager, '#use' do
  let(:instance) { described_class.new }

  it 'should push middlewares to stack' do
    instance.use(:MiddlewareOne)
    instance.use(:MiddlewareTwo)

    expect(instance.length).to  be_eql(2)
    expect(instance[0].name).to be_eql("MiddlewareOne")
    expect(instance[1].name).to be_eql("MiddlewareTwo")
  end

  it 'should pass arguments for middlewares' do
    instance.use(:MiddlewareOne, 'foo', 'bar')
    instance.use(:MiddlewareTwo, {})

    expect(instance[0].args).to be_eql(['foo', 'bar'])
    expect(instance[1].args).to be_eql([{}])
  end

  it 'should pass block for middlewares' do
    instance.use(:MiddlewareOne) { puts }
    instance.use(:MiddlewareTwo)

    expect(instance[0].block).to be_a(Proc)
    expect(instance[1].block).to be_nil
  end

  it 'should pass both args and procs' do
    instance.use(:MiddlewareOne, 'foo', 'bar') { puts }

    expect(instance[0].block).to be_a(Proc)
    expect(instance[0].args).to  be_eql(['foo', 'bar'])
  end
end
