require 'spec_helper'

describe Middlesome::Stack do
  let(:instance) { described_class.new }
  let(:subject)  { [] }

  before :each do 
    instance.middlewares do
      use 'MiddlewareOne', 'foo', 'bar'
      use 'MiddlewareTwo'
      use 'MiddlewareFour', 'baz'
    end

    instance.middlewares :development do
      insert_after 'MiddlewareOne', 'MiddlewareThree', 2

      delete 'MiddlewareFour'
    end

    instance.middlewares :production do
      delete 'MiddlewareOne'
    end

    instance.build(MiddlewareApp, environment).call(subject)
  end

  context 'when no environment' do
    let(:environment) { nil }

    it do
      expect(subject).to eql %w(MiddlewareOne foo bar MiddlewareTwo MiddlewareFour baz MiddlewareApp)
    end
  end

  context 'when development' do
    let(:environment) { :development }

    it do
      expect(subject).to eql [
        'MiddlewareOne', 'foo', 'bar',
        'MiddlewareThree', 2,
        'MiddlewareTwo',
        'MiddlewareApp'
      ]
    end
  end

  context 'when production' do
    let(:environment) { :production }

    it do
      expect(subject).to eql [
        'MiddlewareTwo',
        'MiddlewareFour', 'baz',
        'MiddlewareApp'
      ]
    end
  end

end
