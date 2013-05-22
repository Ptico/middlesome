require 'spec_helper'
require 'shared/middlewares'

describe Middlesome::MiddlewareWrapper, '#equal?' do
  shared_examples_for 'equal?' do
    context 'when equal' do
      it 'should return true' do
        expect(middleware_one.equal?(middleware_two)).to be_true
      end
    end

    context 'when not equal' do
      it 'should return false' do
        expect(middleware_one.equal?(middleware_three)).to be_false
      end
    end
  end

  context 'without args and block' do
    let(:middleware_one)   { described_class.new(MiddlewareOne) }
    let(:middleware_two)   { described_class.new(MiddlewareOne) }
    let(:middleware_three) { described_class.new(MiddlewareTwo) }

    it_should_behave_like 'equal?'
  end

  context 'with args' do
    let(:middleware_one) { described_class.new(MiddlewareOne, 'foo', 'bar') }

    context 'with middleware' do
      let(:middleware_two)   { described_class.new(MiddlewareOne, 'foo', 'bar')  }
      let(:middleware_three) { described_class.new(MiddlewareOne, 'foo', 'noop') }

      it_should_behave_like 'equal?'
    end

    context 'with not middleware' do
      context 'when equal' do
        it 'should return true' do
          expect(middleware_one.equal?(MiddlewareOne, 'foo', 'bar') ).to be_true
        end
      end

      context 'when not equal' do
        it 'should return false' do
          expect(middleware_one.equal?(MiddlewareOne)).to be_false
        end
      end
    end
  end

  context 'with block' do
    let(:middleware_one) { described_class.new(MiddlewareOne) { puts } }

    context 'with middleware' do
      let(:middleware_two)   { described_class.new(MiddlewareOne) { puts } }
      let(:middleware_three) { described_class.new(MiddlewareOne) }

      it_should_behave_like 'equal?'
    end

    context 'with not middleware' do
      context 'when equal' do
        it 'should return true' do
          expect(middleware_one.equal?(MiddlewareOne) { puts } ).to be_true
        end
      end

      context 'when not equal' do
        it 'should return false' do
          expect(middleware_one.equal?(MiddlewareOne)).to be_false
        end
      end
    end
  end

end
