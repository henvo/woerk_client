# frozen_string_literal: true

require 'spec_helper'

RSpec.describe WoerkClient::Models::Shift do
  let(:shift) { described_class.new({ foo: 'bar' }) }

  it 'has a resource path' do
    expect(described_class::RESOURCE_PATH).to be
  end

  describe '#save' do
    context 'when shift has ID' do
      before do
        shift.params['id'] = '123'
      end

      it 'calls the client with PUT' do
        allow(WoerkClient::Client).to receive(:put)

        shift.save

        expect(WoerkClient::Client).to have_received(:put)
      end
    end

    context 'when shift is new' do
      it 'calls the client with POST' do
        allow(WoerkClient::Client).to receive(:post)

        shift.save

        expect(WoerkClient::Client).to have_received(:post)
      end
    end
  end
end
