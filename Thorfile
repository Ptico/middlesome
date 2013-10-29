$:.unshift File.expand_path("../lib", __FILE__)

require 'thor'
require 'middlesome/version'

begin
  require 'mutant'
rescue LoadError
end

class Default < Thor
  desc 'spec [TYPE]', 'Run RSpec code examples (integration, unit or all)'
  def spec(type=nil)
    exec "rspec --color spec/#{type}"
  end

  desc 'coverage [TYPE]', 'Generate code coverage'
  def coverage(type=nil)
    ENV['COVERAGE'] = 'true'
    spec(type)
  end

  desc 'mutant [NAMESPACE]', 'Run mutation tests for NAMESPACE'
  def mutant(namespace='*')
    Mutant::CLI.run(%W(--include lib --require middlesome ::Middlesome#{namespace} --rspec))
  end

  desc 'build', "Build middlesome-#{Middlesome::VERSION}.gem into the pkg directory"
  def build
    Bundler::GemHelper.new.build_gem
  end

  desc 'install', "Build and install middlesome-#{Middlesome::VERSION}.gem into system gems"
  def install
    helper = Bundler::GemHelper.new
    helper.install_gem(helper.build_gem)
  end

  desc 'release', "Create tag v#{Middlesome::VERSION} and build and push middlesome-#{Middlesome::VERSION}.gem to Rubygems"
  def release
    helper = Bundler::GemHelper.new
    helper.release_gem(helper.build_gem)
  end
end