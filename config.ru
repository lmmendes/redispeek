#!/usr/bin/env ruby

$:.unshift File.expand_path( File.dirname(__FILE__) + '/lib')

require 'redispeek/server'

use Rack::ShowExceptions
run Redispeek::Server.new