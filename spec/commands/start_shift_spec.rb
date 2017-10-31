# frozen_string_literal: true

require 'spec_helper'

RSpec.describe WoerkClient::Commands::StartShift do
  let(:command) { described_class.call }

  context 'when api call is successful' do
    before do
      allow(WoerkClient::Models::Shift)
        .to receive_message_chain(:new, :save)
    end

    it 'creates a new shift' do
      command

      expect(WoerkClient::Models::Shift)
        .to have_received(:new)
    end

    it 'is successful' do
      expect(command.success?).to eq(true)
    end
  end

  context 'when api call is not successful' do
    before do
      allow(WoerkClient::Models::Shift)
        .to receive_message_chain(:new, :save)
        .and_raise(RestClient::ExceptionWithResponse, '422')
    end

    it 'is not successful' do
      expect(command.success?).to eq(false)
    end
  end
end
