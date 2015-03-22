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
  end
end
