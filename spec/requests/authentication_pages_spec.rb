require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do

  describe "Authentication" do
    subject { page }

    describe "log in page" do
      before { visit login_path }

      it { is_expected.to have_content('Entra a tu cuenta')     }
      it { is_expected.to have_title(full_title('Entrar'))      }
      it { is_expected.to have_link('Regístrate!', signup_path) }
    end

    describe "login" do
      before { visit login_path }

      describe "when information is invalid" do
        before { click_button "Entrar" }

        it { is_expected.to have_title('Entrar') }
        it { is_expected.to have_selector('div.alert-box', text: "Invalid") }
      end

      describe "when information is valid" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email
          fill_in "Password", with: "password"
          click_button "Entrar"
        end

        it { is_expected.to     have_link('Perfil', href: user_path(user)) }
        it { is_expected.to     have_link('Salir',  href: logout_path)     }
        it { is_expected.to_not have_link('Entrar', href: login_path)      }

        describe "followed by log out" do
          before { click_link "Salir" }
          it { is_expected.to     have_link("Entrar", href: login_path)      }
          it { is_expected.to_not have_link("Perfil", href: user_path(user)) }
        end
      end
    end
  end
end
