module Messages
    class MessageSendingWorker
        include Sidekiq::Worker
        def perform(message_id)
            message = Message.find(message_id)
            SendMessage.new(client: Clients::FakeClient.new).call(message: message)
            Rails.logger.info('Message is sent')
        end
    end
end