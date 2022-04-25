module Messages
  class MessageCreatingWorker
    include Sidekiq::Worker
    
    def perform(time)
      Rails.logger.info("Message is creating")
      sleep(time)
      message = Message.create(body: "test")
      Rails.logger.info('Message created')
      MessageSendingWorker.perform_async(message.id)
    end
  end
end
