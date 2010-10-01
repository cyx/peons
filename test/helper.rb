require "cutest"
require "logger"
require File.expand_path("../lib/peons", File.dirname(__FILE__))
# Peons.redis.client.logger = Logger.new(STDOUT)

prepare { Peons.redis.flushdb }

