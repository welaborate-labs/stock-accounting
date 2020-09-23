RSpec.configure do |config|
  config.before(:each) do
    OmniAuth.config.mock_auth[:google] = nil
  end
end
