# encoding: utf-8

require 'redispeek'
require 'sinatra/base'
require 'erb'

if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

module Redispeek
  class Server < Sinatra::Base

    helpers do

      def keys_to_hash(keys)
        h={}
        keys.each do |key|
          k = key.split(':')
          x = h
          k.each do |v|
            x=(x[v]||={})
          end
        end
        return h
      end

      def keys_to_menu(hash, parent=nil)
        m = '<ul>'
        hash.keys.sort.each do |k|
          pkey = (not parent.nil?) ? "#{parent}:#{k}" : k
          if hash[k].is_a?(Hash) && (not hash[k].empty?)
            m += "\n\t<li>\n\t<a href='/peek/" +  pkey  + "' class='node folder'>" + k + "</a>\n\t"
            m += keys_to_menu( hash[k], pkey )
            m += "\n\t</li>"
          else
            m += "\t" + '<li><a href="/peek/' +  pkey  + '" class="leaf"><span>' + k + '</a></li>' + "\n"
          end
        end
        m += '</ul>'
        m
      end

    end

    before do
      if params[:s].to_s.strip != ''
        @keys = keys_to_hash( Redispeek.redis.keys( params[:s] ) )
      else
        @keys = keys_to_hash( Redispeek.redis.keys )
      end
    end

    base_path = File.dirname( __FILE__ )

    set :views, File.join( base_path, 'server', 'views' ).to_s

    set :show_exceptions, false

    set :public_folder, File.join( base_path, 'server', 'public' )

    def redis_get(key, start=0)
      type = Redispeek.redis.type(key)
      data = { :type => type }
      case type
      when 'none'
        []
      when 'list'
        Redispeek.redis.lrange(key, start, -1)
      when 'set'
        Redispeek.redis.smembers(key)
      when 'string'
        [Redispeek.redis.get(key)]
      when 'zset'
        Redispeek.redis.zrange(key, start, start + 20)
      when 'hash'
        Hash[*Redispeek.redis.hgetall(key).flatten]
      end
    end

    def show(page, layout=true)
      response["Cache-Control"] = "max-age=0, private, must-revalidate"
      begin
        erb page.to_sym, {:layout => layout}, :redispeek => Redispeek
      rescue Errno::ECONNREFUSED
        erb :error, {:layout => false}, :error => "Can't connect to Redis!"
      end
    end

    get '/' do
      show 'page'
    end

    get '/peek/:key' do
      @key   = params[:key]
      @value = redis_get( @key )
      show 'page'
    end

    get '/server-info' do
      @value = Redispeek.redis.info
      show 'page'
    end

  end
end
