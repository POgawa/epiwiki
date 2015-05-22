require 'spec_helper'

describe 'the single article path', type: :feature do
  it 'displays the number of revisions the article has had' do
    article1 = Article.create name: 'stuff', content: 'blah blah'
    article2 = Article.create name: 'stuff', content: 'blah blahblah yakity shmakity'
    article3 = Article.create name: 'stuff', content: 'yakity shmakity'
    visit "/articles/#{article1.id}"
    expect(page).to have_content "This article has 2 revision(s)"
  end

  it 'displays the list of article revisions' do
    article1 = Article.create name: 'stuff', content: 'a',
                              revision_description: 'create article'
    article2 = Article.create name: 'stuff', content: 'b',
                              revision_description: 'increment letter'
    visit "/articles/#{article1.id}"
    expect(page).to have_content "create article increment letter"
  end

  it 'clicks through to an individual revision page' do
    article1 = Article.create name: 'stuff', content: 'a',
                              revision_description: 'create initial article'
    article2 = Article.create name: 'stuff', content: 'b',
                              revision_description: 'increment letter'
    visit "/articles/#{article1.id}"
    click_link('create initial article')
    expect(page).to have_content article1.content
  end
end
