FactoryBot.define do
  factory :statement_file do
    created_at { DateTime.now }
    updated_at { DateTime.now }

    trait :with_attachment do
      after :build do |statement_file|
        file_name = 'modelo.pdf'
        file_path = Rails.root.join('spec', 'fixtures', 'files', file_name)
        statement_file.attach_file.attach(io: File.open(file_path), filename: file_name, content_type: 'application/pdf')
      end
    end
  end
end
