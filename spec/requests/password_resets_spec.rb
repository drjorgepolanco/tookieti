require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  before do
    ActionMailer::Base.deliveries.clear
    @user = FactoryGirl.create(:user)
  end

  describe "password resets" do
    it "should not work with invalid info or expired token and should work with the opposite" do
      get new_password_reset_path
      expect(response).to render_template(:new)

      # invalid email
      post password_resets_path, password_reset: { email: "" }
      expect(flash).to_not be(nil)
      expect(response).to render_template(:new)

      # valid email
      post password_resets_path, password_reset: { email: @user.email }
      expect(@user.reload.reset_digest).to eq(@user.reset_digest)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(flash).to_not be(nil)
      expect(response).to redirect_to(root_url)

      # password reset form
      user = assigns(:user)

      # wrong email
      get edit_password_reset_path(user.reset_token, email: "")
      expect(response).to redirect_to(root_url)

      # inactive user
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(response).to redirect_to(root_url)
      user.toggle!(:activated)

      # right email, wrong token
      get edit_password_reset_path('tukitoken', email: user.email)
      expect(response).to redirect_to(root_url)

      # right email, right token
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(response).to render_template(:edit)
      expect(response.body).to include('<input type="hidden" name="email" id="email" value="triculito@mail.com" />')

      # invalid password & confirmation
      patch password_reset_path(user.reset_token),
            email: user.email,
            user: {
              password:              "worldtriculi",
              password_confirmation: "triculito"
            }
      expect(response.body).to include("<div id='error_explanation'>")
      expect(flash).to_not be(nil)

      # blank password
      patch password_reset_path(user.reset_token),
            email: user.email,
            user: { 
              password:              "",
              password_confirmation: "triculito" 
            }
      expect(flash).to_not be(nil)
      expect(response).to render_template(:edit)

      # valid password & confirmation
      patch password_reset_path(user.reset_token),
            email: user.email,
            user: {
              password:              "triculito",
              password_confirmation: "triculito"
            }
      expect(is_logged_in?).to be(true)
      expect(flash).to_not be(nil)
      expect(response).to redirect_to(user)
    end
  end
end
