require 'rails_helper'

RSpec.describe "Pages", type: :request do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { is_expected.to have_content("TookieTi!") }
    it { is_expected.to have_title(full_title("")) }
  end

  describe "About page" do
    before { visit about_path }

    it { is_expected.to have_content("About") }
    it { is_expected.to have_title(full_title("About")) }
  end
end
