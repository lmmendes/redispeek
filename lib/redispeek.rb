# encoding: utf-8

require "redis"

require File.expand_path("redispeek/version", File.dirname(__FILE__))
require File.expand_path("redispeek/helpers", File.dirname(__FILE__))

module Redispeek

  include Helpers
  extend self

  def redis=(server)
    case server
    when String
      if server =~ /redis\:\/\//
        @redis = Redis.connect(:url => server, :thread_safe => true)
      else
        server, namespace = server.split('/', 2)
        host, port, db = server.split(':')
        @redis = Redis.new(:host => host, :port => port,
          :thread_safe => true, :db => db)
      end
    else
      @redis = Redis.new(:redis => server)
    end
    @redis
  end

  def redis
    return @redis if @redis
    self.redis = Redis.respond_to?(:connect) ? Redis.connect(:thread_safe => true) : "localhost:6379"
    self.redis
  end

end
