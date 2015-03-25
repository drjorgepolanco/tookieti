require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do

  before do
    @user = FactoryGirl.create(:user, :first_name => "Julito",
                               :last_name => "Triculi", 
                               :email => "triculito@gmail.com",
                               :password_digest => User.digest("password"))
  end
  
  it "does not happen with invalid information" do
    get login_path
    expect(response).to render_template(:new)
    post login_path, session: { email: "", password: "" }
    expect(response).to render_template(:new)
    expect(flash[:alert]).to_not be_nil
    get root_path
    expect(flash[:alert]).to be_nil
  end

  it "happen successfully with valid information" do
    get login_path
    expect(response).to render_template("sessions/new")
    post login_path, session: { email: @user.email, password: "password" }
    expect(response).to redirect_to(@user)
    follow_redirect!
    expect(response).to render_template("users/show")
    expect(is_logged_in?).to be(true)
    delete logout_path
    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response).to render_template("pages/home")
  end

  it "happen with remembering" do
    log_in_as(@user, remember_me: '1')
    expect(cookies['remember_token']).to_not be(nil)
  end

  it "happen without remembering" do
    log_in_as(@user, remember_me: '0')
    expect(cookies['remember_token']).to be(nil)
  end
end
