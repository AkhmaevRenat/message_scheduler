FactoryBot.define do
  factory :message do
    body { SecureRandom.uuid }
  end
end
