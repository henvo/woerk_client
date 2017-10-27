require 'json'

module WoerkClient
  class Shift
    RESOURCE_PATH = '/shifts'

    # Create new shift and persist it in the API
    #
    # @return [Boolean] the reponse if the request was successful
    def self.start
      new(started_at: Time.now).save
    end

    # Get all shifts from API
    #
    # @return [Boolean] the reponse if the request was successful
    def self.stop
      response = Client.get(RESOURCE_PATH)

      # Get the current shift
      current_shift = JSON.parse(response.body)
                          .find { |s| s['stopped_at'] == 0 }

      # Return if there's no current shift
      if current_shift.nil?
        puts 'No shift running!'.colorize(:red)

        return false
      end

      # Create new with only stopped_at param
      new(
        'id'         => current_shift['id'],
        'stopped_at' => Time.now
      ).save
    end

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
