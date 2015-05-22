require "spec_helper"
require('./app')

describe('overall page testing', {type: :feature} ) do
  describe('visiting the homepage') do
    it('checks that the homepage is working') do
      visit '/'
      expect(page).to have_content("Epicodus Reference Wiki")
    end
  end
  describe('the search path') do
    it('searches for a tag, displays results') do
      tag = Tag.create(topic: 'activerecord')
      tag2 = Tag.create(topic: 'sinatra')
      tag2.articles.create(name: 'sinatra', content: 'Stuff')
      visit('/')
      fill_in('search_word', with: 'sinatra')
      click_button('Search')
      expect(page).to have_content('Articles with the sinatra tag:')
    end
  end

end
