require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  
  describe "the login process" do
    it "does not logs in with invalid information" do
      get login_path
      expect(response).to render_template(:new)
      post login_path, session: { email: "", password: "" }
      expect(response).to render_template(:new)
      expect(flash[:alert]).to_not be_nil
      get root_path
      expect(flash[:alert]).to be_nil
    end

    it "logs in successfully with valid information" do
      user = FactoryGirl.create(:user,
                                :first_name => "Julito",
                                :last_name => "Triculi", 
                                :email => "triculito@gmail.com",
                                :password_digest => User.digest("password"))
      get login_path
      expect(response).to render_template("sessions/new")
      post login_path, session: { email: user.email, password: "password" }
      expect(response).to redirect_to(user)
      follow_redirect!
      expect(response).to render_template("users/show")
      assert logged_in?
    end
  end
end
