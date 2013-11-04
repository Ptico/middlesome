module Middlesome
  ##
  # Module: Configurable mixin
  #
  module Configurable

    ##
    # Manipulate environment middlewares
    #
    # Params:
    # - env {Symbol} Environment to set (optional, default: :default)
    #
    def middlewares(env=:default, &block)
      environment = environments[env.to_sym] ||= Proxy.new

      environment.instance_eval(&block)
    end

    ##
    # Build middleware stack
    #
    # Params:
    # - app {Class, Proc} Application
    # - env {Symbol}      Current environment (optional, default: :default)
    #
    # Returns: middleware and app stack
    #
    def build(app, env=nil)
      if env && environments.has_key?(env.to_sym)
        proxy = environments[env.to_sym]
        proxy.merge_into(manager)
      end

      manager.reverse_each.inject(app) { |app, m| m.middleware_class.new(app, *m.args, &m.block) }
    end

  protected

    def environments
      @environments ||= { default: Manager.new }
    end

    def manager
      environments[:default]
    end

  end
end
