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

end
