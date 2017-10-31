# frozen_string_literal: true

require 'thor'
require 'colorize'
require 'simple_command'

require 'woerk_client/configuration'
require 'woerk_client/client'
require 'woerk_client/version'
require 'woerk_client/models/shift'
require 'woerk_client/models/task'
require 'woerk_client/models/project'

require 'woerk_client/commands/start_shift'
require 'woerk_client/commands/stop_shift'
require 'woerk_client/commands/get_status'

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
      command = WoerkClient::Commands::StartShift.call

      if command.success?
        return puts command.result
      end

      puts command.errors[:start]
    end

    desc 'stop', 'Stop your current working shift'
    def stop
      command = WoerkClient::Commands::StopShift.call

      if command.success?
        return puts command.result
      end

      puts command.errors[:stop]
    end

    desc 'status', 'Get your current working status'
    def status
      command = WoerkClient::Commands::GetStatus.call

      if command.success?
        return puts command.result
      end

      puts command.errors[:status]
    end
  end
end
