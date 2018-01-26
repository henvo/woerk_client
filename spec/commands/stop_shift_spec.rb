# frozen_string_literal: true

require 'spec_helper'

RSpec.describe WoerkClient::Commands::StopShift do
  let(:command) { described_class.call }

  context 'when error occurs' do
    before do
      allow(WoerkClient::Client)
        .to receive(:get)
        .and_raise(RestClient::ExceptionWithResponse, '404')
    end

    it 'is not successful' do
      expect(command.success?).to eq(false)
    end
  end

  context 'when no running shift exists' do
    before do
      allow(WoerkClient::Client)
        .to receive(:get)
        .and_return('[{"stopped_at": 123}]')
    end

    it 'is not successful' do
      expect(command.success?).to eq(false)
    end

    it 'adds an descriptive error' do
      expect(command.errors.length).to eq(1)
    end
  end

  context 'when api call is successful' do
    before do
      allow(WoerkClient::Client)
        .to receive(:put)
        .and_return(true)

      allow(WoerkClient::Client)
        .to receive(:get)
        .and_return('[{"id": 12, "stopped_at": 0}]')
    end

    it 'is successful' do
      expect(command.success?).to eq(true)
    end

    it 'returns a status message' do
      expect(command.result).to eq('Shift stopped')
    end
  end
end
