require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do

  describe "Authentication" do
    subject { page }

    describe "log in page" do
      before { visit login_path }

      it { is_expected.to have_content('Log In')            }
      it { is_expected.to have_title(full_title('Log In'))  }
      it { is_expected.to have_link('Sign Up Now!', signup_path) }
    end

    describe "login" do
      before { visit login_path }

      describe "when information is invalid" do
        before { click_button "Log In" }

        it { is_expected.to have_title('Log In') }
        it { is_expected.to have_selector('div.alert-box', text: "Invalid") }
      end
    end
  end
end
