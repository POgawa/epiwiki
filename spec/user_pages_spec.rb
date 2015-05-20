require "spec_helper"

describe('overall user testing', type: :feature ) do
  describe('the add user path') do
    it('adds a new user') do
      visit('/add_user')
      fill_in('name', with: 'Paul')
      click_button('Add')
      expect(page).to have_content("Paul")
    end
  end

  describe('the users path') do
    it('lists all the users') do
      User.create name: 'cory'
      visit('/users')
      expect(page).to have_content('cory')
    end
  end

  describe('the single user path') do
    it('displays a single user') do
      test_user = User.create name: 'cory'
      visit("/user/#{test_user.id}")
      expect(page).to have_content('cory')
    end

    it('displays the articles written or edited by user') do
      test_user = User.create name: 'cory'
      test_article = test_user.articles().create({name: 'testing', content:'capybara is fun!!!!'})
      visit("/user/#{test_user.id}")
      expect(page).to have_content(test_article.name)
    end

  end






end
