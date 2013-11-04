require 'spec_helper'

describe Middlesome::Proxy do
  let(:manager) { Middlesome::Manager.new }
  let(:proxy)   { described_class.new }
  let(:subject) { proxy.merge_into(manager).middlewares.map(&:name) }

  before :each do
    manager.push(:M1)
    manager.push(:M2)
    manager.push(:M3)
  end

  it '#push' do
    proxy.push(:M4)

    expect(subject).to eql %w(M1 M2 M3 M4)
  end

  it '#insert_after' do
    proxy.insert_after(:M2, :M4)

    expect(subject).to eql %w(M1 M2 M4 M3)
  end

  it '#insert_before' do
    proxy.insert_before(:M2, :M4)

    expect(subject).to eql %w(M1 M4 M2 M3)
  end

  it '#replace' do
    proxy.replace(:M2, :M4)

    expect(subject).to eql %w(M1 M4 M3)
  end

  it '#delete' do
    proxy.delete(:M2)

    expect(subject).to eql %w(M1 M3)
  end

  it '#delete_all' do
    manager.push(:M2)
    proxy.delete_all(:M2)

    expect(subject).to eql %w(M1 M3)
  end
end
