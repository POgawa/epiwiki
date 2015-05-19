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
  erb(:tag_form)
end

post('/tags') do
  tag_name = params.fetch("tag_name")
  Tag.create({:topic => tag_name})
  @tags = Tag.all
  erb(:index)
end

post('/articles') do
  name = params.fetch("article_name")
  content = params.fetch("article_content")
  @article = Article.new({:name => name, :content => content})
  tag_id = params.fetch("tag_id")
  tag_id.each do |id|
    tag = Tag.find(id)
    @article.tags.push(tag)
  end
  if @article.save()
    redirect to("/articles/#{@article.id}")
  else
    @articles = Article.all()
  end
  erb(:article)
end

get('/articles/:id') do
  @article = Article.find(params.fetch("id").to_i())
  erb(:article)
end
