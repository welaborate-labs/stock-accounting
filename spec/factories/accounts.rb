FactoryBot.define do
  factory :account do
    user
    name { "MyFactoryName" }
    document { "12345678910" }
    address { "MyFactoryAddress MyFactoryAddress2" }
    address_complement { "MyFactoryComplement" }
    city { "MyFactoryCity" }
    state { "MyFactoryState" }
    country { "MyFactoryCountry" }
    zipcode { "12345678" }
    phone_personal { "1147474747" }
    phone_business { "1247474748" }
    phone_mobile { "13998765432" }
    status { "Active" } 
  end
end
