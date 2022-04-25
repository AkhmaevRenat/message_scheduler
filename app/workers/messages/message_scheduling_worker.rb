module Messages
  class MessageSchedulingWorker
    include Sidekiq::Worker

    def perform(start_of_interval, end_of_interval, messages_count)
      for i in (1..messages_count)
        time = rand(start_of_interval..end_of_interval)
        Rails.logger.info("Creating of the #{i} message will take #{time} seconds")
        MessageCreatingWorker.perform_async(time)
      end
    end
  end
end
