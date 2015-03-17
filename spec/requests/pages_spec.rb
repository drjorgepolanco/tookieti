require 'rails_helper'

RSpec.describe "Pages", type: :request do

  let(:base_title) { "Tookieti" }

  describe "Home page" do
    before { visit root_path }

    it "should have the content 'Tookieti'" do
      expect(page).to have_content("#{base_title}")
    end

    it "should have title 'Tookieti'" do
      expect(page).to have_title("#{base_title}")
    end
  end

  describe "About page" do
    before { visit about_path }
    
    it "should have the content 'About'" do
      expect(page).to have_content('About')
    end

    it "should have title 'About | Tookieti'" do
      expect(page).to have_title("About | #{base_title}")
    end
  end
end
