source 'https://rubygems.org'
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '1.1.1'
# Use Puma as the app server
gem 'puma', '3.12.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.7.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '3.1.12'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.3.1', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '1.0.2'
# for jwt
gem 'jwt', '2.1.0'
# for service objects
gem 'simple_command', '0.0.9'
# for env variables
gem 'figaro', '1.1.1'
# for authorizations
gem 'pundit', '2.0.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '10.0.2', platforms: [:mri, :mingw, :x64_mingw]
  # rspec tests
  gem 'rspec-rails', '3.8.0'
  gem 'shoulda-matchers', '3.1.2'
  gem 'factory_bot_rails', '4.11.0'
end

group :development do
  gem 'listen', '3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'spring-commands-rspec', '1.0.4'
  # to view emails in browser
  gem 'letter_opener', '1.6.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '1.2018.5', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
