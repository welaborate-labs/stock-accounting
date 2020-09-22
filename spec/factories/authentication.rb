FactoryBot.define do
  factory :authentication do
    uid { '123456789' }
    provider { 'google' }
    user
  end
end
