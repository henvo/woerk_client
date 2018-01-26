# frozen_string_literal: true

require 'spec_helper'

RSpec.describe WoerkClient::Commands::StartShift do
  let(:command) { described_class.call }

  context 'when api call is successful' do
    before do
      allow(WoerkClient::Client)
        .to receive(:post)
        .and_return(true)
    end

    it 'command is successful' do
      expect(command.success?).to eq(true)
    end

    it 'returns a status message' do
      expect(command.result).to eq('Shift started')
    end
  end

  context 'when api call is not successful' do
    before do
      allow(WoerkClient::Client)
        .to receive(:post)
        .and_raise(RestClient::ExceptionWithResponse, '422')
    end

    it 'command is NOT successful' do
      expect(command.success?).to eq(false)
    end
  end
end
