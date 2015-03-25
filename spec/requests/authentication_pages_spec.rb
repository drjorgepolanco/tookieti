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

      describe "when information is valid" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Log In"
        end

        it { is_expected.to     have_link('Profile', href: user_path(user)) }
        it { is_expected.to     have_link('Log out', href: logout_path)     }
        it { is_expected.to_not have_link('Log In',  href: login_path)      }

        describe "followed by log out" do
          before { click_link "Log out" }
          it { is_expected.to     have_link("Log In",  href: login_path)      }
          it { is_expected.to_not have_link("Profile", href: user_path(user)) }
        end
      end
    end
  end
end
