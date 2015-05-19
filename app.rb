require 'bundler/setup'
require 'pry'
Bundler.require(:default, :production)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



get('/') do
  erb(:index)
end

get('/results/:search_word') do |search_word|
  @tags = Tag.all
  # binding.pry
  # @results = Tag.all
  @result = Tag.find_by(topic: search_word)
  erb(:results)
end

post('/results') do
  search_word = params.fetch("search_word")
  @result = Tag.find_by(topic: search_word)
  redirect "/results/#{search_word}"
end

get('/articles/new') do
  @tags = Tag.all
  erb(:article_form)
end

get('/tags/new') do

end
