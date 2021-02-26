# this must be used after the server is up to use the redis for the attachment
# user for tests purposes using identity
# email: test@identity pass: 1234567890
Authentication.create!(user: User.last, uid: '123456789101112131415', provider: 'identity') 
puts "Authentication by 'identity' created successfully"
Authentication.create!(user: User.last, uid: '12345678910', provider: 'facebook') 
puts "Authentication by 'facebook' created successfully"
Account.create!(user_id: User.last.id, name: 'Test Account',
                document: '123.456.789-01',
                status: 'active') 
puts "Account created successfully"
BrokerageAccount.create!(account_id: Account.last.id, brokerage: 123456, number: '123456-7')
puts "BrokerageAccount created successfully"
statement_file = StatementFile.new(account_id: Account.last.id, processed_at: DateTime.now)
statement_file.file.attach(io: File.open(Rails.root.join 'spec/fixtures/files/modelo.pdf'), filename: 'modelo.pdf', content_type: 'application/pdf')
statement_file.save!
puts "StatementFile created successfully"
Statement.create!(statement_date: DateTime.now,
                  number: '123456',
                  brokerage_account_id: BrokerageAccount.last.id)
puts "Statement created successfully"
15.times do |index|
  Trade.create!(statement_id: Statement.last.id, 
                ticker: "abc#{index}",
                direction: 1,
                status: 0,
                quantity: index,
                price: 1+index,
                transacted_at: DateTime.now)
end
puts "Trades open created successfully"
15.times do |index|
  Trade.create!(statement_id: Statement.last.id, 
                ticker: "#{index}abc",
                direction: 1,
                status: 1,
                quantity: index,
                price: 3+index,
                transacted_at: DateTime.now)
end 
puts "Trades close created successfully"
