FactoryBot.define do
  factory :statement do
    statement_date { "2020-09-22 14:34:19" }
    statement_file
    brokerage_account
    content { '123456 12/12/2020 123.123.123-12' }
  end
end
