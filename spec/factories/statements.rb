FactoryBot.define do
  factory :statement do
    sequence :content do |n|
      "client_number= 1234567-8
      statement_date= 12/10/2020 
      cnpj_or_cpf = 123.123.123-12
      statement_number= 12345#{n}"
    end
    sequence :number do |n|
      "01234#{n}"
    end
    brokerage_account
    statement_date { '06/01/2021' }
  end
end
