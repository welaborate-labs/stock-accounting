Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
  on_failure { |env| SessionsController.action(:failure).call(env) }

  # OmniAuth.config.on_failure = Proc.new { |env|
  #   OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  # }
end

OmniAuth.config.logger = Rails.logger
