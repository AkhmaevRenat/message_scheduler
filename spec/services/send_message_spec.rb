require 'rails_helper'

RSpec.describe SendMessage do
  subject { described_class.new(client: client).call(message: message) }

  let(:message) { create(:message) }
  let(:client) { Clients::FakeClient.new }

  before do
    allow(Rails.logger).to receive(:info)
    allow(Rails.logger).to receive(:fatal)
  end

  context 'when client successfully sends message' do
    it 'updates message status to success' do
      subject
      expect(message.status).to eq(:success)
      expect(Rails.logger).to have_received(:info).with('Message is sent')
    end
  end

  context 'when client send_message raises error' do
    before do
      allow(client).to receive(:send_message).and_raise(Clients::Error, 'test_error')
    end

    it 'updates message status to failed and logs error' do
      subject
      expect(message.status).to eq(:failed)
      expect(Rails.logger).to have_received(:fatal).with("Сообщение #{message.id} не было отправлено, error=test_error")
    end
  end
end
