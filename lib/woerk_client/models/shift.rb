require 'json'

module WoerkClient
  module Models
    class Shift
      RESOURCE_PATH = '/shifts'

      attr_accessor :params

      # @params [Hash] the shift params
      #
      # @return [Shift]
      def initialize(params)
        @params = params
      end

      # Calls update or create
      #
      # @return [Boolean] if the API call was successful
      def save
        @params['id'] ? update : create
      end

      # Submits a POST request to the database
      #
      # @return [Boolean] if the API call was successful
      def create
        Client.post(
          path: RESOURCE_PATH,
          payload: { shift: @params }
        )
      end

      # Submits a PUT request to the database
      #
      # @return [Boolean] if the API call was successful
      def update
        Client.put(
          path: "#{RESOURCE_PATH}/#{@params['id']}",
          payload: { shift: @params }
        )
      end
    end
  end
end
