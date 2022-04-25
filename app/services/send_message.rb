class SendMessage
  def initialize(client: Clients::FakeClient.new)
    @client = client
  end

  def call(message:)
    @client.send_message(message: message.body)

    message.update!(status: :success)
    Rails.logger.info('Message is sent')
    rescue Clients::Error => e
      Rails.logger.fatal("Сообщение #{message.id} не было отправлено, error=#{e.message}")
  
      message.update!(status: :failed)
  end
end
