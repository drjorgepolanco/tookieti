require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

  before do
    ActionMailer::Base.deliveries.clear
    @user = FactoryGirl.create(:user)
  end

  describe "requesting password reset" do

    before do
      get new_password_reset_path
      expect(response).to render_template(:new)
    end

    context "when email is invalid" do
      it "should display flash message and return to form" do
        post password_resets_path, password_reset: { email: "" }
        expect(flash).to_not be(nil)
        expect(response).to render_template(:new)
      end
    end

    context "when email is valid" do
      it "should send password reset link and redirect to root" do
        post password_resets_path, password_reset: { email: @user.email }
        expect(@user.reload.reset_digest).to eq(@user.reset_digest)
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        expect(flash).to_not be(nil)
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "getting the password reset form" do

    before do
      get new_password_reset_path
      post password_resets_path, password_reset: { email: @user.email }
      @user = assigns(:user)
    end

    context "when email is wrong" do
      it "should redirect to root" do
        get edit_password_reset_path(@user.reset_token, email: "")
        expect(response).to redirect_to(root_url)
      end
    end

    context "when user is inactive" do
      it "should redirect to root" do
        @user.toggle!(:activated)
        get edit_password_reset_path(@user.reset_token, email: @user.email)
        expect(response).to redirect_to(root_url)
      end
    end

    context "when email is right and token is wrong" do
      it "should redirect to root" do
        get edit_password_reset_path('tukitoken', email: @user.email)
        expect(response).to redirect_to(root_url)
      end
    end

    context "when both email and token are correct" do
      it "should render the edit form to create a new password" do
        get edit_password_reset_path(@user.reset_token, email: @user.email)
        expect(response).to render_template(:edit)
        expect(response.body).to include('<input type="hidden" name="email" id="email" value="triculito@mail.com" />')
      end
    end

    context "when token is expired" do
      it "should include the word expired" do
        @user.update_attribute(:reset_sent_at, 3.hours.ago)
        patch password_reset_path(@user.reset_token),
              email: @user.email,
              user: { 
                password:           "password",
                password_confirmation: "password"
              }
        expect(response).to be_redirect
        follow_redirect!
        expect(response.body).to include('expired')
      end
    end
  end

  describe "creating the new password" do

    before do
      get new_password_reset_path
      post password_resets_path, password_reset: { email: @user.email }
      @user = assigns(:user)
      get edit_password_reset_path(@user.reset_token, email: @user.email)
    end

    context "when password and confirmation doesn't match" do
      it "should display error message" do
        patch password_reset_path(@user.reset_token),
            email: @user.email,
            user: {
              password:              "worldtriculi",
              password_confirmation: "triculito"
            }
        expect(response.body).to include("<div id='error_explanation'>")
        expect(flash).to_not be(nil)
      end
    end

    context "when password is blank" do
      it "should display flash message and stay in the form" do
        patch password_reset_path(@user.reset_token),
            email: @user.email,
            user: { 
              password:              "",
              password_confirmation: "triculito" 
            }
        expect(flash).to_not be(nil)
        expect(response).to render_template(:edit)
      end
    end

    context "when password and confirmation match" do
      it "should log the user in and redirect to user profile" do
        patch password_reset_path(@user.reset_token),
              email: @user.email,
              user: {
                password:              "triculito",
                password_confirmation: "triculito"
              }
        expect(is_logged_in?).to be(true)
        expect(flash).to_not be(nil)
        expect(response).to redirect_to(@user)
      end
    end
  end
end
