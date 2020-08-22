require 'bundler'

Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

Bundler.require :default

path = File.expand_path '../../', __FILE__
PATH = path

APP_ENV = ENV["RACK_ENV"] || "development"


Oj.default_options = { mode: :compat }

# require your libs/models here
#
require_relative '../lib/ticker'
require_relative '../lib/binance'
require_relative '../lib/bitstamp'
require_relative '../lib/balance'
