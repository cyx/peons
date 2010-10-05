require "redis"
require "nest"

module Peons
  VERSION = "0.0.3"
  
  class Queue < Nest
    alias :push :lpush

    def pop
      return unless item = rpoplpush(backup)

      begin
        yield item
      rescue Exception => e
        fail(e, item)
      ensure
        backup.del
      end
    end

    def each
      catch :empty do
        loop do
          pop! { |e| yield e }
        end
      end
    end

    def backup
      self[Process.pid][:backup]
    end

    def errors
      self[:errors]
    end

  private
    def fail(exception, item)
      error = "#{Time.now} #{item} => #{exception.inspect}"

      errors.rpush(error)
      errors.publish(error)
    end

    def pop!
      throw(:empty) unless pop { |e| yield e }
    end
  end

  def self.[](key)
    Queue.new(:peons, redis)[key]
  end

  def self.redis
    threaded[:redis] ||= Redis.connect
  end

  def self.redis=(redis)
    threaded[:redis] = redis
  end

private
  def self.threaded
    Thread.current[:peons] ||= {}
  end
end

