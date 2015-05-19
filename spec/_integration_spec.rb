require "{insert the name of the model.rb here}"
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
