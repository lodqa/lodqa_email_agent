source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.5'
# Use Puma as the app server
gem 'puma'

gem 'rest-client'
gem 'inifile'

group :development do
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'dotenv-rails'
  gem 'webmock'
  gem 'rspec-rails'
end

group :test do
  gem 'rspec_junit_formatter'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
