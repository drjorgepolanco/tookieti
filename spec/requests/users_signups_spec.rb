require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do

  before { ActionMailer::Base.deliveries.clear }

  describe "signing up with invalid information" do
    it "should not work and should go back to the signup form" do
      get signup_path
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

  describe "signing up with valid information and account activation" do
    it "should work and should redirect to user's show view" do
      get signup_path
      expect do
        post users_path, user: { 
          first_name:            "Julito",
          last_name:             "Triculi",
          email:                 "triculito@gmail.com",
          password:              "worldtriculi",
          password_confirmation: "worldtriculi"
        }
      end.to change{ User.count }.from(0).to(1)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      user = assigns(:user)
      expect(user.activated?).to be(false)
      log_in_as(user)
      expect(is_logged_in?).to be(false)
      get edit_account_activation_path("anytokenbutthecorrectone")
      expect(is_logged_in?).to be(false)
      get edit_account_activation_path(user.activation_token, email: "yoohoo")
      expect(is_logged_in?).to be(false)
      get edit_account_activation_path(user.activation_token, email: user.email)
      expect(user.reload.activated?).to be(true)
      follow_redirect!
      expect(response).to render_template(:show)
      expect(is_logged_in?).to be(true)
    end
  end
end
