class TestMiddleware < Struct.new(:app, :opt1, :opt2)
  def call(env)
    env << self.class.to_s
    env << opt1 if opt1
    env << opt2 if opt2
    app.call(env)
  end
end

class MiddlewareOne < TestMiddleware; end
class MiddlewareTwo < TestMiddleware;
  def self.name
    nil
  end
end

class MiddlewareThree < TestMiddleware;
  def self.name
    'MiddlewareOne'
  end
end

class MiddlewareFour < TestMiddleware
  def self.name
    ''
  end
end

class MiddlewareFive < TestMiddleware
  def self.to_s
    '[MiddlewareFive]'
  end
end

class MiddlewareApp
  def self.call(env)
    env << 'MiddlewareApp'
    true
  end
end