# frozen_string_literal: true

require 'yaml'

module WoerkClient
  class Configuration
    AUTH_TOKEN = 'AUTH_TOKEN'.freeze
    API_HOST   = 'API_HOST'.freeze

    attr_accessor :auth_token, :api_host

    def initialize
      @auth_token = config_file[AUTH_TOKEN]
      @api_host   = config_file[API_HOST] || 'https://woerk.net/api'
    end

    def config_file
      @file ||= YAML.load_file(ENV['HOME'] + '/.woerk.yml')
    end
  end
end
