FactoryBot.define do
  factory :statement_file do
    trait :with_file do
      after :build do |statement_file|
        file_name = 'modelo.pdf'
        file_path = Rails.root.join('spec', 'fixtures', 'files', file_name)
        statement_file.file.attach(io: File.open(file_path), filename: file_name, content_type: 'application/pdf')
      end
    end
  end
end
