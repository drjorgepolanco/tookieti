require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  describe "Header" do
    it "should have the right links" do
      visit root_path
      click_link "Home"
      expect(page).to have_title(full_title(""))
      click_link "About"
      expect(page).to have_title(full_title('About'))
    end
  end
end
