require 'rails_helper'

RSpec.describe "Pages", type: :request do

  describe "Home page" do
    before { visit root_path }

    it "should have the content 'TookieTi!'" do
      expect(page).to have_content("TookieTi!")
    end

    it "should have title 'Tookieti'" do
      expect(page).to have_title("TookieTi!")
    end
  end

  describe "About page" do
    before { visit about_path }
    
    it "should have the content 'About'" do
      expect(page).to have_content('About')
    end

    it "should have title 'About | TookieTi!'" do
      expect(page).to have_title(full_title("About"))
    end
  end
end
