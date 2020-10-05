FactoryBot.define do
  factory :user do
    name { "Paul Atreides" }
    sequence :email do |n|
      "myemail#{n}@sa.com"
    end
  end
end
