require 'bundler/setup'
require 'pry'
Bundler.require(:default, :production)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



get('/') do
  erb(:index)
end

get('/results') do
  @tags = Tag.all
  erb(:results)
end

post('/results') do
  search_word = params.fetch("search_word")
  erb(:results)
end

get('/articles/new') do
  @tags = Tag.all
  erb(:article_form)
end

get('/tags/new') do
  
end
