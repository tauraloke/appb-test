FactoryBot.define do
  factory :user do
    username { SecureRandom.uuid }
  end
end
