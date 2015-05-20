require 'bundler/setup'
require 'pry'
Bundler.require(:default, :production)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

# from www.sinatrarb.com/faq.html#auth
helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, erb(:index)
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
  end
end

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
  protected!
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

get('/articles/:id') do
  @article = Article.find(params.fetch("id").to_i())
  erb :article
end

get('/add_user') do
  erb :user_form
end

get('/users') do
  @users = User.all
  erb(:all_users)
end

post('/users') do
  User.create(name: params.fetch('user_name'))
  redirect 'users'
end
