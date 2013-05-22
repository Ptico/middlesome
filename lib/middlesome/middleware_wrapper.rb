module Middlesome

  ##
  # Private Class: Middleware wrapper
  #
  class MiddlewareWrapper

    ##
    # Middleware class name
    #
    # Returns: {String}
    #
    attr_reader :name

    ##
    # Middleware class object
    #
    # Returns: {Class}
    #
    attr_reader :object

    ##
    # Middleware initialization args
    #
    # Returns: {Array}
    #
    attr_reader :args

    ##
    # Middleware initialization block
    #
    # Returns: {Proc|NilClass}
    #
    attr_reader :block

    ##
    # Check middleware for equality
    #
    # For using in `Stack` enumerable finders
    #
    # Params:
    # - middleware {Class|String|Symbol} Middleware to compare
    #
    # Returns: {Boolean}
    #
    def ==(middleware)
      case middleware
        when MiddlewareWrapper
          if object && middleware.object
            object == middleware.object
          else
            name == middleware.name
          end
        when Class
          object == middleware
        when String, Symbol
          name == normalize(middleware.to_s)
      end
    end
    alias :eql? :==

    ##
    # Check middleware for full equality
    #
    # Params:
    # - middleware {Class|String|Symbol} Raw middleware class
    # - margs      {Array}               Arguments for middleware
    #
    # Yields: block for middleware
    #
    # Returns: {Boolean}
    #
    def equal?(middleware, *margs, &mblock)
      middleware = MiddlewareWrapper.new(middleware, *margs, &mblock) unless middleware.is_a?(MiddlewareWrapper)
      self == middleware && args == middleware.args && block.nil? == middleware.block.nil?
    end

    ##
    # Get middleware class
    #
    # Lazy loads class constant if only name given
    #
    # Returns: {Class}
    #
    def middleware_class
      @object ||= constantize_name
    end

  private

    ##
    # Private: Instantiate middleware wrapper
    #
    # Params:
    # - object {Class|String|Symbol} Raw middleware object (or name)
    # - args   {Array}               Arguments for middleware instance
    #
    # Yields: block for middleware instance
    #
    def initialize(object, *args, &block)
      if object.respond_to?(:name)
        name    = object.name
        @object = object
      else
        name = object.to_s
      end

      @name = normalize(name)
      @args, @block = args, block
    end

    ##
    # Private: normalize middleware name
    #
    # If middleware name given with leading `::` - remove it
    #
    # Returns: {String} normalized name
    #
    def normalize(middleware_name)
      middleware_name.strip.sub(/^::/, '')
    end

    ##
    # Get constant from name
    #
    def constantize_name
      name.split('::').inject(Object) do |prev, name|
        prev.const_get(name)
      end
    end

  end
end
