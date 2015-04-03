require 'rails_helper'

RSpec.describe "Pages", type: :request do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { is_expected.to have_content("CocinitApp!") }
    it { is_expected.to have_title(full_title("")) }
  end

  describe "About page" do
    before { visit about_path }

    it { is_expected.to have_content("Nosotros") }
    it { is_expected.to have_title(full_title("Nosotros")) }
  end
end
