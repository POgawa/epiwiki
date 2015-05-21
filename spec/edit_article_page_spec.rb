require 'spec_helper'

describe 'the edit article path', type: :feature do
  it 'visits the edit article page' do
    article = Article.create name: 'stuff', content: 'blah blah'
    visit("/articles/#{article.id}/edit")
    expect(page).to have_content article.name
  end

end
