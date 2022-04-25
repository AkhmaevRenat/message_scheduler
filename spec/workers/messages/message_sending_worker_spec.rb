require 'rails_helper'

RSpec.describe Messages::MessageSendingWorker do
  subject { worker.perform(message_id) }

  let(:worker) { described_class.new }
  let(:send_message) { instance_double(SendMessage) }
  let(:client) { instance_double(Clients::FakeClient)}

  before do
    allow(SendMessage).to receive(:new).and_return(send_message)
    allow(send_message).to receive(:call)
    allow(Clients::FakeClient).to receive(:new).and_return(client)
  end

  context 'when message exists' do
    let(:message) { create(:message) }
    let(:message_id) { message.id }

    it 'sends message and writes log' do
      subject

      expect(SendMessage).to have_received(:new).with(client: client)
      expect(send_message).to have_received(:call).with(message: message)
    end
  end

  context "when message doesn't exist" do
    let(:message_id) { -1 }

    it "doesn't send message" do
      expect { subject }.to raise_error(ActiveRecord::RecordNotFound)

      expect(send_message).not_to have_received(:call)
    end
  end
end
