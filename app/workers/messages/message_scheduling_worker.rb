module Messages
    class MessageSchedulingWorker
        include Sidekiq::Worker
        def perform(a, b, n)
            for i in (1..n)
                time = rand(a..b)
                Rails.logger.info("Creating of the #{i} message will take #{time} seconds")
                MessageCreatingWorker.perform_async(time)
            end
        end
    end
end