require 'rails_helper'

RSpec.describe Messages::MessageSchedulingWorker do
  subject { worker.perform(start_of_interval, end_of_interval, count) }

  let(:worker) { described_class.new }

  let(:start_of_interval) { 100 }
  let(:end_of_interval) { 150 }
  let(:count) { 5 }

  before do
    allow(worker).to receive(:rand).and_return(120)
    allow(MessageCreatingWorker).to receive(:perform_async)
    allow(Rails.logger).to receive(:info)
  end

  it 'enqueues MessageCreatingWorker with valid_params' do
    subject

    expect(worker).to have_received(:rand).with(100..150).exactly(5).times
    expect(MessageCreatingWorker).to have_received(:perform_async).with(120).exactly(5).times

    for i in (1..count)
      expect(Rails.logger).to have_received(:info).with("Creating of the #{i} message will take 120 seconds")
    end
  end
end
