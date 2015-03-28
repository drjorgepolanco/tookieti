require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do 
    @user       = FactoryGirl.create(:user,
                                     admin:           true)
    @other_user = FactoryGirl.create(:user, 
                                     first_name:      "Joselito",
                                     last_name:       "Trediente",
                                     email:           "josediente@mail.com",
                                     password_digest: User.digest('password'))
  end

  it "should get new" do
    get :new
    expect(response.status).to eq(200)
    expect(response).to render_template(:new)
  end

  it "should redirect to index when the user is not logged in" do
    get :index
    expect(response).to redirect_to(login_path)
  end

  describe "when user is not logged in" do
    it "should redirect edit" do
      get :edit, id: @user
      expect(flash[:alert]).to_not be_empty
    end

    it "should redirect update" do
      patch :update, id: @user, user: { first_name: @user.first_name,
                                        last_name:  @user.last_name,
                                        email:      @user.email
                                      }
      expect(flash[:alert]).to_not be_empty
      expect(response).to redirect_to(login_path)
    end
  end

  describe "when logged in as a wrong user" do
    it "should redirect edit" do
      log_in_as(@other_user)
      get :edit, id: @user
      expect(flash).to be_empty
      expect(response).to redirect_to(root_path)
    end

    it "should redirect update" do
      log_in_as(@other_user)
      patch :update, id: @user, user: { first_name: @user.first_name, 
                                        last_name:  @user.last_name,
                                        email:      @user.email 
                                      }
      expect(flash).to be_empty
      expect(response).to redirect_to(root_path)
    end
  end

  describe "destroying users" do
    it "should redirect when user is not logged in" do
      expect{ delete :destroy, id: @user }.to_not change{ User.count }
      expect(response).to redirect_to(login_url)
    end

    it "should redirect when user is not admin" do
      log_in_as(@other_user)
      expect{ delete :destroy, id: @user }.to_not change{ User.count }
      expect(response).to redirect_to(root_url)
    end
  end
end