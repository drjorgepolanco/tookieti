require 'rails_helper'

RSpec.describe "Users Logins", type: :request do

  before do
    @user = FactoryGirl.create(:user, :first_name => "Julito",
                               :last_name => "Triculi", 
                               :email => "triculito@gmail.com",
                               :password_digest => User.digest("password"))
  end

  describe "with invalid information" do
    it "should not work and flash msg should not persist" do
      get login_path
      expect(response).to render_template(:new)
      post login_path, session: { email: "", password: "" }
      expect(response).to render_template(:new)
      expect(flash[:alert]).to_not be_nil
      get root_path
      expect(flash[:alert]).to be_nil
    end
  end

  describe "with valid information followed by logout" do
    it "should work and first redirect to user's show and then to root" do
      get login_path
      expect(response).to render_template(:new)
      post login_path, session: { email: @user.email, password: "password" }
      expect(is_logged_in?).to be(true)
      expect(response).to redirect_to(@user)
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include("Log out")
      expect(response.body).to include("Profile")
      delete logout_path
      expect(is_logged_in?).to be(false)
      expect(response).to redirect_to(root_path)
      delete logout_path
      follow_redirect!
      expect(response.body).to include("Log In")
      expect(response.body).to include("Sign Up")
    end
  end

  it "is possible with remembering" do
    log_in_as(@user, remember_me: '1')
    expect(cookies['remember_token']).to eq(assigns(:user).remember_token)
  end

  it "is possible without remembering" do
    log_in_as(@user, remember_me: '0')
    expect(cookies['remember_token']).to be(nil)
  end
end
