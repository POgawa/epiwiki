require 'spec_helper'

describe 'the edit article path', type: :feature do
  it 'visits the edit article page' do
    article = Article.create name: 'stuff', content: 'blah blah'
    visit("/articles/#{article.id}/edit")
    expect(page).to have_content article.name
  end

  it 'edits an article' do
    article = Article.create name: 'stuff', content: 'blah blah'
    visit("/articles/#{article.id}/edit")
    fill_in 'new_content', with: 'go home'
    click_button 'submit'
    expect(page).to have_content "go home"
  end

  

end
