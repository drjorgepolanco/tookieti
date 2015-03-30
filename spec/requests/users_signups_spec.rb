require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do

  before do
    ActionMailer::Base.deliveries.clear
    get signup_path
  end

  context "when info is not valid" do
    it "should not change user's count and display errors" do
      expect do
        post users_path, user: { 
          first_name:            "",
          last_name:             "miki",
          email:                 "user@triculi",
          password:              "buajaja",
          password_confirmation: "juababa" 
        }
      end.to_not change{ User.count }
      expect(response).to render_template(:new)
      expect(response.body).to include('errors')
    end
  end

  context "when info is valid" do
    before do
      expect do
        post users_path, user: { 
          first_name:            "Julito",
          last_name:             "Triculi",
          email:                 "triculito@gmail.com",
          password:              "worldtriculi",
          password_confirmation: "worldtriculi"
        }
      end.to change{ User.count }.from(0).to(1)
    end

    it "should send account activation email" do
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end

    context "right after account activation email has been sent" do
      before do
        @user = assigns(:user)
      end

      it "user should not be activated" do
        expect(@user.activated?).to be(false)
      end

      it "should not allow user to log in before account activation" do
        log_in_as(@user)
        expect(is_logged_in?).to be(false)
      end

      describe "account activation" do
        context "when token is not correct" do
          it "should not allow user to log in" do
            get edit_account_activation_path("anytokenbutthecorrectone")
            expect(is_logged_in?).to be(false)
          end
        end

        context "when email is not correct" do
          it "should not allow user to log in" do
            get edit_account_activation_path(@user.activation_token, email: "yoohoo")
            expect(is_logged_in?).to be(false)
          end
        end

        context "when both email and token are correct" do
          it "should activate and log user in" do
            get edit_account_activation_path(@user.activation_token, email: @user.email)
            expect(@user.reload.activated?).to be(true)
            follow_redirect!
            expect(response).to render_template(:show)
            expect(is_logged_in?).to be(true)
          end
        end
      end
    end
  end
end
