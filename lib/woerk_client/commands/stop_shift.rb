module WoerkClient
  module Commands
    class StopShift
      prepend SimpleCommand

      def call
        if current_shift.nil?
          return errors.add(:stop, 'No running shift found.')
        end

        shift = WoerkClient::Models::Shift.new('id' => current_shift['id'])
        shift.params['stopped_at'] = Time.now
        shift.save

      rescue RestClient::ExceptionWithResponse => e
        errors.add(:stop, e.message)
      end

      private

      ##
      # Gets the current shift from all shifts
      #
      # @return [Hash] The current shift as Hash representation
      def current_shift
        JSON.parse(shifts).find { |s| s['stopped_at'] == 0 }
      end

      ##
      # Gets all the shifts from current user
      #
      # @return [String] The response from the server
      def shifts
        WoerkClient::Client.get(WoerkClient::Models::Shift::RESOURCE_PATH)
      end
    end
  end
end
