module Middlesome

  ##
  # Class: Middleware manager proxy
  #
  # Rails, the good parts: proxy that allows to merge different environments into one
  #
  class Proxy

    attr_reader :operations

    def push(*args, &block)
      operations << [__method__, args, block]
    end
    alias :use :push

    def insert_before(*args, &block)
      operations << [__method__, args, block]
    end

    def insert_after(*args, &block)
      operations << [__method__, args, block]
    end

    def replace(*args, &block)
      operations << [__method__, args, block]
    end

    def delete(*args, &block)
      operations << [__method__, args, block]
    end

    def delete_all(*args, &block)
      operations << [__method__, args, block]
    end

    def merge_into(other)
      operations.each do |operation, args, block|
        other.send(operation, *args, &block)
      end

      other
    end

  private

    def initialize
      @operations = []
    end

  end
end
