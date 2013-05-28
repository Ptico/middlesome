shared_context 'manager_context' do
  let(:instance)       { described_class.new }
  let(:names)          { instance.middlewares.map(&:name) }
  let(:middleware_one) { instance[0] }
  let(:middleware_two) { instance[1] }
end
