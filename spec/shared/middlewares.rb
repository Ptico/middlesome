class TestMiddleware < Struct.new(:app, :opt1, :opt2)
  def call(env)
    env << self.class.name
    env << opt1 if opt1
    env << opt2 if opt2
    app.call(env)
  end
end

class MiddlewareOne < TestMiddleware; end
class MiddlewareTwo < TestMiddleware; end
class MiddlewareApp
  def self.call(env)
    env << 'MiddlewareApp'
    true
  end
end