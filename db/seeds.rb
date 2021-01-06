# this must be used after the server is up to use the redis for the attachment
# user for tests purposes using identity
# email: test@identity pass: 1234567890
User.create!(name: 'Test Seed', email: 'test@seed.com')
puts 'User created successfully'

Identity.create!(name: 'Test Identity', email: 'test@identity.com', password_digest: '1234567890')
puts 'Identity created successfully'

Authentication.create!(user: User.last, uid: '123456789101112131415', provider: 'identity') 
puts "Authentication by 'identity' created successfully"

Authentication.create!(user: User.last, uid: '12345678910', provider: 'facebook') 
puts "Authentication by 'facebook' created successfully"

Account.create!(user_id: User.last.id, name: 'Test Account',
                document: '123.456.789-01',
                address: 'address', 
                address_complement: 'address complement',
                city: 'city', state: 'state', country: 'country',
                zipcode: '00000-000',
                phone_personal: '11 1111-1111', 
                phone_business: '22 2222-2222', 
                phone_mobile:   '33 3333-3333',
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

Trade.create!(statement_id: Statement.last.id, 
              ticker: 'ticker1',
              direction: 1,
              open: true,
              close: false,
              quantity: 4,
              price: 44,
              transacted_at: DateTime.now)  
puts "Trade open created successfully"
Trade.create!(statement_id: Statement.last.id, 
              ticker: 'ticker2',
              direction: 1,
              open: false,
              close: true,
              quantity: 4,
              price: 44,
              transacted_at: DateTime.now)  
puts "Trade close created successfully"
