# frozen_string_literal: true

require 'thor'
require 'colorize'

require 'woerk_client/configuration'
require 'woerk_client/client'
require 'woerk_client/version'
require 'woerk_client/shift'
require 'woerk_client/task'
require 'woerk_client/project'

module WoerkClient
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class CLI < Thor
    desc 'start', 'Start a new working shift'
    def start
      puts 'Starting shift...'
      puts 'Done'.colorize(:green) if WoerkClient::Shift.start
    end

    desc 'stop', 'Stop your current working shift'
    def stop
      puts 'Stopping shift...'
      puts 'Done'.colorize(:green) if WoerkClient::Shift.stop
    end

    desc 'status', 'Get your current working status'
    def status
      puts 'Status information'
    end
  end
end
