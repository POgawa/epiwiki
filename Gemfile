source 'https://rubygems.org'


gem 'sinatra-activerecord'
gem("sinatra-contrib", require: "sinatra/reloader")
gem('pg')
gem 'rake'

group(:production) do
  gem 'sinatra'
end

group(:test) do
  gem 'rspec'
  gem 'capybara', require: "capybara/rspec"
  gem 'pry'
  gem 'shoulda-matchers'
end
