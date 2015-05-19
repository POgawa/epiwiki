ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require(:default, :test)
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file}


RSpec.configure do |config|
  config.after(:each) do
    Article.all().each() do |article|
      article.destroy()
    end
    Tag.all().each() do |tag|
      tag.destroy()
    end
    User.all().each() do |user|
      user.destroy()
    end
  end
end
