source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'dotenv-rails', groups: [:development, :test]
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'omniauth', '~> 1.9', '>= 1.9.1'
gem 'omniauth-facebook', '~> 7.0'
gem 'omniauth-google-oauth2', '~> 0.8.0'
gem 'omniauth-identity', '~> 2.0'
gem 'pdf-reader', '~> 2.4', '>= 2.4.1'
gem 'redis'
gem 'sidekiq'
gem 'active_storage_validations', '~> 0.9.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'awesome_print', '~> 1.8'
gem 'pagy', '~> 3.10'
gem 'rails-i18n'

group :development, :test do
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'factory_bot_rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'database_cleaner-active_record', '~> 1.8'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener_web', '~> 1.4'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]