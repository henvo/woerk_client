# frozen_string_literal: true

require 'rest-client'

module WoerkClient
  # Acts as a gateway to the woerk.net API
  class Client
    # Gateway for API requests
    #
    # @param method [Symbol] the HTTP verb as a symbol, e.g. :get, :post, :put
    # @param path [String] the path of the URL
    # @param payload [Hash] the body for the request
    def self.call(method: :get, path: '/', payload: nil)
      new(method, path, payload).call
    end

    ##
    # Shorthand for GET requests to the API
    #
    # @param path [String]
    def self.get(path)
      new(:get, path, nil).call
    end

    ##
    # Shorthand for POST requests to the API
    #
    # @param path [String]
    # @param payload [Hash]
    def self.post(path:, payload:)
      new(:post, path, payload).call
    end

    ##
    # Shorthand for PUT requests to the API
    #
    # @param path [String]
    # @param payload [Hash]
    def self.put(path:, payload:)
      new(:put, path, payload).call
    end

    ##
    # Shorthand for DELETE requests to the API
    #
    # @param path [String]
    def self.delete(path)
      new(:put, path, nil).call
    end

    # @param method [Symbol] the HTTP verb as a symbol, e.g. :get, :post, :put
    # @param path [String] the path of the URL
    # @param payload [Hash] the body for the request
    def initialize(method, path, payload)
      @method   = method
      @path     = path
      @payload  = payload
    end

    # Uses RestClient to make API requests
    def call
      RestClient::Request.execute(
        method: @method,
        url: url,
        payload: @payload,
        headers: headers
      )
    end

    private

    # Puts the url together
    #
    # @return [String] the final URL for the request
    def url
      "#{base_url}#{@path}"
    end

    # All headers for every API call
    #
    # @return [Hash] the headers that are submitted with every request
    def headers
      {
        Accept: 'application/json; version=1',
        Authorization: auth_token
      }
    end

    # Base URL from the configuration
    #
    # @return [String] the base URL, e.g. https://woerk.net/api
    def base_url
      WoerkClient.configuration.api_host
    end

    # @return [String] the authentication token from the configuration file
    def auth_token
      WoerkClient.configuration.auth_token
    end
  end
end
