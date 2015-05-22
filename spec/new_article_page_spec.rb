require 'spec_helper'

describe 'the add article path', type: :feature do
  it 'visits the new article page' do
    visit "/articles/new"
    expect(page).to have_content('Add a New Article')
  end

  it 'adds a new article' do
    User.create name: 'Whykins'
    visit "/articles/new"
    fill_in 'article_name', with: 'testing'
    fill_in 'article_content', with: 'Test everything, including your tests'
    select('Whykins', from: 'user_id')
    click_button 'Submit Article'
    expect(page).to have_content "testing By Whykins"
  end
end
