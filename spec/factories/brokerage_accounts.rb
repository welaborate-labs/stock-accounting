FactoryBot.define do
  factory :brokerage_account do
    account
    brokerage { 1 }
    number { "MyString" }
  end
end
