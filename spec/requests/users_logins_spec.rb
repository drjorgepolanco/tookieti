require 'rails_helper'

RSpec.describe "Users Logins", type: :request do

  before do
    @user = FactoryGirl.create(:user, 
                               :first_name => "Julito",
                               :last_name => "Triculi", 
                               :email => "triculito@gmail.com",
                               :password_digest => User.digest("password"))
  end

  context "when filling the form" do
    before do
      get login_path
    end

    it "should render login form" do
      expect(response).to render_template(:new)
    end

    context "when fields are empty" do
      it "should stay in the form and flash msg should not persist" do
        post login_path, session: { 
          email: "", 
          password: "" 
        }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to_not be_nil
        get root_path
        expect(flash[:alert]).to be_nil
      end
    end

    context "when info is valid" do
      before {
        post login_path, session: { 
          email: @user.email, 
          password: "password" 
        }
      }

      it "user should be taken to his profile" do
        expect(is_logged_in?).to be(true)
        expect(response).to redirect_to(@user)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(response.body).to include("Log out")
        expect(response.body).to include("Profile")
      end

      context "followed by logout" do
        before do
          expect(response).to redirect_to(@user)
          follow_redirect!
          delete logout_path
        end

        it "should log the user out and redirect to root" do
          expect(is_logged_in?).to be(false)
          expect(response).to redirect_to(root_path)
        end

        context "when user logs out twice from different browsers" do
          before { delete logout_path }

          it "should keep the user logged out" do
            follow_redirect!
            expect(response.body).to include("Log In")
            expect(response.body).to include("Sign Up")
          end          
        end
      end
    end

    context "when remember is checked" do
      it "should log the user in and create remember token" do
        log_in_as(@user, remember_me: '1')
        expect(cookies['remember_token']).to eq(assigns(:user).remember_token)
      end
    end

    context "when remember is not checked" do
      it "should only log the user in" do
        log_in_as(@user, remember_me: '0')
        expect(cookies['remember_token']).to be(nil)
      end
    end
  end
end
