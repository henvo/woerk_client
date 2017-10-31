# frozen_string_literal: true

require 'spec_helper'

RSpec.describe WoerkClient::Client do
  before do
    allow(RestClient::Request).to receive(:execute)
    allow(YAML)
      .to receive(:load_file)
      .and_return({ AUTH_TOKEN: 'foo', API_HOST: 'localhost' })
  end

  describe '.get' do
    it 'gets the right object' do
      allow(described_class).to receive_message_chain(:new, :call)
      described_class.get('/shifts')
      expect(described_class).to have_received(:new)
    end
  end

  describe '.post' do
    it 'creates the right object' do
      allow(described_class).to receive_message_chain(:new, :call)
      described_class.post(path: '/shifts', payload: { foo: true })
      expect(described_class).to have_received(:new)
    end
  end

  describe '.put' do
    it 'updates the right object' do
      allow(described_class).to receive_message_chain(:new, :call)
      described_class.put(path: '/shifts/123', payload: { foo: false } )
      expect(described_class).to have_received(:new)
    end
  end

  describe '.delete' do
    it 'deletes the right object' do
      allow(described_class).to receive_message_chain(:new, :call)
      described_class.delete('/shifts/123')
      expect(described_class).to have_received(:new)
    end
  end

  describe '.call' do
    before do
      described_class.call
    end

    it 'calls the API with the default params' do
      expect(RestClient::Request)
        .to have_received(:execute)
        .with(
          method: :get,
          url: WoerkClient.configuration.api_host + '/',
          payload: nil,
          headers: hash_including(:Accept, :Authorization)
        )
    end
  end
end

