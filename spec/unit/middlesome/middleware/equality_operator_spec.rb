require 'spec_helper'
require 'shared/middlewares'

describe Middlesome::Middleware, '#==' do

  shared_examples_for 'equality operator' do
    context 'when equal' do
      it 'should return true' do
        expect(middleware_one == middleware_two).to be_true
      end
    end

    context 'when not equal' do
      it 'should return false' do
        expect(middleware_one == middleware_three).to be_false
      end
    end
  end

  context 'with class' do
    let(:middleware_one)   { described_class.new(MiddlewareOne) }
    let(:middleware_two)   { MiddlewareOne                      }
    let(:middleware_three) { MiddlewareTwo                      }

    it_should_behave_like 'equality operator'
  end

  context 'with string' do
    let(:middleware_one)   { described_class.new(MiddlewareOne) }
    let(:middleware_two)   { 'MiddlewareOne'                    }
    let(:middleware_three) { 'MiddlewareTwo'                    }

    it_should_behave_like 'equality operator'
  end

  context 'with symbol' do
    let(:middleware_one)   { described_class.new(MiddlewareOne) }
    let(:middleware_two)   { :MiddlewareOne                     }
    let(:middleware_three) { :MiddlewareTwo                     }

    it_should_behave_like 'equality operator'
  end

  context 'with anything else' do
    let(:middleware_one) { described_class.new(MiddlewareOne) }
    let(:middleware_two) { {}                                 }

    it 'should be false' do
      expect(middleware_one == middleware_two).to be_false
    end
  end

  context 'with global const string' do
    let(:middleware_one)   { described_class.new(MiddlewareOne) }
    let(:middleware_two)   { '::MiddlewareOne'                  }
    let(:middleware_three) { '::MiddlewareTwo'                  }

    it_should_behave_like 'equality operator'
  end

  context 'with middleware' do
    let(:middleware_one)   { described_class.new(obj_one)   }
    let(:middleware_two)   { described_class.new(obj_two)   }
    let(:middleware_three) { described_class.new(obj_three) }

    context 'when class with class' do
      let(:obj_one)   { MiddlewareOne }
      let(:obj_two)   { MiddlewareOne }
      let(:obj_three) { MiddlewareTwo }

      it_should_behave_like 'equality operator'
    end

    context 'when class with string' do
      let(:obj_one)   { MiddlewareOne   }
      let(:obj_two)   { 'MiddlewareOne' }
      let(:obj_three) { 'MiddlewareTwo' }

      it_should_behave_like 'equality operator'
    end

    context 'when string with class' do
      let(:obj_one)   { 'MiddlewareOne' }
      let(:obj_two)   { MiddlewareOne   }
      let(:obj_three) { MiddlewareTwo   }

      it_should_behave_like 'equality operator'
    end

    context 'when string with string' do
      let(:obj_one)   { 'MiddlewareOne' }
      let(:obj_two)   { 'MiddlewareOne' }
      let(:obj_three) { 'MiddlewareTwo' }

      it_should_behave_like 'equality operator'
    end

    context 'when with global const string' do
      let(:obj_one)   { 'MiddlewareOne' }
      let(:obj_two)   { '::MiddlewareOne' }
      let(:obj_three) { '::MiddlewareTwo' }

      it_should_behave_like 'equality operator'
    end
  end

end
