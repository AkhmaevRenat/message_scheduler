class Message < ApplicationRecord
    as_enum :status, %w(created success failed)
end
