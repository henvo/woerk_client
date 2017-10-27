# frozen_string_literal: true

require 'spec_helper'

RSpec.describe WoerkClient::Shift do
  it 'has a resource path' do
    expect(described_class::RESOURCE_PATH).to be
  end

  describe '.start' do
    before do
      allow(WoerkClient::Client)
        .to receive(:post)

      described_class.start
    end

    it 'calls the client with right params' do
      expect(WoerkClient::Client)
        .to have_received(:post)
        .with(
          payload: hash_including(:shift),
          path: '/shifts'
        )
    end
  end

  describe '.stop' do
    before do
      allow(WoerkClient::Client)
        .to receive(:get)
        .and_return(
          double(:response, body: [{ 'stopped_at' => 0, id: 123 }].to_json)
        )

      allow(WoerkClient::Client).to receive(:put)

      described_class.stop
    end

    it 'calls the client with right params' do
      expect(WoerkClient::Client)
        .to have_received(:put)
        .with(
          payload: Hash,
          path: '/shifts/123'
        )
    end
  end
end
