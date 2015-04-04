require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  describe "Header" do
    it "should have the right links" do
      visit root_path
      click_link "CocinitApp!"
      expect(page).to have_link("CocinitApp!", href: root_path)
      expect(page).to have_title(full_title(""))
      click_link "Nosotros"
      expect(page).to have_link("Nosotros", href: about_path)
      expect(page).to have_title(full_title('Nosotros'))
      click_link "Registro"
      expect(page).to have_title(full_title('Registro'))
    end
  end
end
