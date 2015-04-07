require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { is_expected.to have_content("Registro")              }
    it { is_expected.to have_title(full_title("Registro"))    }
    it { is_expected.to have_link('Entra ahora!', login_path) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before     { visit user_path(user)     }

    it { is_expected.to have_title(full_title(full_name(user)))    }
    it { is_expected.to have_selector('h1', text: full_name(user)) }
  end

  describe "the process of signing up" do
    let(:submit) { "Crear cuenta"    }
    before       { visit signup_path }

    describe "with valid info" do
      before do
        fill_in "Nombre",               with: "Julito"
        fill_in "Apellido",             with: "Triculi"
        fill_in "Email",                with: "triculito@mail.com"
        fill_in "Password",             with: "worldtriculi"
        fill_in "Confirma el password", with: "worldtriculi"
      end

      it "should create a new user" do
        expect { click_button(submit) }.to change(User, :count).by(1) 
      end
    end

    describe "with invalid info" do
      it "shouldn't create any user" do
        expect { click_button(submit) }.not_to change(User, :count)
      end
    end
  end
end
