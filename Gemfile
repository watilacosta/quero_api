source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3" # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "pg", "~> 1.1" # Use postgresql as the database for Active Record
gem "puma", "~> 5.0" # Use the Puma web server [https://github.com/puma/puma]
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ] # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'rubocop'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem "rspec-rails", "~> 5.1"
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
  gem 'database_cleaner-active_record'
  gem 'rspec-json_expectations'
end
