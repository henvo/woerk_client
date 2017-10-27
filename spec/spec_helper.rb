require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
end

require 'bundler/setup'
require 'woerk_client'

RSpec.configure do |config|
  # TODO
end
