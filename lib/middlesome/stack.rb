require 'forwardable'

require 'middlesome/middleware_wrapper'

module Middlesome

  ##
  # Class: Middleware stack
  #
  # Implements: Enumerable
  #
  class Stack
    include ::Enumerable
    extend ::Forwardable

    attr_reader :middlewares

    def_delegators :middlewares, :[], :length

    ##
    # Push middleware to the stack
    #
    # Middleware can be added by full constant name. In this case
    # it will be lazy initialized later
    #
    # Params:
    # - middleware {Class|String|Symbol} Middleware class or it's name
    # - args       {Array}               Middleware initialization arguments
    #
    # Yields: Middleware initialization block
    #
    def use(middleware, *args, &block)
      middlewares << wrap(middleware, *args, &block)
    end

    ##
    # Insert middleware before another, already presented in stack
    #
    # Params:
    # - one_middleware     {Class|String|Symbol} Existing middleware
    # - another_middleware {Class|String|Symbol} Middleware to insert before existing
    # - args               {Array}               New middleware initialization arguments
    #
    # Yields: Middleware initialization block
    #
    def insert_before(one_middleware, another_middleware, *args, &block)
      
    end

    ##
    # Insert middleware after another, already presented in stack
    #
    # Params:
    # - one_middleware     {Class|String|Symbol} Existing middleware
    # - another_middleware {Class|String|Symbol} Middleware to insert after existing
    # - args               {Array}               New middleware initialization arguments
    #
    # Yields: Middleware initialization block
    #
    def insert_after(one_middleware, another_middleware, *args, &block)
      
    end

    ##
    # Replace existing middleware with another one
    #
    # Params:
    # - one_middleware  {Class|String|Symbol} Existing middleware
    # - with_middleware {Class|String|Symbol} Replacement middleware
    # - args            {Array}               Replacement middleware initialization arguments
    #
    # Yields: Replacement middleware initialization block
    #
    def replace(one_middleware, with_middleware, *args, &block)
      
    end

    ##
    # Delete middleware from stack
    #
    # Params:
    # - middleware {Class|String|Symbol} Middleware to remove
    #
    def delete(middleware)
      
    end

    ##
    # Delete multiple middlewares
    #
    # Delete all middlewares for which `block` is false or which name/class
    # matches `middleware` argument
    #
    # Params:
    # - middleware {Class|String|Symbol} Middleware class/name (optional)
    #
    # Yields: conditional block
    #
    def delete_all(middleware, &block)
      
    end

  private

    def initialize
      @middlewares = []
    end

    def wrap(middleware, *args, &block)
      MiddlewareWrapper.new(middleware, *args, &block)
    end

  end
end
