# frozen_string_literal: true

module WoerkClient
  module Commands
    class StartShift
      prepend SimpleCommand

      def call
        shift.save
      rescue RestClient::ExceptionWithResponse => e
        errors.add(:start, e.message)
      end

      private

      def shift
        WoerkClient::Models::Shift.new(started_at: Time.now)
      end
    end
  end
end
