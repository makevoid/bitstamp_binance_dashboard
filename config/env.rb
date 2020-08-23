require 'bundler'

Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

# NOTE: this is a fix because of active-support (required by the bitstamp gem)
require 'active_support'
require 'active_support/core_ext'

Bundler.require :default

path = File.expand_path '../../', __FILE__
PATH = path

APP_ENV = ENV["RACK_ENV"] || "development"


Oj.default_options = { mode: :compat }

env_vars = %w(
  BINANCE_API_KEY
  BINANCE_SECRET_KEY
  BITSTAMP_API_KEY
  BITSTAMP_API_SECRET
  BITSTAMP_CLIENT_ID
)

# TODO: refactor - extract
# def check_env_vars(env_Vars)
env_vars.each do |env_var|
  raise "ENVVarNotSetError - Environment variable #{env_var.inspect} is not set - it is required, please read the `Configuration` section in the readme" unless ENV[env_var]
end

Bitstamp.setup do |config|
  config.key        = ENV["BITSTAMP_API_KEY"]
  config.secret     = ENV["BITSTAMP_API_SECRET"]
  config.client_id  = ENV["BITSTAMP_CLIENT_ID"]
end

# NOTE: binance environment variables are assigned implicitly by the binance-ruby library

# require your libs/models here
#
require_relative '../lib/ticker'
require_relative '../lib/binance'
require_relative '../lib/bitstamp'
require_relative '../lib/balance'
require_relative '../lib/candle'
