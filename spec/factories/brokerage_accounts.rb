FactoryBot.define do
  factory :brokerage_account do
    account
    brokerage { 123456 }
    number { "1234567-8" }
    account_number { "123.123.123-12" }
  end
end
