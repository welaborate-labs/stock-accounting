FactoryBot.define do
  factory :brokerage_account do
    brokerage { 1 }
    number { "1234567-8" }
    account
  end
end
