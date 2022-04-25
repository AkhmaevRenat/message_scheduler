require "rails_helper" 

RSpec.describe Messages::MessageCreatingWorker do
    subject { worker.perform(1) }
  
    let(:worker) { described_class.new }
  
  
    it 'creates message and sends it' do
      expect { subject }.to change(Message, :count).from(0).to(1)
      message = Message.last
  
      expect(message.status).to eq(:created)
      expect(Messages::MessageSendingWorker).to have_enqueued_sidekiq_job(message.id)
    end
  end