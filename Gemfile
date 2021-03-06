source 'https://rubygems.org'

gem 'rails', '4.2.5.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'slim-rails' # Templating library
gem 'f00px', git: "git://github.com/500px/f00px.git" # 500px API client
gem 'bourbon' # CSS helper functions
gem 'neat' # CSS grid framework
gem 'normalize-rails' # CSS reset (kinda)
gem 'omniauth' # oAuth library
gem 'omniauth-500px' # 500px omniauth strategy
gem 'font-awesome-rails' # Icons and view helpers

group :development, :test do
  gem 'sqlite3' # Simple on-file database for dev.
  gem 'pry-remote' # Debugger that works nicely with Pow
  gem 'dotenv-rails' # Loads environment variables from a .env file
end

group :test do
  gem 'capybara' # Interact with web pages in our tests
  gem 'rspec-rails' # Testing framework
  gem 'simplecov', require: false # Code coverage metrics
  gem 'simplecov-console', require: false # Output code coverage report on the CLI.
end

group :development do
  gem 'web-console', '~> 2.0'
end

group :production do
  gem 'rails_12factor' # Some 12-factor-app helpers, to make deploying to Heroku easier.
  gem 'pg' # Heroku uses Postgres for its database
end
