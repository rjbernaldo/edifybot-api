source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '4.2.6'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'httparty'
gem 'chronic'
gem 'rack-cors'

group :production do
  gem 'pg', '0.18.4'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'sqlite3', '1.3.11'
  gem 'byebug'
  gem 'webmock'
end

group :development do
  gem 'guard-rspec', require: false
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'factory_girl_rails'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end
