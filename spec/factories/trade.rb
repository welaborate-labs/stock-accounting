FactoryBot.define do
  factory :trade do
    statement
    ticker { "MyString" }
    direction { 1 }
    open { false }
    close { false }
    quantity { 1 }
    price { 1 }
    transacted_at { "2020-09-22 15:01:11" }
  end
end
