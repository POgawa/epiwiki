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
  @tags = Tag.all
  erb(:index)
end

get('/results/:search_word') do |search_word|
  @tags = Tag.all
  @result = Tag.find_by(topic: search_word)
  #  @result = Tag.where(search_word LIKE :topic)
  erb(:results)
end

post('/results') do
  search_word = params.fetch("search_word")
  @result = Tag.find_by(topic: search_word)
  redirect "/results/#{search_word}"
end

get('/articles/new') do
  @tags = Tag.all
  @users = User.all
  erb(:article_form)
end

get('/tags/new') do
  erb(:tag_form)
end

post('/tags') do
  tag_name = params.fetch("tag_name")
  Tag.create({:topic => tag_name})
  @tags = Tag.all
  redirect to("/")
  erb(:index)
end

post('/articles') do
  name = params.fetch("article_name")
  content = params.fetch("article_content")
  @article = Article.new({:name => name, :content => content})
  if params.has_key?('tag_id')
    tag_id = params.fetch("tag_id")
    tag_id.each do |id|
      tag = Tag.find(id)
      @article.tags.push(tag)
    end
  end
  user_id = params.fetch("user_id")
  user = User.find(user_id)
  @article.users.push(user)
  if @article.save()
    redirect "/articles/#{@article.id}"
  else
    @articles = Article.all()
    redirect "/articles/new"
  end
end

get('/articles/:id') do
  @article = Article.find(params.fetch("id").to_i())
  @revisions = @article.user_revisions
  erb :article
end


get('/articles/:id/edit') do |id|
  @article = Article.find(id)
  # This should be in article/id but not in edit
  # @revisions = @article.user_revisions
  erb :article_edit
end

post('/articles/:id/edit') do |id|
  article = Article.find(id)
  if params.fetch('new_content').length > 0
    content = params.fetch('new_content')
  else
    redirect "/articles/#{id}"
  end
  revised_article = Article.create(
                name: article.name,
                content: content,
                revision_description: params.fetch('description'))
  redirect "/articles/#{revised_article.id}"
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

get('/user/:id') do |id|
  @user = User.find(id)
  erb :single_user
end

get('/admin') do
  protected!
  @articles = Article.all
  binding.pry
  @tags = Tag.all
  @users = User.all
  erb(:admin)
end

delete('/delete_article') do
  article_id = params.fetch("article_id")
  article_id.each do |article|
    @article = Article.find(article)
    @article.delete
  end
  @articles = Article.all
  redirect 'admin'
end

delete('/delete_tag') do
  tag_id = params.fetch("tag_id")
  tag_id.each do |tag|
    @tag = Tag.find(tag)
    @tag.delete
  end
  @tags = Tag.all
  redirect 'admin'
end

delete('/delete_user') do
  user_id = params.fetch("user_id")
  user_id.each do |user|
    @user = User.find(user)
    @user.delete
  end
  @users = User.all
  redirect 'admin'
end

delete '/article/delete/:id' do |id|
  protected!
  @article = Article.find(id)
  @article.delete
  redirect '/'
end
