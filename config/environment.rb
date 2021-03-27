# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


Rails.application.configure do
	config.active_storage.service = :test
	config.action_controller.perform_caching = true
end
