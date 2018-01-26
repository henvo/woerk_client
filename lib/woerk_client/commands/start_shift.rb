# frozen_string_literal: true

module WoerkClient
  module Commands
    class StartShift
      prepend SimpleCommand

      def call
        start_shift
      rescue RestClient::ExceptionWithResponse => e
        errors.add(:start, e.message)
      end

      private

      def start_shift
        if shift.save
          "Shift started"
        end
      end

      def shift
        WoerkClient::Models::Shift.new(started_at: Time.now)
      end
    end
  end
end
