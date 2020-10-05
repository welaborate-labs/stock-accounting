FactoryBot.define do
  factory :account do
    user
    name { "MyString" }
    document { "MyString" }
    address { "MyText" }
    address_complement { "MyText" }
    city { "MyString" }
    state { "MyString" }
    country { "MyString" }
    zipcode { "MyString" }
    phone_personal { "MyString" }
    phone_business { "MyString" }
    phone_mobile { "MyString" }
    status { "MyString" } 
  end
end
