FactoryBot.define do
  factory :trade do
    statement
    ticker { "MyString" }
    direction { 1 }
    status { 0 }
    quantity { 100 }
    price { 10 }
    transacted_at { "2020-09-22 15:01:11" }
  end
end
