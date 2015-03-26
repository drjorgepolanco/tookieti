require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  describe "Header" do
    it "should have the right links" do
      visit root_path
      click_link "Home"
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_title(full_title(""))
      click_link "About"
      expect(page).to have_link("About", href: about_path)
      expect(page).to have_title(full_title('About'))
      click_link "Sign Up"
      expect(page).to have_title(full_title('Sign Up'))
    end
  end
end
