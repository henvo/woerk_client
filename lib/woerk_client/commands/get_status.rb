module WoerkClient
  module Commands
    class GetStatus
      prepend SimpleCommand

      def call
        status
      rescue RestClient::ExceptionWithResponse => e
        errors.add(:start, e.message)
      end

      private

      # @return [String] The current status
      def status
        %Q(Currently working? #{currently_working?}
Working since #{current_working_duration})
      end

      # @return [String] Current working duration
      def current_working_duration
        return '-' if current_shift.nil?

        start = current_shift['started_at']/1000
        diff  = (Time.now.to_i - start)/60

        "#{diff} minutes".colorize(:green)
      end

      ##
      # Rerturns the answer as String
      #
      # @return [String]
      def currently_working?
        current_shift.nil? ? 'no'.colorize(:red) : 'yes'.colorize(:green)
      end

      ##
      # Fetches the current shift from the shifts array
      #
      # @return [Hash] The current shift
      def current_shift
        @current ||= shifts.find { |s| s['stopped_at'] == 0 }
      end

      ##
      # Gets all the shifts
      #
      # @return [Array] All shifts as Hashes
      def shifts
        @shifts ||= JSON.parse(
          WoerkClient::Client.get(WoerkClient::Models::Shift::RESOURCE_PATH)
        )
      end
    end
  end
end
