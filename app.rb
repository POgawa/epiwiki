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
  erb(:tag_form)
end

post('/tags') do
  tag_name = params.fetch("tag_name")
  Tag.create({:name => tag_name})
  @tags = Tag.all
  erb(:index)
end

get('/articles/:id') do
  @article = Article.find(params.fetch("id").to_i())
  erb(:article)
end
