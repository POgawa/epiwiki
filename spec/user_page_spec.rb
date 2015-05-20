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
end
